import 'package:flutter/material.dart';
import 'package:flutter_router_example/src/domain/entities/dog.dart';
import 'package:flutter_router_example/src/presentation/dog/dog_list_item.dart';

class DogListView extends StatelessWidget {
  const DogListView({super.key, required this.dogs, required this.onTap, this.scrollController});

  final ScrollController? scrollController;
  final List<Dog> dogs;
  final ValueChanged<Dog> onTap;

  @override
  Widget build(BuildContext context) => ListView.builder(
    controller: scrollController,
    itemCount: dogs.length,
    itemBuilder: (_, index) => DogListItem(dog: dogs[index], onTap: onTap),
  );
}
