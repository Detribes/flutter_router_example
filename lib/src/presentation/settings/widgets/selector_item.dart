import 'package:flutter/material.dart';
import 'package:flutter_router_example/src/core/common/extensions/theme_extensions.dart';

class SelectorItem extends StatelessWidget {
  const SelectorItem({
    super.key,
    required this.onTap,
    required this.title,
  });

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Container(
          alignment: .center,
          width: .infinity,
          child: Padding(
            padding: const .symmetric(vertical: 12),
            child: Text(
              title,
              style: context.textTheme.bodyLarge,
            ),
          ),
        ),
      );
}
