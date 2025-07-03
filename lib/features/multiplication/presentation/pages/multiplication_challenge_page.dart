import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:multiplication_app/go_router.dart';
import '../providers/multiplication_challenge_provider.dart';

class MultiplicationChallengePage extends ConsumerStatefulWidget {
  const MultiplicationChallengePage({super.key});

  @override
  ConsumerState<MultiplicationChallengePage> createState() =>
      _MultiplicationChallengePageState();
}

class _MultiplicationChallengePageState
    extends ConsumerState<MultiplicationChallengePage> {
  String _currentAnswerInput = ''; // ユーザーの入力を保持する文字列

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 数字ボタンが押されたときの処理
  void _onNumberPressed(String number) {
    setState(() {
      // 3桁以上の入力は許可しない（例: 9x9=81 なので最大2桁）
      if (_currentAnswerInput.length < 3) {
        _currentAnswerInput += number;
      }
    });
  }

  // 削除ボタンが押されたときの処理
  void _onDeletePressed() {
    setState(() {
      if (_currentAnswerInput.isNotEmpty) {
        _currentAnswerInput = _currentAnswerInput.substring(
          0,
          _currentAnswerInput.length - 1,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final challengeStateAsyncValue = ref.watch(
      multiplicationChallengeNotifierProvider,
    );
    final challengeNotifier = ref.read(
      multiplicationChallengeNotifierProvider.notifier,
    );

    // チャレンジ完了時のリダイレクト
    ref.listen<
      AsyncValue<MultiplicationChallengeState>
    >(multiplicationChallengeNotifierProvider, (previous, next) async {
      print('Listener triggered. Previous state: $previous, Next state: $next');
      if (next.hasValue) {
        print(
          'Next state has value. isChallengeComplete: ${next.value!.isChallengeComplete}',
        );
      }

      if (next.hasValue && next.value!.isChallengeComplete && mounted) {
        print('Navigation condition met! Navigating to /result');
        await Future.delayed(const Duration(milliseconds: 50)); // UIが落ち着くのを待つ

        // 修正: グローバルキーの currentContext を使用して GoRouter にアクセス
        if (rootNavigatorKey.currentContext != null) {
          GoRouter.of(rootNavigatorKey.currentContext!).pushReplacement(
            // context の代わりに _rootNavigatorKey.currentContext を使用
            '/result',
            extra: {
              'correctAnswers': next.value!.correctAnswers,
              'totalProblems': next.value!.totalProblems,
              'starsEarned':
                  (next.value!.correctAnswers == next.value!.totalProblems)
                  ? 1
                  : 0,
            },
          );
        } else {
          print('Error: Root Navigator Context is null. Cannot navigate.');
        }
      } else if (next.hasError && mounted) {
        print('Listener detected error: ${next.error}');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('エラー: ${next.error}')));
      }
    });

    // AsyncValue の状態に応じて UI を構築
    return challengeStateAsyncValue.when(
      data: (challengeState) {
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

        // チャレンジ完了のチェック（RangeError対策）
        if (challengeState.isChallengeComplete) {
          return Scaffold(
            appBar: AppBar(title: const Text('チャレンジ完了')),
            body: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
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
                // TextField を削除し、Text ウィジェットで入力内容を表示
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _currentAnswerInput.isEmpty
                          ? Colors.blueAccent
                          : Colors.deepPurple,
                      width: _currentAnswerInput.isEmpty ? 2 : 3,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    _currentAnswerInput.isEmpty ? '答えを入力' : _currentAnswerInput,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: _currentAnswerInput.isEmpty
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // 数字キーパッドのレイアウト
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNumberButton('1', context),
                        _buildNumberButton('2', context),
                        _buildNumberButton('3', context),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNumberButton('4', context),
                        _buildNumberButton('5', context),
                        _buildNumberButton('6', context),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNumberButton('7', context),
                        _buildNumberButton('8', context),
                        _buildNumberButton('9', context),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNumberButton('0', context),
                        _buildActionButton(
                          '削除',
                          _onDeletePressed,
                          context,
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                        ),
                        _buildActionButton(
                          '回答',
                          () => _submitAnswer(challengeNotifier),
                          context,
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ],
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
        appBar: AppBar(title: const Text('問題準備中')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        appBar: AppBar(title: const Text('エラー')),
        body: Center(child: Text('エラー: $err')),
      ),
    );
  }

  // 数字ボタンを生成するヘルパーメソッド
  Widget _buildNumberButton(String number, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ElevatedButton(
          onPressed: () => _onNumberPressed(number),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey.shade50,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 20),
            textStyle: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(number),
        ),
      ),
    );
  }

  // アクションボタン（削除など）を生成するヘルパーメソッド
  Widget _buildActionButton(
    String text,
    VoidCallback onPressed,
    BuildContext context, {
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? Colors.grey,
            foregroundColor: foregroundColor ?? Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 20),
            textStyle: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(text),
        ),
      ),
    );
  }

  void _submitAnswer(MultiplicationChallengeNotifier notifier) {
    final userAnswer = int.tryParse(_currentAnswerInput);
    if (userAnswer != null) {
      notifier.checkAnswer(userAnswer);
      setState(() {
        _currentAnswerInput = ''; // 回答後、入力欄をクリア
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('数字を入力してください。')));
    }
  }
}
