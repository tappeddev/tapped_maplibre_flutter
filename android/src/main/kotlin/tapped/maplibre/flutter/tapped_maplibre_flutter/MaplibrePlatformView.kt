package tapped.maplibre.flutter.tapped_maplibre_flutter

import android.content.Context
import android.util.Log
import android.widget.FrameLayout
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleOwner
import com.mapbox.mapboxsdk.Mapbox
import com.mapbox.mapboxsdk.maps.MapView
import com.mapbox.mapboxsdk.maps.MapboxMap
import com.mapbox.mapboxsdk.maps.MapboxMapOptions
import com.mapbox.mapboxsdk.maps.OnMapReadyCallback
import com.mapbox.mapboxsdk.maps.Style
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class MaplibrePlatformView(
    private val context: Context,
    private val viewId: Int,
    private val args: Map<String, Any?>?,
    private val getLifecycle: () -> Lifecycle
) : PlatformView, DefaultLifecycleObserver, OnMapReadyCallback {

    private val viewGroup = FrameLayout(context)
    private val mapView: MapView

    init {
        Mapbox.getInstance(context)
        val options = MapboxMapOptions()
            .attributionEnabled(true)
            .logoEnabled(false)
            .textureMode(true)
        mapView = MapView(context, options)
        mapView.getMapAsync(this)

        viewGroup.addView(mapView)

        getLifecycle().addObserver(this)
    }

    override fun getView() = viewGroup

    override fun dispose() {
        getLifecycle().removeObserver(this)
        viewGroup.removeView(mapView)
        mapView.onDestroy()
    }

    override fun onResume(owner: LifecycleOwner) {
        mapView.onResume()
        super.onResume(owner)
    }

    override fun onDestroy(owner: LifecycleOwner) {
        mapView.onDestroy()
        super.onDestroy(owner)
    }

    override fun onPause(owner: LifecycleOwner) {
        mapView.onPause()
        super.onPause(owner)
    }

    override fun onStart(owner: LifecycleOwner) {
        mapView.onStart()
        super.onStart(owner)
    }

    override fun onStop(owner: LifecycleOwner) {
        mapView.onStop()
        super.onStop(owner)
    }

    override fun onCreate(owner: LifecycleOwner) {
        mapView.onCreate(null)
        super.onCreate(owner)
    }

    override fun onMapReady(mapboxMap: MapboxMap) {
        val defaultStyle = "https://demotiles.maplibre.org/style.json"
        val defaultStyle2 =
            "https://api.maptiler.com/maps/3dd4d51b-ae78-4074-8b31-b47a49f1b5ce/style.json?key=kZ5xAKKbPzxo3GeJ2odT"

        mapboxMap.setStyle(Style.Builder().fromUri(defaultStyle2)) { style ->
            Log.d("Maplibre", "loaded style: $style")
        }
    }
}

class MaplibrePlatformViewFactory(
    private val getLifecycle: () -> Lifecycle,
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return MaplibrePlatformView(
            context = context,
            viewId = viewId,
            args = args as? Map<String, Any?>,
            getLifecycle = getLifecycle
        )
    }
}
