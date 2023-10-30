import 'package:app_agendamento/core/di/di.dart';
import 'package:app_agendamento/core/firebase/messaging/app_messaging.dart';
import 'package:app_agendamento/core/flavor/flavor_config.dart';
import 'package:app_agendamento/core/route/app_routes.dart';
import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/utils/no_glow_behavior.dart';
import 'package:app_agendamento/core/widgets/alert/alert_area.dart';
import 'package:app_agendamento/features/auth/data/session/session_cubit.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';

Future<void> bootstrap(FlavorConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await configureDependencies(config);

  getIt<AppMessaging>().configure();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(DevicePreview(
    builder: (_) => const App(),
    enabled: true, // TODO: Retornar configuração config.flavor == AppFlavor.dev,
  ));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final t = AppTheme();

    return RepositoryProvider.value(
      value: t,
      child: BlocProvider.value(
        value: getIt<SessionCubit>(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('pt', 'BR')
          ],
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: t.bg,
            colorScheme: ThemeData
                .light()
                .colorScheme
                .copyWith(
              background: Colors.white,
            ),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: t.primary,
              selectionHandleColor: t.primary,
              selectionColor: t.primary.withOpacity(0.3),
            ),
            highlightColor: t.primary.withOpacity(0.1),
            splashColor: t.primary.withOpacity(0.1),
            useMaterial3: true,
          ),
          locale: DevicePreview.locale(context),
          builder: (context, child) {
            final newChild = Stack(
              children: [
                if(child != null) child,
                const AlertArea(),
              ],
            );
            return DevicePreview.appBuilder(context, newChild);
          },
        ),
      ),
    );
  }
}
