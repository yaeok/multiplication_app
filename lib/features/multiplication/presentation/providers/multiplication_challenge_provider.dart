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
  // この行は自動生成される typedef に依存しますが、概念的には AutoDisposeAsyncNotifier を継承します。
  // もしコンパイルエラーになる場合は、extends AutoDisposeAsyncNotifier<MultiplicationChallengeState> に直接変更してください。
  // その後、build_runner を実行して、typedef が正しく AsyncNotifier を参照するようにしてください。
  late final GetMultiplicationProblems _getMultiplicationProblems;
  late final UpdateStars _updateStars;
  late final SaveChallengeResult _saveChallengeResult;

  @override
  FutureOr<MultiplicationChallengeState> build() async {
    // 戻り値の型を FutureOr に変更
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
    state = const AsyncData(
      MultiplicationChallengeState(
        problems: [],
        currentProblemIndex: 0,
        correctAnswers: 0,
        isChallengeComplete: false,
        errorMessage: null,
        isLoading: true, // ロード中フラグ
      ),
    );

    final failureOrProblems = await _getMultiplicationProblems(
      GetMultiplicationProblemsParams(table: table, count: count),
    );

    failureOrProblems.fold(
      (failure) {
        // 問題取得失敗時も安全に state を更新
        state = AsyncData(
          state.value!.copyWith(
            errorMessage: '問題の取得に失敗しました。',
            isLoading: false,
          ),
        );
      },
      (problems) {
        // 問題取得成功時も安全に state を更新
        state = AsyncData(
          state.value!.copyWith(problems: problems, isLoading: false),
        );
      },
    );
  }

  Future<void> checkAnswer(int userAnswer) async {
    // checkAnswer メソッド内の state.value! アクセスは、
    // startChallenge が成功裏に完了した後であれば安全です。
    // ... (既存の checkAnswer メソッドの内容)

    // 例: checkAnswer メソッド内の同様の修正箇所
    if (state.value!.isChallengeComplete || state.value!.currentProblem == null)
      return;

    int newCorrectAnswers = state.value!.correctAnswers;
    if (userAnswer == state.value!.currentProblem!.answer) {
      newCorrectAnswers++;
    }

    if (state.value!.currentProblemIndex < state.value!.problems.length - 1) {
      state = AsyncData(
        state.value!.copyWith(
          currentProblemIndex: state.value!.currentProblemIndex + 1,
          correctAnswers: newCorrectAnswers,
        ),
      );
    } else {
      state = AsyncData(
        state.value!.copyWith(
          isChallengeComplete: true,
          correctAnswers: newCorrectAnswers,
        ),
      );
    }

    int starsEarned = 0;
    if (newCorrectAnswers == state.value!.totalProblems) {
      starsEarned = 3;
    } else if (newCorrectAnswers >= state.value!.totalProblems * 0.7) {
      starsEarned = 2;
    } else if (newCorrectAnswers >= state.value!.totalProblems * 0.5) {
      starsEarned = 1;
    }

    final userNotifier = ref.read(userNotifierProvider.notifier);
    final currentUser = userNotifier.state.value;
    if (currentUser != null && starsEarned > 0) {
      final failureOrUser = await _updateStars(
        UpdateStarsParams(starsToAdd: starsEarned),
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
    }

    final result = ChallengeResult(
      correctAnswers: newCorrectAnswers,
      totalProblems: state.value!.totalProblems,
      starsEarned: starsEarned,
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
  }) = _MultiplicationChallengeState;

  const MultiplicationChallengeState._();

  MultiplicationProblem? get currentProblem =>
      problems.isNotEmpty ? problems[currentProblemIndex] : null;
  int get currentProblemNumber => currentProblemIndex + 1;
  int get totalProblems => problems.length;
}
