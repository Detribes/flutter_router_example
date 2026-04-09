import 'dart:async';

import 'package:flutter_router_example/src/contracts/refresh_saved_repository.dart';

class RefreshSavedRepositoryImpl implements RefreshSavedRepository {
  final StreamController<void> _refreshSavedStreamController = StreamController.broadcast();

  @override
  Stream<void> get refreshSavedStream => _refreshSavedStreamController.stream;

  @override
  void refreshSaved() => _refreshSavedStreamController.add(null);
}
