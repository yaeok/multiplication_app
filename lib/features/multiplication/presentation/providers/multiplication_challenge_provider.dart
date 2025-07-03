import 'package:multiplication_app/features/multiplication/domain/entities/challenge_result/challenge_result.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/multiplication_problem/multiplication_problem.dart';
import 'package:multiplication_app/features/multiplication/domain/usecases/get_multiplication_problems.dart';
import 'package:multiplication_app/features/multiplication/domain/usecases/save_challenge_result.dart';
import 'package:multiplication_app/features/multiplication/domain/usecases/update_stars.dart';
import 'package:multiplication_app/features/multiplication/presentation/providers/user_provider.dart';
import 'package:multiplication_app/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart'; // freezed_annotationをインポート

part 'multiplication_challenge_provider.g.dart';
part 'multiplication_challenge_provider.freezed.dart'; // ★この行を追加★

@riverpod
class MultiplicationChallengeNotifier
    extends _$MultiplicationChallengeNotifier {
  late final GetMultiplicationProblems _getMultiplicationProblems;
  late final UpdateStars _updateStars;
  late final SaveChallengeResult _saveChallengeResult; // 追加

  @override
  MultiplicationChallengeState build() {
    _getMultiplicationProblems = ref.read(
      getMultiplicationProblemsUseCaseProvider,
    );
    _updateStars = ref.read(updateStarsUseCaseProvider);
    _saveChallengeResult = ref.read(saveChallengeResultUseCaseProvider); // 初期化
    return const MultiplicationChallengeState();
  }

  Future<void> startChallenge(int table, int count) async {
    state = state.copyWith(
      problems: [],
      currentProblemIndex: 0,
      correctAnswers: 0,
      isChallengeComplete: false,
      errorMessage: null,
      isLoading: true, // ロード中フラグ
    );

    final failureOrProblems = await _getMultiplicationProblems(
      GetMultiplicationProblemsParams(table: table, count: count),
    );

    failureOrProblems.fold(
      (failure) {
        state = state.copyWith(errorMessage: '問題の取得に失敗しました。', isLoading: false);
        print('Error getting problems: $failure');
      },
      (problems) {
        state = state.copyWith(problems: problems, isLoading: false);
      },
    );
  }

  Future<void> checkAnswer(int userAnswer) async {
    if (state.isChallengeComplete || state.currentProblem == null) return;

    int newCorrectAnswers = state.correctAnswers;
    if (userAnswer == state.currentProblem!.answer) {
      newCorrectAnswers++;
    }

    if (state.currentProblemIndex < state.problems.length - 1) {
      state = state.copyWith(
        currentProblemIndex: state.currentProblemIndex + 1,
        correctAnswers: newCorrectAnswers,
      );
    } else {
      // チャレンジ完了
      state = state.copyWith(
        isChallengeComplete: true,
        correctAnswers: newCorrectAnswers,
      );

      // 星の計算ロジック
      int starsEarned = 0;
      if (newCorrectAnswers == state.totalProblems) {
        starsEarned = 3; // 全問正解で3つ星
      } else if (newCorrectAnswers >= state.totalProblems * 0.7) {
        starsEarned = 2; // 70%以上で2つ星
      } else if (newCorrectAnswers >= state.totalProblems * 0.5) {
        starsEarned = 1; // 50%以上で1つ星
      }

      // ユーザーの星を更新
      final userNotifier = ref.read(userNotifierProvider.notifier);
      final currentUser = userNotifier.state.value; // AsyncValueから値を取得
      if (currentUser != null && starsEarned > 0) {
        final failureOrUser = await _updateStars(
          UpdateStarsParams(starsToAdd: starsEarned),
        );
        failureOrUser.fold(
          (failure) {
            state = state.copyWith(errorMessage: '星の更新に失敗しました。');
            print('Error updating stars: $failure');
          },
          (updatedUser) {
            userNotifier.updateCurrentUser(
              updatedUser,
            ); // UserNotifierのユーザー情報を更新
          },
        );
      }

      // チャレンジ結果を保存
      final result = ChallengeResult(
        correctAnswers: newCorrectAnswers,
        totalProblems: state.totalProblems,
        starsEarned: starsEarned,
        timestamp: DateTime.now(),
      );
      await _saveChallengeResult(SaveChallengeResultParams(result: result));
    }
  }
}

// MultiplicationChallengeNotifierの状態を定義するフリーzedクラス
@freezed
class MultiplicationChallengeState with _$MultiplicationChallengeState {
  const factory MultiplicationChallengeState({
    @Default([]) List<MultiplicationProblem> problems,
    @Default(0) int currentProblemIndex,
    @Default(0) int correctAnswers,
    @Default(false) bool isChallengeComplete,
    String? errorMessage,
    @Default(false) bool isLoading,
  }) = _MultiplicationChallengeState;

  const MultiplicationChallengeState._(); // カスタムゲッターのために追加

  MultiplicationProblem? get currentProblem =>
      problems.isNotEmpty ? problems[currentProblemIndex] : null;
  int get currentProblemNumber => currentProblemIndex + 1;
  int get totalProblems => problems.length;
}
