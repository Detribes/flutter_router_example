import 'package:flutter/material.dart';
import 'package:flutter_router_example/src/core/router/route_configuration.dart';

class PageBuilder extends StatefulWidget {
  const PageBuilder({
    super.key,
    required this.builder,
    required this.pageBuilder,
    required this.configuration,
  });

  final RouteConfiguration configuration;
  final Widget Function(BuildContext, List<Page>) builder;
  final List<Page> Function() pageBuilder;

  @override
  State<PageBuilder> createState() => _PageBuilderState();
}

class _PageBuilderState extends State<PageBuilder> {
  List<Page> pages = [];
  late RouteConfiguration currentConfiguration;

  @override
  void initState() {
    pages = widget.pageBuilder();
    currentConfiguration = widget.configuration;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PageBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.configuration.lodogion != widget.configuration.lodogion) {
      pages = widget.pageBuilder();
      currentConfiguration = widget.configuration;
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, pages);
}
