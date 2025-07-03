import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/multiplication_challenge_provider.dart';

class MultiplicationChallengePage extends ConsumerStatefulWidget {
  const MultiplicationChallengePage({super.key});

  @override
  ConsumerState<MultiplicationChallengePage> createState() =>
      _MultiplicationChallengePageState();
}

class _MultiplicationChallengePageState
    extends ConsumerState<MultiplicationChallengePage> {
  final TextEditingController _answerController = TextEditingController();
  final FocusNode _answerFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _answerFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _answerController.dispose();
    _answerFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // challengeStateAsyncValue は AsyncValue<MultiplicationChallengeState> 型になります
    final challengeStateAsyncValue = ref.watch(
      multiplicationChallengeNotifierProvider,
    );
    final challengeNotifier = ref.read(
      multiplicationChallengeNotifierProvider.notifier,
    );

    // チャレンジ完了時のリダイレクト
    // ここも AsyncValue の状態をリッスンするように変更
    ref.listen<AsyncValue<MultiplicationChallengeState>>(
      multiplicationChallengeNotifierProvider,
      (previous, next) {
        // AsyncData の時のみ処理
        if (next.hasValue && next.value!.isChallengeComplete && mounted) {
          GoRouter.of(context).replace(
            '/result',
            extra: {
              'correctAnswers':
                  next.value!.correctAnswers, // .value! で実際の状態にアクセス
              'totalProblems': next.value!.totalProblems, // .value! で実際の状態にアクセス
              'starsEarned':
                  (next.value!.correctAnswers == next.value!.totalProblems)
                  ? 3
                  : (next.value!.correctAnswers >=
                        next.value!.totalProblems * 0.7)
                  ? 2
                  : (next.value!.correctAnswers >=
                        next.value!.totalProblems * 0.5)
                  ? 1
                  : 0,
            },
          );
        } else if (next.hasError && mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('エラー: ${next.error}')));
        }
      },
    );

    // AsyncValue の状態に応じて UI を構築
    return challengeStateAsyncValue.when(
      data: (challengeState) {
        // data コールバックで実際の challengeState を取得
        if (challengeState.problems.isEmpty && !challengeState.isLoading) {
          return Scaffold(
            appBar: AppBar(title: const Text('かけ算チャレンジ')),
            body: const Center(child: Text('問題がありません。前の画面に戻って選択してください。')),
          );
        }

        if (challengeState.isLoading) {
          return Scaffold(
            appBar: AppBar(title: const Text('問題準備中')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final currentProblem = challengeState.currentProblem;
        if (currentProblem == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('かけ算チャレンジ')),
            body: const Center(child: Text('問題の読み込みに失敗しました。')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              '問題 ${challengeState.currentProblemNumber} / ${challengeState.totalProblems}',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        Text(
                          '問題',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '${currentProblem.factor1} × ${currentProblem.factor2} = ?',
                          style: Theme.of(context).textTheme.displayLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _answerController,
                  focusNode: _answerFocusNode,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: '答えを入力',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.blueAccent,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.deepPurple,
                        width: 3,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                  onSubmitted: (_) => _submitAnswer(challengeNotifier),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => _submitAnswer(challengeNotifier),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    '回答する',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                if (challengeState.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      challengeState.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
      loading: () => Scaffold(
        // ロード中はプログレスインジケーターを表示
        appBar: AppBar(title: const Text('問題準備中')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        // エラー発生時はエラーメッセージを表示
        appBar: AppBar(title: const Text('エラー')),
        body: Center(child: Text('エラー: $err')),
      ),
    );
  }

  void _submitAnswer(MultiplicationChallengeNotifier notifier) {
    final userAnswer = int.tryParse(_answerController.text);
    if (userAnswer != null) {
      notifier.checkAnswer(userAnswer);
      _answerController.clear();
      _answerFocusNode.requestFocus();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('数字を入力してください。')));
    }
  }
}
