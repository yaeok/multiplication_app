import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

// localDataSourceProvider を FutureProvider に変更
final localDataSourceProvider = FutureProvider<LocalDataSource>((ref) async {
  final sharedPrefs = await ref.watch(
    sharedPreferencesProvider.future,
  ); // .future を使用して await
  return LocalDataSourceImpl(sharedPreferences: sharedPrefs);
});

// multiplicationRepositoryProvider を FutureProvider に変更
final multiplicationRepositoryProvider =
    FutureProvider<MultiplicationRepository>((ref) async {
      final localDataSource = await ref.watch(
        localDataSourceProvider.future,
      ); // .future を使用して await
      return MultiplicationRepositoryImpl(localDataSource: localDataSource);
    });

// 各ユースケースプロバイダを FutureProvider に変更
final registerUserUseCaseProvider = FutureProvider<RegisterUser>((ref) async {
  final repository = await ref.watch(
    multiplicationRepositoryProvider.future,
  ); // .future を使用して await
  return RegisterUser(repository);
});

final getUserDataUseCaseProvider = FutureProvider<GetUserData>((ref) async {
  final repository = await ref.watch(
    multiplicationRepositoryProvider.future,
  ); // .future を使用して await
  return GetUserData(repository);
});

final updateStarsUseCaseProvider = FutureProvider<UpdateStars>((ref) async {
  final repository = await ref.watch(
    multiplicationRepositoryProvider.future,
  ); // .future を使用して await
  return UpdateStars(repository);
});

final getMultiplicationProblemsUseCaseProvider =
    FutureProvider<GetMultiplicationProblems>((ref) async {
      final repository = await ref.watch(
        multiplicationRepositoryProvider.future,
      ); // .future を使用して await
      return GetMultiplicationProblems(repository);
    });

final saveChallengeResultUseCaseProvider = FutureProvider<SaveChallengeResult>((
  ref,
) async {
  final repository = await ref.watch(
    multiplicationRepositoryProvider.future,
  ); // .future を使用して await
  return SaveChallengeResult(repository);
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'かけ算学習アプリ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
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
      routerConfig: goRouter,
    );
  }
}
