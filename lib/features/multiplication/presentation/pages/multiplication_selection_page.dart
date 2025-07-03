import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/multiplication_challenge_provider.dart';
import '../providers/user_provider.dart';

class MultiplicationSelectionPage extends ConsumerWidget {
  const MultiplicationSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userNotifierProvider);
    final challengeNotifierState = ref.watch(
      multiplicationChallengeNotifierProvider,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('かけ算チャレンジ')),
      body: userAsyncValue.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('ユーザー情報がありません。'));
          }

          final bool isOverallLoading = challengeNotifierState.isLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'ようこそ、${user.username}さん！',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '現在の星の数: ${user.stars}個',
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '獲得済み段位: ${user.completedTables.isEmpty ? 'なし' : user.completedTables.join(', ')}',
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const Text(
                  '段を選んでチャレンジ！',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    final table = index + 1;
                    // 獲得済み段位の場合はボタンの見た目を変えるなど、視覚的なフィードバックも追加可能
                    final bool isTableCompleted = user.completedTables.contains(
                      table,
                    );

                    return ElevatedButton(
                      // isOverallLoading が true の間はボタンを無効化
                      onPressed: isOverallLoading
                          ? null
                          : () {
                              ref
                                  .read(
                                    multiplicationChallengeNotifierProvider
                                        .notifier,
                                  )
                                  .startChallenge(table, 9); // 特定の段の場合、countは9
                              GoRouter.of(context).go('/challenge');
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isTableCompleted
                            ? Colors
                                  .lightGreen
                                  .shade100 // 獲得済みは別の色に
                            : Colors.lightBlue[100 * table],
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            '$tableの段',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (isTableCompleted)
                            const Positioned(
                              top: 5,
                              right: 5,
                              child: Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 24,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                const Text(
                  'ランダムチャレンジ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  // isOverallLoading が true の間はボタンを無効化
                  onPressed: isOverallLoading
                      ? null
                      : () {
                          ref
                              .read(
                                multiplicationChallengeNotifierProvider
                                    .notifier,
                              )
                              .startChallenge(0, 10); // ランダムの場合、countは10
                          GoRouter.of(context).go('/challenge');
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: isOverallLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'ランダム10問に挑戦！',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                if (challengeNotifierState.isLoading)
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                if (challengeNotifierState.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Center(
                      child: Text(
                        '問題設定エラー: ${challengeNotifierState.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('エラー: $err')),
      ),
    );
  }
}
