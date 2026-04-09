import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_example/src/presentation/widgets/info_snack_bar.dart';

class SampleBlocObserver extends BlocObserver {
  SampleBlocObserver({required this.scaffoldMessengerKey});

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    String message = error.toString();

    if (error is DioException) {
      message = error.response != null
          ? '${error.response!.statusCode} ${error.response!.data}'
          : (error.message ?? error.toString());
    }

    scaffoldMessengerKey.currentState?.showSnackBar(InfoSnackBar(message: message));
    super.onError(bloc, error, stackTrace);
  }
}
