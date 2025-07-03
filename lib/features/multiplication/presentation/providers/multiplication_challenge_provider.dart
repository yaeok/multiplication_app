import 'package:multiplication_app/features/multiplication/domain/entities/challenge_result/challenge_result.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/multiplication_problem/multiplication_problem.dart';
import 'package:multiplication_app/features/multiplication/domain/usecases/get_multiplication_problems.dart';
import 'package:multiplication_app/features/multiplication/domain/usecases/save_challenge_result.dart';
import 'package:multiplication_app/features/multiplication/domain/usecases/update_stars.dart';
import 'package:multiplication_app/features/multiplication/presentation/providers/user_provider.dart';
import 'package:multiplication_app/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'multiplication_challenge_provider.g.dart';
part 'multiplication_challenge_provider.freezed.dart';

@riverpod
class MultiplicationChallengeNotifier
    extends _$MultiplicationChallengeNotifier {
  late final GetMultiplicationProblems _getMultiplicationProblems;
  late final UpdateStars _updateStars;
  late final SaveChallengeResult _saveChallengeResult;

  @override
  FutureOr<MultiplicationChallengeState> build() async {
    _getMultiplicationProblems = await ref.read(
      getMultiplicationProblemsUseCaseProvider.future,
    );
    _updateStars = await ref.read(updateStarsUseCaseProvider.future);
    _saveChallengeResult = await ref.read(
      saveChallengeResultUseCaseProvider.future,
    );
    return const MultiplicationChallengeState();
  }

  Future<void> startChallenge(int table, int count) async {
    // 修正: challengeTable を設定
    state = AsyncData(
      MultiplicationChallengeState(
        // const を削除
        problems: [],
        currentProblemIndex: 0,
        correctAnswers: 0,
        isChallengeComplete: false,
        errorMessage: null,
        isLoading: true,
        challengeTable: table, // challengeTable を設定
      ),
    );

    print('startChallenge called for table: $table, count: $count');

    final failureOrProblems = await _getMultiplicationProblems(
      GetMultiplicationProblemsParams(table: table, count: count),
    );

    failureOrProblems.fold(
      (failure) {
        state = AsyncData(
          state.value!.copyWith(
            errorMessage: '問題の取得に失敗しました。',
            isLoading: false,
          ),
        );
        print('Error fetching problems: $failure');
      },
      (problems) {
        print('Problems received from repository: ${problems.length}');
        state = AsyncData(
          state.value!.copyWith(problems: problems, isLoading: false),
        );
        print(
          'Notifier state updated with problems.length: ${state.value!.problems.length}',
        );
      },
    );
  }

  Future<void> checkAnswer(int userAnswer) async {
    if (!state.hasValue ||
        state.value!.isChallengeComplete ||
        state.value!.currentProblem == null) {
      return;
    }

    print(
      'Check answer: currentProblemIndex: ${state.value!.currentProblemIndex}, problems.length: ${state.value!.problems.length}',
    );

    int newCorrectAnswers = state.value!.correctAnswers;
    if (userAnswer == state.value!.currentProblem!.answer) {
      newCorrectAnswers++;
    }

    if (state.value!.currentProblemIndex == state.value!.problems.length - 1) {
      state = AsyncData(
        state.value!.copyWith(
          isChallengeComplete: true,
          correctAnswers: newCorrectAnswers,
        ),
      );
      print('Challenge complete after processing last problem.');
    } else {
      state = AsyncData(
        state.value!.copyWith(
          currentProblemIndex: state.value!.currentProblemIndex + 1,
          correctAnswers: newCorrectAnswers,
        ),
      );
      print(
        'Moving to next problem. New index: ${state.value!.currentProblemIndex + 1}',
      );
    }

    // ★★★ 星の計算ロジックの修正 ★★★
    int starsEarned = 0;
    int? earnedTableId; // 獲得した段位のID
    bool isTableAlreadyCompleted = false;

    // 全問正解かつ、それが特定の段位のチャレンジである場合 (ランダムチャレンジは除外)
    if (newCorrectAnswers == state.value!.totalProblems &&
        state.value!.challengeTable > 0) {
      final userNotifier = ref.read(userNotifierProvider.notifier);
      final currentUser = userNotifier.state.value;

      if (currentUser != null) {
        // その段位が既に取得済みでないかチェック
        if (!currentUser.completedTables.contains(
          state.value!.challengeTable,
        )) {
          starsEarned = 1; // 星を1つ獲得
          earnedTableId = state.value!.challengeTable; // 獲得した段位IDを記録
        } else {
          isTableAlreadyCompleted = true; // 既に取得済み
          print(
            'Star for table ${state.value!.challengeTable} already acquired.',
          );
        }
      }
    }
    // ★★★ 星の計算ロジック修正終わり ★★★

    final userNotifier = ref.read(userNotifierProvider.notifier);
    final currentUser = userNotifier.state.value;

    // 星を獲得した場合のみ updateStars を呼ぶ
    if (starsEarned > 0) {
      final failureOrUser = await _updateStars(
        UpdateStarsParams(
          starsToAdd: starsEarned,
          tableId: earnedTableId,
          isTableCompleted: earnedTableId != null, // 段位を獲得したことを示す
        ),
      );
      failureOrUser.fold(
        (failure) {
          state = AsyncData(
            state.value!.copyWith(errorMessage: '星の更新に失敗しました。'),
          );
          print('Error updating stars: $failure');
        },
        (updatedUser) {
          userNotifier.updateCurrentUser(updatedUser);
        },
      );
    } else if (isTableAlreadyCompleted) {
      // 星は獲得しないが、デバッグログ目的でメッセージ出力
      print(
        'Challenge completed, but star for this table was already acquired.',
      );
    }

    // チャレンジ結果を保存
    final result = ChallengeResult(
      correctAnswers: newCorrectAnswers,
      totalProblems: state.value!.totalProblems,
      starsEarned: starsEarned, // 実際に獲得した星の数を結果に渡す
      timestamp: DateTime.now(),
    );
    await _saveChallengeResult(SaveChallengeResultParams(result: result));
  }
}

@freezed
class MultiplicationChallengeState with _$MultiplicationChallengeState {
  const factory MultiplicationChallengeState({
    @Default([]) List<MultiplicationProblem> problems,
    @Default(0) int currentProblemIndex,
    @Default(0) int correctAnswers,
    @Default(false) bool isChallengeComplete,
    String? errorMessage,
    @Default(false) bool isLoading,
    @Default(0) int challengeTable, // 新しいフィールド: 何の段位に挑戦しているか (0はランダム)
  }) = _MultiplicationChallengeState;

  const MultiplicationChallengeState._();

  MultiplicationProblem? get currentProblem =>
      problems.isNotEmpty ? problems[currentProblemIndex] : null;
  int get currentProblemNumber => currentProblemIndex + 1;
  int get totalProblems => problems.length;
}
