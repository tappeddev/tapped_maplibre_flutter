package tapped.maplibre.flutter.tapped_maplibre_flutter

import androidx.annotation.NonNull
import androidx.lifecycle.Lifecycle
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.lifecycle.HiddenLifecycleReference

class TappedMaplibreFlutterPlugin : FlutterPlugin, ActivityAware {
    private lateinit var lifecycle: Lifecycle

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        flutterPluginBinding
            .platformViewRegistry
            .registerViewFactory("<maplibre_map>", MaplibrePlatformViewFactory { lifecycle })
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        lifecycle = (binding.lifecycle as HiddenLifecycleReference).lifecycle
    }

    override fun onDetachedFromActivityForConfigChanges() {

    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {

    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {

    }
}
