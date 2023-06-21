import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'tapped_maplibre_flutter_platform_interface.dart';

/// An implementation of [TappedMaplibreFlutterPlatform] that uses method channels.
class MethodChannelTappedMaplibreFlutter extends TappedMaplibreFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tapped_maplibre_flutter');

  @override
  Widget build(BuildContext context) {
    const viewType = '<maplibre_map>';

    return const AndroidView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: {},
      creationParamsCodec: const StandardMessageCodec(),
    );

    return PlatformViewLink(
      viewType: viewType,
      surfaceFactory: (context, controller) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
      onCreatePlatformView: (params) {
        return PlatformViewsService.initSurfaceAndroidView(
          id: params.id,
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: {},
          creationParamsCodec: const StandardMessageCodec(),
          onFocus: () {
            params.onFocusChanged(true);
          },
        )
          ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
          ..create();
      },
    );
  }
}
