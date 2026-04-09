import 'package:flutter/material.dart';
import 'package:flutter_router_example/src/core/common/extensions/theme_extensions.dart';
import 'package:flutter_router_example/src/domain/entities/dog.dart';
import 'package:flutter_router_example/src/presentation/dog/dog_image.dart';

class DogListItem extends StatelessWidget {
  const DogListItem({super.key, required this.dog, required this.onTap});

  final Dog dog;
  final ValueChanged<Dog> onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => onTap(dog),
    child: Column(
      children: [
        Row(
          children: [
            DogImage(dog: dog),
            Text(dog.breed, style: context.textTheme.bodyMedium),
          ],
        ),
        const Divider(),
      ],
    ),
  );
}
