import 'package:catalago_colecionadores/src/core/database/isar_models/category_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_models/marca_collection.dart';
import 'package:catalago_colecionadores/src/pages/add_car/add_car_colection.dart';
import 'package:catalago_colecionadores/src/pages/add_car/scan/add_scan_page.dart';
import 'package:catalago_colecionadores/src/pages/auth/login/login_page.dart';
import 'package:catalago_colecionadores/src/pages/auth/password_recovery/password_recovery.dart';
import 'package:catalago_colecionadores/src/pages/auth/registro/register_page.dart';
import 'package:catalago_colecionadores/src/pages/category/add_category_page.dart';
import 'package:catalago_colecionadores/src/pages/category/list_category_page.dart';
import 'package:catalago_colecionadores/src/pages/configuration/configuracoes_page.dart';
import 'package:catalago_colecionadores/src/pages/home/miniaturas_home.dart';
import 'package:catalago_colecionadores/src/pages/informacoes/check_politics_screen.dart';
import 'package:catalago_colecionadores/src/pages/informacoes/check_terms_screen.dart';
import 'package:catalago_colecionadores/src/pages/marca/add_marca_page.dart';
import 'package:catalago_colecionadores/src/pages/marca/list_marca_page.dart';
import 'package:catalago_colecionadores/src/pages/minhacolecao/details/miniatura_details.dart';
import 'package:catalago_colecionadores/src/pages/minhacolecao/minha_colecao.dart';
import 'package:catalago_colecionadores/src/pages/pos_start/pos_start_screen.dart';
import 'package:catalago_colecionadores/src/pages/splash/splash_screen.dart';
import 'package:catalago_colecionadores/src/pages/start/start_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashPage()),
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),
    GoRoute(path: '/registro', builder: (context, state) => RegisterPage()),
    GoRoute(
      path: '/password_recovery',
      builder: (context, state) => PasswordRecovery(),
    ),
    GoRoute(path: '/home', builder: (context, state) => MiniaturasHome()),
    GoRoute(path: '/start', builder: (context, state) => StartScreen()),
    GoRoute(path: '/pos_start', builder: (context, state) => PosStartScreen()),
    GoRoute(
      path: '/add_car',
      builder: (context, state) {
        final id = state.extra as int?;
        return AddCarColection(id: id);
      },
    ),
    GoRoute(
      path: '/add_car/scan',
      builder: (context, state) {
        return AddScanPage();
      },
    ),
    GoRoute(
      path: '/minha_colecao',
      builder: (context, state) => MinhaColecao(),
    ),
    GoRoute(
      path: '/miniatura_details',
      builder: (context, state) {
        final id = state.extra as int?;
        return MiniatureDetails(id: id);
      },
    ),
    GoRoute(path: '/category', builder: (context, state) => AddCategoryPage()),
    GoRoute(
      path: '/configuracoes',
      builder: (context, state) => ConfiguracoesPage(),
    ),
    GoRoute(
      path: '/add_category_page',
      builder: (context, state) {
        final category = state.extra as CategoryCollection?;
        return AddCategoryPage(category: category);
      },
    ),
    GoRoute(
      path: '/list_category',
      builder: (context, state) => ListCategoryPage(),
    ),
    GoRoute(
      path: '/check_terms_screen',
      builder: (context, state) => CheckTermsScreen(),
    ),
    GoRoute(
      path: '/check_politics_screen',
      builder: (context, state) => CheckPoliticsScreen(),
    ),
    GoRoute(path: '/list_marca', builder: (context, state) => ListMarcaPage()),
    GoRoute(
      path: '/add_marca_page',
      builder: (context, state) {
        final marca = state.extra as MarcaCollection?;
        return AddMarcaPage(marca: marca);
      },
    ),
  ],
);
