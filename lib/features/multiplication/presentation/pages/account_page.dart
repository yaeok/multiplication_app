import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiplication_app/common/widgets/user_summary_card.dart';
import 'package:multiplication_app/features/multiplication/presentation/providers/user_provider.dart';
// import 'package:multiplication_app/features/multiplication/presentation/providers/challenge_result_provider.dart'; // 未使用のためコメントアウト

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userNotifierProvider);
    // final challengeResultsAsyncValue = ref.watch(challengeResultsProvider); // 未使用のためコメントアウト

    return Scaffold(
      appBar: AppBar(title: const Text('アカウント情報')),
      body: userAsyncValue.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('ユーザー情報がありません。'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '達成した段位',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary, // プライマリカラーを適用
                  ),
                ),
                const SizedBox(height: 10),
                // 達成した段位をグリッドで表示
                if (user.completedTables.isEmpty)
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.emoji_events,
                            size: 48,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'まだ達成した段位はありません。',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'チャレンジして星を獲得しましょう！',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant
                                      .withOpacity(0.7),
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, // よりコンパクトなグリッド
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1,
                        ),
                    itemCount: user.completedTables.length,
                    itemBuilder: (context, index) {
                      final table = user.completedTables[index];
                      return Card(
                        elevation: 4,
                        color:
                            Colors.amber[100 * (table % 9) + 100], // カラフルなカード
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow[100 * (9 % table) + 100],
                              size: 30,
                            ),
                            Text(
                              '$tableの段',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.brown[900],
                                  ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                const SizedBox(height: 20),

                Text(
                  'チャレンジ履歴',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary, // プライマリカラーを適用
                  ),
                ),
                const SizedBox(height: 10),
                // 仮の履歴表示をよりモダンなデザインに
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.history,
                          size: 48,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '過去のチャレンジ結果がここに表示されます。',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                                fontSize: 16,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '履歴機能は現在開発中です。お楽しみに！',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontStyle: FontStyle.italic,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant.withOpacity(0.7),
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('ユーザー情報の読み込みエラー: $err')),
      ),
    );
  }
}
