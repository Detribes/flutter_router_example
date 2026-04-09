import 'package:flutter/material.dart';
import 'package:flutter_router_example/src/core/common/extensions/theme_extensions.dart';
import 'package:flutter_router_example/generated/l10n.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({
    super.key,
    required this.onTapLogout,
  });

  final VoidCallback onTapLogout;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: InkWell(
          onTap: onTapLogout,
          child: Text(
            S.current.logout,
            style: context.textTheme.bodyLarge?.copyWith(color: context.colors.secondary),
          ),
        ),
      );
}
