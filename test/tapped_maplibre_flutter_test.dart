import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tapped_maplibre_flutter/tapped_maplibre_flutter.dart';
import 'package:tapped_maplibre_flutter/tapped_maplibre_flutter_platform_interface.dart';
import 'package:tapped_maplibre_flutter/tapped_maplibre_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTappedMaplibreFlutterPlatform
    with MockPlatformInterfaceMixin
    implements TappedMaplibreFlutterPlatform {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

void main() {
  final TappedMaplibreFlutterPlatform initialPlatform =
      TappedMaplibreFlutterPlatform.instance;

  test('$MethodChannelTappedMaplibreFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTappedMaplibreFlutter>());
  });

  test('getPlatformVersion', () async {
    TappedMaplibreFlutter tappedMaplibreFlutterPlugin = TappedMaplibreFlutter();
    MockTappedMaplibreFlutterPlatform fakePlatform =
        MockTappedMaplibreFlutterPlatform();
    TappedMaplibreFlutterPlatform.instance = fakePlatform;

    //expect(await tappedMaplibreFlutterPlugin.getPlatformVersion(), '42');
  });
}
