import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox(
        height: 4,
        child: Center(child: LinearProgressIndicator()),
      );
}
