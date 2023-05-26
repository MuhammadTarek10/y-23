import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/language.dart';
import 'package:y23/config/routes.dart';
import 'package:y23/core/di.dart';
import 'package:y23/core/prefs.dart';
import 'package:y23/core/state/providers/theme_provider.dart';
import 'package:y23/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  await initApp();
  runApp(
    EasyLocalization(
      supportedLocales: const [arabicLocale, englishLocale],
      path: assetPathLocalization,
      child: Phoenix(child: const ProviderScope(child: App())),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final prefs = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    prefs.getLocale().then((locale) => {context.setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      prefs.isDarkMode().then(
            (isDark) => ref.read(themeProvider.notifier).setTheme(isDark),
          );
      final theme = ref.watch(themeProvider);
      return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouterGenerator.generateRoute,
        initialRoute: Routes.initialRoute,
        theme: theme,
      );
    });
  }
}
