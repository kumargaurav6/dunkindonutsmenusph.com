package com.dunkinph.menu;

import android.content.Context;
import android.content.SharedPreferences;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * Lightweight key-value storage backed by Android SharedPreferences.
 * Exposed to Dart on the "com.dunkinph.menu/storage" method channel.
 */
public class StoragePlugin implements FlutterPlugin, MethodChannel.MethodCallHandler {
    private static final String CHANNEL = "com.dunkinph.menu/storage";
    private static final String PREFS_NAME = "dunkin_ph_menu_prefs";

    private MethodChannel channel;
    private SharedPreferences prefs;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        Context context = binding.getApplicationContext();
        prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        channel = new MethodChannel(binding.getBinaryMessenger(), CHANNEL);
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        if (channel != null) {
            channel.setMethodCallHandler(null);
            channel = null;
        }
        prefs = null;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "getStringList": {
                String key = call.argument("key");
                if (key == null || prefs == null) {
                    result.success(null);
                    return;
                }
                // Stored as a single comma-joined string to avoid Set<String> quirks.
                String joined = prefs.getString(key, null);
                if (joined == null || joined.isEmpty()) {
                    result.success(null);
                    return;
                }
                List<String> out = new ArrayList<>();
                for (String part : joined.split(",", -1)) {
                    if (!part.isEmpty()) {
                        out.add(part);
                    }
                }
                result.success(out);
                return;
            }
            case "setStringList": {
                String key = call.argument("key");
                List<String> value = call.argument("value");
                if (key == null || prefs == null) {
                    result.success(false);
                    return;
                }
                StringBuilder sb = new StringBuilder();
                if (value != null) {
                    for (int i = 0; i < value.size(); i++) {
                        if (i > 0) {
                            sb.append(',');
                        }
                        // Item ids are slug strings without commas.
                        sb.append(value.get(i));
                    }
                }
                prefs.edit().putString(key, sb.toString()).apply();
                result.success(true);
                return;
            }
            default:
                result.notImplemented();
        }
    }
}
