import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/multiplication_challenge_provider.dart';
import 'package:multiplication_app/go_router.dart';

class MultiplicationChallengePage extends ConsumerStatefulWidget {
  const MultiplicationChallengePage({super.key});

  @override
  ConsumerState<MultiplicationChallengePage> createState() =>
      _MultiplicationChallengePageState();
}

class _MultiplicationChallengePageState
    extends ConsumerState<MultiplicationChallengePage> {
  String _currentAnswerInput = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onNumberPressed(String number) {
    setState(() {
      if (_currentAnswerInput.length < 3) {
        _currentAnswerInput += number;
      }
    });
  }

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

    ref.listen<
      AsyncValue<MultiplicationChallengeState>
    >(multiplicationChallengeNotifierProvider, (previous, next) async {
      if (next.hasValue && next.value!.isChallengeComplete && mounted) {
        await Future.delayed(const Duration(milliseconds: 50));

        if (rootNavigatorKey.currentContext != null) {
          GoRouter.of(rootNavigatorKey.currentContext!).pushReplacement(
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
          // print('Error: Root Navigator Context is null. Cannot navigate.'); // 削除
        }
      } else if (next.hasError && mounted) {
        // print('Listener detected error: ${next.error}'); // 削除
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('エラー: ${next.error}')));
      }
    });

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
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 64,
                    ),
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
                                color: Colors.black,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _currentAnswerInput.isEmpty
                          ? Colors.blueAccent
                          : Colors.deepPurple,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    _currentAnswerInput.isEmpty ? '答えを入力' : _currentAnswerInput,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _currentAnswerInput.isEmpty
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
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
                        _buildActionButton(
                          '削除',
                          _onDeletePressed,
                          context,
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                        ),
                        _buildNumberButton('0', context),
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

  Widget _buildNumberButton(String number, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ElevatedButton(
          onPressed: () => _onNumberPressed(number),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest, // Material 3
            foregroundColor: Theme.of(
              context,
            ).colorScheme.onSurfaceVariant, // Material 3
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
            backgroundColor:
                backgroundColor ??
                Theme.of(context).colorScheme.tertiary, // Material 3
            foregroundColor:
                foregroundColor ??
                Theme.of(context).colorScheme.onTertiary, // Material 3
            padding: const EdgeInsets.symmetric(vertical: 20),
            textStyle: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(text, style: const TextStyle(fontSize: 20)),
        ),
      ),
    );
  }

  void _submitAnswer(MultiplicationChallengeNotifier notifier) {
    final userAnswer = int.tryParse(_currentAnswerInput);
    if (userAnswer != null) {
      notifier.checkAnswer(userAnswer);
      setState(() {
        _currentAnswerInput = '';
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('数字を入力してください。')));
    }
  }
}
