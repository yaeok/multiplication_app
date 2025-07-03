// lib/main.dart
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

final localDataSourceProvider = FutureProvider<LocalDataSource>((ref) async {
  final sharedPrefs = await ref.watch(sharedPreferencesProvider.future);
  return LocalDataSourceImpl(sharedPreferences: sharedPrefs);
});

final multiplicationRepositoryProvider =
    FutureProvider<MultiplicationRepository>((ref) async {
      final localDataSource = await ref.watch(localDataSourceProvider.future);
      return MultiplicationRepositoryImpl(localDataSource: localDataSource);
    });

final registerUserUseCaseProvider = FutureProvider<RegisterUser>((ref) async {
  final repository = await ref.watch(multiplicationRepositoryProvider.future);
  return RegisterUser(repository);
});

final getUserDataUseCaseProvider = FutureProvider<GetUserData>((ref) async {
  final repository = await ref.watch(multiplicationRepositoryProvider.future);
  return GetUserData(repository);
});

final updateStarsUseCaseProvider = Provider<UpdateStars>((ref) {
  return UpdateStars(ref.watch(multiplicationRepositoryProvider).value!);
});

final getMultiplicationProblemsUseCaseProvider =
    Provider<GetMultiplicationProblems>((ref) {
      return GetMultiplicationProblems(
        ref.watch(multiplicationRepositoryProvider).value!,
      );
    });

final saveChallengeResultUseCaseProvider = Provider<SaveChallengeResult>((ref) {
  return SaveChallengeResult(
    ref.watch(multiplicationRepositoryProvider).value!,
  );
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

    // Define custom colors from hex codes
    const Color baseColor = Color(0xFFFDFDFD);
    const Color accentColor = Color(
      0xFF47CC81,
    ); // アクセントカラー #5F767 を #05F767 と解釈
    const Color secondaryColor = Color(0xFF2C4242); // セカンダリカラー #2C4242

    final ColorScheme customColorScheme = ColorScheme.fromSeed(
      seedColor: accentColor, // シードカラーにアクセントカラーを設定
      brightness: Brightness.light,
      // ユーザー指定のカラーを適用
      primary: accentColor,
      onPrimary: Colors.black, // 明るいプライマリカラーに対してコントラストの高い黒を設定
      secondary: secondaryColor,
      onSecondary: Colors.white, // 濃いセカンダリカラーに対して白を設定
      error: Colors.red, // 標準のエラーカラー
      onError: Colors.white,
      surface: baseColor, // カードやシートなどのサーフェスカラーにベースカラーを適用
      onSurface: Colors.black87,
      outline: secondaryColor, // アウトラインカラーにセカンダリカラーの透過版を使用
    );

    return MaterialApp.router(
      title: 'くくべん',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, // Material 3 を有効化
        colorScheme: customColorScheme, // カスタムカラーを適用
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
        appBarTheme: AppBarTheme(
          backgroundColor: customColorScheme.primary,
          foregroundColor: customColorScheme.onPrimary,
          elevation: 2,
          titleTextStyle: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: customColorScheme.onPrimary,
          ),
          iconTheme: IconThemeData(color: customColorScheme.onPrimary),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: customColorScheme.primary,
            foregroundColor: customColorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            elevation: 4,
          ),
        ),
        cardTheme: CardThemeData(
          color: customColorScheme.surface,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: customColorScheme.surface,
          selectedItemColor: customColorScheme.primary,
          unselectedItemColor: customColorScheme.onSurface.withOpacity(0.6),
          selectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.inter(),
          type: BottomNavigationBarType.fixed,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: customColorScheme.secondary,
          foregroundColor: customColorScheme.onSecondary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: customColorScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: customColorScheme.primary, width: 2),
          ),
          labelStyle: TextStyle(color: customColorScheme.onSurface),
          hintStyle: TextStyle(
            color: customColorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ),
      routerConfig: goRouter,
    );
  }
}
