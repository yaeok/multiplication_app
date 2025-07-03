import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/user/user.dart';
import 'package:multiplication_app/features/multiplication/presentation/providers/user_provider.dart';

class RegisterUserPage extends ConsumerStatefulWidget {
  const RegisterUserPage({super.key});

  @override
  ConsumerState<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends ConsumerState<RegisterUserPage> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // userNotifierProviderの状態を監視
    ref.listen<AsyncValue<User?>>(userNotifierProvider, (previous, next) {
      if (next.hasValue && next.value != null && mounted) {
        // ユーザー登録成功後、メイン画面へ遷移
        GoRouter.of(context).go('/multiplication_selection');
      } else if (next.hasError && mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('エラー: ${next.error}')));
      }
    });

    final userState = ref.watch(userNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('ユーザー登録')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'ユーザー名',
                border: OutlineInputBorder(),
                hintText: 'あなたの名前を入力してください',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: userState.isLoading
                  ? null // ロード中はボタンを無効化
                  : () {
                      if (_usernameController.text.isNotEmpty) {
                        ref
                            .read(userNotifierProvider.notifier)
                            .createUser(_usernameController.text);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('ユーザー名を入力してください。')),
                        );
                      }
                    },
              child: userState.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('始める'),
            ),
            if (userState.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  userState.error.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
