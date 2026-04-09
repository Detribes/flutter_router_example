import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_router_example/src/core/common/assets/asset_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseNetworkImage extends StatelessWidget {
  const BaseNetworkImage({super.key, required this.imageUrl, this.fit = BoxFit.cover});

  final String? imageUrl;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) => imageUrl != null
      ? CachedNetworkImage(
          cacheManager: CacheManager(Config('image', stalePeriod: const Duration(days: 2))),
          fit: fit,
          imageUrl: imageUrl!,
          placeholder: (_, _) => const LoadingPlaceHolder(),
          errorWidget: (_, _, _) => const ErrorPlaceHolder(),
        )
      : const ErrorPlaceHolder();
}

class ErrorPlaceHolder extends StatelessWidget {
  const ErrorPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.all(min(constraints.maxHeight, constraints.maxWidth) / 4),
        child: Center(
          child: SvgPicture.asset(
            AssetIcons.placeHolder,
            width: min(constraints.maxHeight, constraints.maxWidth) / 2,
            height: min(constraints.maxHeight, constraints.maxWidth) / 2,
          ),
        ),
      );
    },
  );
}

class LoadingPlaceHolder extends StatelessWidget {
  const LoadingPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(child: CircularProgressIndicator());
}
