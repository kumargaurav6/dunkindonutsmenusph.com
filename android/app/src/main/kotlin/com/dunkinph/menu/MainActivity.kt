package com.dunkinph.menu

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Favorites persistence backed by SharedPreferences.
        flutterEngine.plugins.add(StoragePlugin())
    }
}
