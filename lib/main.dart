import 'package:app_arq/config/dependencies.dart';
import 'package:app_arq/domain/model/user_model.dart';
import 'package:app_arq/main_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import 'main.route.dart';
part 'main.g.dart';

void main() {
  setupDependencies();

  runApp(MainApp());
}

@Main('lib/ui/')
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final viewModel = injector.get<MainViewmodel>();

  @override
  void initState() {
    viewModel.addListener(() {
      if (viewModel.user is LoggedUser) {
        Routefly.navigate(routePaths.home);
      } else {
        Routefly.navigate(routePaths.auth.login);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routefly.routerConfig(
        routes: routes,
        initialPath: routePaths.auth.login,
      ),
    );
  }
}
