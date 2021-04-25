package com.example.flutter_app_new

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.schedulers.Schedulers
import java.lang.reflect.Method

class MainActivity: FlutterActivity() {
    private val UPDATE_WALLPAPER_CHANNEL = "update_wallpaper"
    private val DEEPLINK_CHANNEL = "deeplink_channel"
    private val HOME_SCREEN = "set_home_screen"
    private val  LOCK_SCREEN = "set_lock_screen"
    private val  BOTH_SCREENS = "set_both_screens"
    private lateinit var deeplinkChannel: MethodChannel
    private var lastIntent: Intent? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        deeplinkChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, DEEPLINK_CHANNEL);
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, UPDATE_WALLPAPER_CHANNEL).setMethodCallHandler {
            call, result ->
                handleWallpaperMethod(call, result)
        }
        deeplinkChannel.setMethodCallHandler { call, result ->
            if (call.method.equals("handle_deeplink")){
                if (lastIntent?.data == null)
                    return@setMethodCallHandler
                result.success(lastIntent?.data?.toString())
                clearLastIntent()
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        saveIntentState(intent)
    }
    private fun handleWallpaperMethod(call: MethodCall, result: MethodChannel.Result){
        val path = call.arguments.toString()
        var observable: Observable<Any>? = null

        observable = when(call.method){
            HOME_SCREEN -> WallpaperHelper.setHomeScreen(context, path)
            LOCK_SCREEN -> WallpaperHelper.setLockScreen(context, path)
            BOTH_SCREENS -> WallpaperHelper.setBothScreens(context, path)
            else -> null
        }

        if (observable == null){
            result.notImplemented()
        }
        else{
            observable.subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribe ({
                        //FileUtils.removeFilePath(context, path)
                        //Log.e("success", path)
                        result.success(path)
                    }, {
                        //FileUtils.removeFilePath(context, path)
                        result.success("null")
                    })
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        saveIntentState(intent)
    }

    private  fun clearLastIntent(){
        lastIntent = null
    }

    private fun saveIntentState(intent: Intent?){
        lastIntent = intent
        deeplinkChannel.invokeMethod("open_deeplink", lastIntent?.data.toString())
    }
}
