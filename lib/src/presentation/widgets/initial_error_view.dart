import 'package:flutter/material.dart';
import 'package:flutter_router_example/src/core/common/extensions/theme_extensions.dart';
import 'package:flutter_router_example/generated/l10n.dart';

class InitialErrorView extends StatelessWidget {
  const InitialErrorView({super.key, this.onTapReload});

  final VoidCallback? onTapReload;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.current.error,
              style: context.textTheme.bodyLarge,
            ),
            ElevatedButton(
              onPressed: onTapReload,
              child: Text(S.current.repeat),
            ),
          ],
        ),
      );
}
