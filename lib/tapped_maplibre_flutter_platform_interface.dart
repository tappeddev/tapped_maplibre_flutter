import 'package:flutter/cupertino.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tapped_maplibre_flutter_method_channel.dart';

abstract class TappedMaplibreFlutterPlatform extends PlatformInterface {
  /// Constructs a TappedMaplibreFlutterPlatform.
  TappedMaplibreFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static TappedMaplibreFlutterPlatform _instance = MethodChannelTappedMaplibreFlutter();

  /// The default instance of [TappedMaplibreFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelTappedMaplibreFlutter].
  static TappedMaplibreFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TappedMaplibreFlutterPlatform] when
  /// they register themselves.
  static set instance(TappedMaplibreFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
