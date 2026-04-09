import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_router_example/src/core/router/configurations/nested/saved_info_configuration.dart';
import 'package:flutter_router_example/src/core/router/root_route_information_parser.dart';
import 'package:flutter_router_example/src/core/router/scope/router_scope.dart';
import 'package:flutter_router_example/src/core/router/tab_router.dart';
import 'package:flutter_router_example/src/di/dependency_scope.dart';
import 'package:flutter_router_example/src/domain/dog_info/dog_info_bloc.dart';
import 'package:flutter_router_example/src/domain/dog_info/dog_info_event.dart';
import 'package:flutter_router_example/src/domain/dog_info/dog_info_state.dart';
import 'package:flutter_router_example/src/presentation/dog_info/widget/dog_not_found_view.dart';
import 'package:flutter_router_example/generated/l10n.dart';
import 'package:flutter_router_example/src/presentation/widgets/base_network_image.dart';
import 'package:flutter_router_example/src/presentation/widgets/initial_error_view.dart';
import 'package:flutter_router_example/src/presentation/widgets/initial_loading_view.dart';

class DogInfoScreen extends StatelessWidget {
  const DogInfoScreen({super.key, required this.id, required this.saved});

  final String id;
  final bool saved;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) =>
            DependencyScope.getBlocFactory(context).getDogInfoBloc(id: id, saved: saved)..add(const DogInfoEvent.load()),
        child: DogInfoView(saved: saved),
      );
}

class DogInfoView extends StatelessWidget {
  const DogInfoView({super.key, required this.saved});

  final bool saved;

  @override
  Widget build(BuildContext context) => BlocConsumer<DogInfoBloc, DogInfoState>(
        listenWhen: (prev, curr) => prev.action != curr.action && curr.action != DogInfoAction.none,
        listener: (context, state) {
          if (state.action == DogInfoAction.saved) {
            _onDogSaved(context, state.id);
          }
        },
        buildWhen: (prev, curr) => prev.action == curr.action || curr.action == DogInfoAction.none,
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(state.dog.breed),
            actions: [
              if (!saved)
                IconButton(icon: const Icon(Icons.save), tooltip: S.current.saveDog, onPressed: () => _onTapSave(context)),
            ],
          ),
          body: _getContent(state, context),
        ),
      );

  Widget _getContent(DogInfoState state, BuildContext context) {
    switch (state.status) {
      case DogInfoStatus.loading:
        return const InitialLoadingView();
      case DogInfoStatus.dogNotFound:
        return const DogNotFountView();
      case DogInfoStatus.fetchError:
        return InitialErrorView(onTapReload: () => _onTapReload(context));
      case DogInfoStatus.data:
        return Center(child: BaseNetworkImage(imageUrl: state.dog.picture));
    }
  }

  void _onTapSave(BuildContext context) => context.read<DogInfoBloc>().add(const DogInfoEvent.save());

  void _onTapReload(BuildContext context) => context.read<DogInfoBloc>().add(const DogInfoEvent.load());

  void _onDogSaved(BuildContext context, String id) async {
    await RouterScope.of(context).pop();
    if (context.mounted) TabRouter.of(context).delegateByPath(savedPath).navigate(SavedInfoConfiguration(id: id));
  }
}
