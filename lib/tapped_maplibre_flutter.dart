
import 'package:flutter/cupertino.dart';

import 'tapped_maplibre_flutter_platform_interface.dart';

class TappedMaplibreFlutter {
  Widget build(BuildContext context) {
    return TappedMaplibreFlutterPlatform.instance.build(context);
  }
}
