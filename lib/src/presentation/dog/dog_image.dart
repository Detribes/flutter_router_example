import 'package:flutter/material.dart';
import 'package:flutter_router_example/src/domain/entities/dog.dart';
import 'package:flutter_router_example/src/presentation/widgets/base_network_image.dart';

class DogImage extends StatelessWidget {
  const DogImage({super.key, required this.dog});

  final Dog dog;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: SizedBox(width: 48, height: 48, child: BaseNetworkImage(imageUrl: dog.picture)),
  );
}
