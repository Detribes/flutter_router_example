import 'package:flutter/material.dart';
import 'package:flutter_router_example/src/core/router/base_router_delegate.dart';
import 'package:flutter_router_example/src/core/router/delegate/nested/dog_router_delegate.dart';
import 'package:flutter_router_example/src/core/router/delegate/nested/saved_router_delegate.dart';
import 'package:flutter_router_example/src/core/router/delegate/nested/settings_router_delegate.dart';
import 'package:flutter_router_example/src/core/router/root_route_information_parser.dart';
import 'package:flutter_router_example/src/core/router/tab_router.dart';
import 'package:flutter_router_example/generated/l10n.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Map<String, BaseRouterDelegate> delegateMap;

  @override
  void initState() {
    delegateMap = {
      dogPath: DogRouterDelegate(),
      savedPath: SavedRouterDelegate(),
      settingsPath: SettingsRouterDelegate(),
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) => TabRouter(
        delegateMap: delegateMap,
        builder: (context, child) {
          final tabRouter = TabRouter.of(context);
          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: tabRouter.currentTab,
              type: BottomNavigationBarType.fixed,
              onTap: (index) => TabRouter.of(context).changeTab(index),
              items: [
                BottomNavigationBarItem(icon: const Icon(Icons.pets), label: S.current.dogs),
                BottomNavigationBarItem(icon: const Icon(Icons.dataset), label: S.current.saved),
                BottomNavigationBarItem(icon: const Icon(Icons.settings), label: S.current.settings),
              ],
            ),
          );
        },
      );
}
