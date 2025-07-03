import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'features/multiplication/data/datasources/local_data_source.dart';
import 'features/multiplication/data/datasources/local_data_source_impl.dart';
import 'features/multiplication/data/repositories/multiplication_repository_impl.dart';
import 'features/multiplication/domain/repositories/multiplication_repository.dart';
import 'features/multiplication/domain/usecases/get_multiplication_problems.dart';
import 'features/multiplication/domain/usecases/register_user.dart';
import 'features/multiplication/domain/usecases/get_user_data.dart';
import 'features/multiplication/domain/usecases/update_stars.dart';
import 'features/multiplication/domain/usecases/save_challenge_result.dart';
import 'go_router.dart';
import 'package:google_fonts/google_fonts.dart';

// Providerの定義 (DIコンテナの役割)
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((
  ref,
) async {
  return await SharedPreferences.getInstance();
});

final localDataSourceProvider = Provider<LocalDataSource>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider).value;
  if (sharedPrefs == null) {
    throw Exception('SharedPreferences not initialized');
  }
  return LocalDataSourceImpl(sharedPreferences: sharedPrefs);
});

final multiplicationRepositoryProvider = Provider<MultiplicationRepository>((
  ref,
) {
  final localDataSource = ref.watch(localDataSourceProvider);
  return MultiplicationRepositoryImpl(localDataSource: localDataSource);
});

final registerUserUseCaseProvider = Provider<RegisterUser>((ref) {
  return RegisterUser(ref.watch(multiplicationRepositoryProvider));
});

final getUserDataUseCaseProvider = Provider<GetUserData>((ref) {
  return GetUserData(ref.watch(multiplicationRepositoryProvider));
});

final updateStarsUseCaseProvider = Provider<UpdateStars>((ref) {
  return UpdateStars(ref.watch(multiplicationRepositoryProvider));
});

final getMultiplicationProblemsUseCaseProvider =
    Provider<GetMultiplicationProblems>((ref) {
      return GetMultiplicationProblems(
        ref.watch(multiplicationRepositoryProvider),
      );
    });

final saveChallengeResultUseCaseProvider = Provider<SaveChallengeResult>((ref) {
  return SaveChallengeResult(ref.watch(multiplicationRepositoryProvider));
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // .envファイルのロード
  // await dotenv.load(fileName: ".env.development");

  runApp(
    const ProviderScope(
      // Riverpodを使用するためにProviderScopeでラップ
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider); // GoRouterインスタンスを取得

    return MaterialApp.router(
      title: 'かけ算学習アプリ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.interTextTheme(
          // Google Fontsを適用
          Theme.of(context).textTheme,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      routerConfig: goRouter, // GoRouterを設定
    );
  }
}
