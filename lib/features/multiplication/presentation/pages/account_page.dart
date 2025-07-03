import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ユーザー名: ${user.username}',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '総獲得星数: ${user.stars}個',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontSize: 20), // 修正: fontSize を調整
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '獲得済み段位: ${user.completedTables.isEmpty ? 'なし' : user.completedTables.join(', ')}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'チャレンジ履歴',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // challengeResultsAsyncValue.when はコメントアウトまたは削除されたため、ここには履歴表示の仮のテキストを表示
                const Center(child: Text('履歴機能は現在開発中です。')), // 仮の表示
                // challengeResultsAsyncValue.when(
                //   data: (results) {
                //     if (results.isEmpty) {
                //       return const Center(child: Text('まだチャレンジ履歴がありません。'));
                //     }
                //     return ListView.builder(
                //       shrinkWrap: true,
                //       physics: const NeverScrollableScrollPhysics(),
                //       itemCount: results.length,
                //       itemBuilder: (context, index) {
                //         final result = results[index];
                //         final formattedDate =
                //             DateFormat('yyyy/MM/dd HH:mm').format(result.timestamp);
                //         return Card(
                //           margin: const EdgeInsets.symmetric(vertical: 8.0),
                //           child: Padding(
                //             padding: const EdgeInsets.all(16.0),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   '日付: $formattedDate',
                //                   style: Theme.of(context).textTheme.titleMedium,
                //                 ),
                //                 Text(
                //                   '正解数: ${result.correctAnswers} / ${result.totalProblems}',
                //                   style: Theme.of(context).textTheme.bodyLarge,
                //                 ),
                //                 Text(
                //                   '獲得星数: ${result.starsEarned}個',
                //                   style: Theme.of(context).textTheme.bodyLarge,
                //                 ),
                //               ],
                //             ),
                //           ),
                //         );
                //       },
                //     );
                //   },
                //   loading: () => const Center(child: CircularProgressIndicator()),
                //   error: (err, stack) => Center(child: Text('履歴の読み込みエラー: $err')),
                // ),
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
