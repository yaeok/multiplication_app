import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/challenge_problem_result/challenge_problem_result.dart'; // このimportを追加

class ResultPage extends StatelessWidget {
  final int correctAnswers;
  final int totalProblems;
  final int starsEarned;
  final List<ChallengeProblemResult> problemResults; // このフィールドを追加

  const ResultPage({
    super.key,
    required this.correctAnswers,
    required this.totalProblems,
    required this.starsEarned,
    required this.problemResults, // コンストラクタでproblemResultsを必須にする
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('結果発表！')),
      body: SingleChildScrollView(
        // ここをSingleChildScrollViewでラップします
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'チャレンジ終了！',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.lightGreen[100],
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Text(
                        '$correctAnswers 問正解！',

                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(starsEarned, (index) {
                          return const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 40,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20), // 間隔を追加
              // ここからExpandedを削除し、ListView.builderのphysicsを設定します
              ListView.builder(
                shrinkWrap: true, // コンテンツのサイズに合わせて高さを調整
                physics:
                    const NeverScrollableScrollPhysics(), // ListView自体のスクロールを無効化
                itemCount: problemResults.length,
                itemBuilder: (context, index) {
                  final result = problemResults[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    color: result.isCorrect
                        ? Colors.green[50]
                        : Colors.red[50], // 正誤に基づいて色付け
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${result.problem.factor1} × ${result.problem.factor2} = ${result.problem.answer}', // 問題と正解を表示
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: result.isCorrect
                                  ? Colors.green[900]
                                  : Colors.red[900],
                            ),
                          ),
                          Text(
                            'あなたの答え: ${result.userAnswer}', // ユーザーの回答を表示
                            style: TextStyle(
                              fontSize: 20,
                              color: result.isCorrect
                                  ? Colors.green[700]
                                  : Colors.red[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  // 修正: パスを ShellRoute のパスに変更
                  GoRouter.of(context).replace('/home/selection'); // 問題選択画面に戻る
                },
                icon: const Icon(Icons.home, size: 30),
                label: const Text('もう一度チャレンジ！'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
