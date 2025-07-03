import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_provider.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('アカウント')),
      body: userAsyncValue.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('ユーザー情報がありません。'));
          }
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        const Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'ユーザー名: ${user.username}',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '貯めた星の数: ${user.stars} 個',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(color: Colors.amber[800]),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(user.stars, (index) {
                            return const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 30,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // 将来的な機能追加のためのボタンなど
                ElevatedButton.icon(
                  onPressed: () {
                    // 例えば、ログアウト機能など
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('その他の機能は今後追加されます！')),
                    );
                  },
                  icon: const Icon(Icons.settings, size: 24),
                  label: const Text('設定'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
