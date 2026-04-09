import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_router_example/src/core/router/configurations/nested/dog_info_configuration.dart';
import 'package:flutter_router_example/src/core/router/scope/router_scope.dart';
import 'package:flutter_router_example/src/di/dependency_scope.dart';
import 'package:flutter_router_example/src/domain/dog/dog_bloc.dart';
import 'package:flutter_router_example/src/domain/dog/dog_event.dart';
import 'package:flutter_router_example/src/domain/dog/dog_state.dart';
import 'package:flutter_router_example/src/domain/entities/dog.dart';
import 'package:flutter_router_example/generated/l10n.dart';
import 'package:flutter_router_example/src/presentation/dog/dog_list_view.dart';
import 'package:flutter_router_example/src/presentation/widgets/initial_error_view.dart';
import 'package:flutter_router_example/src/presentation/widgets/initial_loading_view.dart';
import 'package:flutter_router_example/src/presentation/widgets/loading_view.dart';

class DogScreen extends StatelessWidget {
  const DogScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => DependencyScope.getBlocFactory(context).dogBloc..add(const Fetch()),
        child: const DogView(),
      );
}

class DogView extends StatefulWidget {
  const DogView({super.key});

  @override
  DogViewState createState() => DogViewState();
}

class DogViewState extends State<DogView> {
  final ScrollController scrollController = ScrollController();
  late final DogBloc dogBloc;

  @override
  void initState() {
    super.initState();
    dogBloc = context.read<DogBloc>();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        dogBloc.add(const DogEvent.fetch());
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(S.current.dogs)),
        body: BlocBuilder<DogBloc, DogState>(
          builder: (context, state) => state.status == DogStatus.initialLoading
              ? const InitialLoadingView()
              : state.status == DogStatus.initialError
                  ? InitialErrorView(onTapReload: _onTapReload)
                  : Column(
                      children: [
                        Expanded(
                          child: DogListView(onTap: _onTapDog, dogs: state.dogs, scrollController: scrollController),
                        ),
                        if (state.status == DogStatus.loading) const LoadingView(),
                      ],
                    ),
        ),
      );

  void _onTapDog(Dog dog) => RouterScope.of(context).push(DogInfoConfiguration(id: dog.id, saved: false));

  void _onTapReload() => dogBloc.add(const DogEvent.fetch());
}
