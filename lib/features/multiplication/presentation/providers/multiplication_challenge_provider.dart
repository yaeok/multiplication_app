import 'package:multiplication_app/features/multiplication/domain/entities/challenge_result/challenge_result.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/multiplication_problem/multiplication_problem.dart';
import 'package:multiplication_app/features/multiplication/domain/usecases/get_multiplication_problems.dart';
import 'package:multiplication_app/features/multiplication/domain/usecases/save_challenge_result.dart';
import 'package:multiplication_app/features/multiplication/domain/usecases/update_stars.dart';
import 'package:multiplication_app/features/multiplication/presentation/providers/user_provider.dart';
import 'package:multiplication_app/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/challenge_problem_result/challenge_problem_result.dart'; // このimportを追加

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
      getMultiplicationProblemsUseCaseProvider,
    );
    _updateStars = await ref.read(updateStarsUseCaseProvider);
    _saveChallengeResult = await ref.read(saveChallengeResultUseCaseProvider);
    return const MultiplicationChallengeState();
  }

  Future<void> startChallenge(int table, int count) async {
    state = AsyncData(
      MultiplicationChallengeState(
        problems: [],
        currentProblemIndex: 0,
        correctAnswers: 0,
        isChallengeComplete: false,
        errorMessage: null,
        isLoading: true,
        challengeTable: table,
        problemResults: [], // ここでproblemResultsを初期化
      ),
    );

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
      },
      (problems) {
        state = AsyncData(
          state.value!.copyWith(problems: problems, isLoading: false),
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

    int newCorrectAnswers = state.value!.correctAnswers;
    final isAnswerCorrect =
        (userAnswer == state.value!.currentProblem!.answer); // 回答が正しいか判断
    if (isAnswerCorrect) {
      // isAnswerCorrectを使用
      newCorrectAnswers++;
    }

    final newProblemResult = ChallengeProblemResult(
      // 新しい問題結果を作成
      problem: state.value!.currentProblem! as MultiplicationProblem,
      userAnswer: userAnswer,
      isCorrect: isAnswerCorrect,
    );
    List<ChallengeProblemResult> updatedProblemResults = List.from(
      state.value!.problemResults,
    )..add(newProblemResult); // リストに追加

    if (state.value!.currentProblemIndex == state.value!.problems.length - 1) {
      state = AsyncData(
        state.value!.copyWith(
          isChallengeComplete: true,
          correctAnswers: newCorrectAnswers,
          problemResults: updatedProblemResults, // problemResultsを更新
        ),
      );
    } else {
      state = AsyncData(
        state.value!.copyWith(
          currentProblemIndex: state.value!.currentProblemIndex + 1,
          correctAnswers: newCorrectAnswers,
          problemResults: updatedProblemResults, // problemResultsを更新
        ),
      );
    }

    int starsEarned = 0;
    int? earnedTableId;

    if (newCorrectAnswers == state.value!.totalProblems &&
        state.value!.challengeTable > 0) {
      final userNotifier = ref.read(userNotifierProvider.notifier);
      final currentUser = userNotifier.state.value;

      if (currentUser != null) {
        if (!currentUser.completedTables.contains(
          state.value!.challengeTable,
        )) {
          starsEarned = 1;
          earnedTableId = state.value!.challengeTable;
        }
      }
    }

    final userNotifier = ref.read(userNotifierProvider.notifier);

    if (starsEarned > 0) {
      final failureOrUser = await _updateStars(
        UpdateStarsParams(
          starsToAdd: starsEarned,
          tableId: earnedTableId,
          isTableCompleted: earnedTableId != null,
        ),
      );
      failureOrUser.fold(
        (failure) {
          state = AsyncData(
            state.value!.copyWith(errorMessage: '星の更新に失敗しました。'),
          );
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
    @Default(0) int challengeTable,
    @Default([]) List<ChallengeProblemResult> problemResults, // このフィールドを追加
  }) = _MultiplicationChallengeState;

  const MultiplicationChallengeState._();

  MultiplicationProblem? get currentProblem =>
      problems.isNotEmpty ? problems[currentProblemIndex] : null;
  int get currentProblemNumber => currentProblemIndex + 1;
  int get totalProblems => problems.length;
}
