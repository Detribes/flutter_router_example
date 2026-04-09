import 'package:flutter/material.dart';
import 'package:flutter_router_example/src/core/common/extensions/theme_extensions.dart';
import 'package:flutter_router_example/generated/l10n.dart';

class DogNotFountView extends StatelessWidget {
  const DogNotFountView({super.key});

  @override
  Widget build(BuildContext context) => Center(child: Text(S.current.dogNotFound, style: context.textTheme.bodyLarge));
}
