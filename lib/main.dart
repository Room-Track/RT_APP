import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:room_track_flutterapp/firebase_options.dart';
import 'package:room_track_flutterapp/models/basicinfo_model.dart';
import 'package:room_track_flutterapp/providers/theme.dart';
import 'package:room_track_flutterapp/theme/color.dart';
import 'package:room_track_flutterapp/theme/text.dart';
import 'package:room_track_flutterapp/views/auth/auth_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await dotenv.load(fileName: 'assets/.env');
  await Hive.initFlutter();
  Hive.registerAdapter(BasicinfoModelAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainApp();
}

class _MainApp extends ConsumerState<MainApp> {
  late Future<void> _future;

  @override
  void initState() {
    super.initState();
    _future = ref.read(themeProvider).initialize();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        final appTheme = ref.watch(themeProvider);
        ColorScheme colorScheme =
            ColorThemes.getScheme(appTheme.colorSchemeName, context);
        TextTheme textScheme = TextThemes.getScheme(appTheme.textSchemeName);
        if (!appTheme.wasInitialized()) {
          return MaterialApp(
            theme: ThemeData(
              colorScheme: ColorThemes.getScheme('System', context),
              textTheme: TextThemes.getScheme('Medium'),
              useMaterial3: true,
            ),
            title: 'Room Track',
            home: const Authlayout(),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              AppLocalizations.delegate,
              ...GlobalMaterialLocalizations.delegates,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
          );
        } else {
          return MaterialApp(
            theme: ThemeData(
              colorScheme: colorScheme,
              textTheme: textScheme,
              splashColor: colorScheme.secondary,
              useMaterial3: true,
            ),
            title: 'Room Track',
            home: const Authlayout(),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              AppLocalizations.delegate,
              ...GlobalMaterialLocalizations.delegates,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(appTheme.languageCode),
          );
        }
      },
    );
  }
}
