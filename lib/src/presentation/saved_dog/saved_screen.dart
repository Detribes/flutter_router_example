import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_router_example/src/core/router/configurations/nested/dog_info_configuration.dart';
import 'package:flutter_router_example/src/core/router/scope/router_scope.dart';
import 'package:flutter_router_example/src/di/dependency_scope.dart';
import 'package:flutter_router_example/src/domain/entities/dog.dart';
import 'package:flutter_router_example/src/domain/saved_dog/saved_bloc.dart';
import 'package:flutter_router_example/src/domain/saved_dog/saved_event.dart';
import 'package:flutter_router_example/src/domain/saved_dog/saved_state.dart';
import 'package:flutter_router_example/generated/l10n.dart';
import 'package:flutter_router_example/src/presentation/dog/dog_list_view.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => DependencyScope.getBlocFactory(context).savedBloc..add(const SavedEvent.load()),
    child: const SavedView(),
  );
}

class SavedView extends StatefulWidget {
  const SavedView({super.key});

  @override
  SavedViewState createState() => SavedViewState();
}

class SavedViewState extends State<SavedView> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(S.current.saved)),
    body: BlocBuilder<SavedBloc, SavedState>(
      builder: (context, state) => DogListView(onTap: _onTapDog, dogs: state.dogs),
    ),
  );

  void _onTapDog(Dog dog) => RouterScope.of(context).push(DogInfoConfiguration(id: dog.id, saved: true));
}
