package com.example.flutter_app_new

import android.app.WallpaperManager
import android.graphics.BitmapFactory
import android.os.Build
import android.widget.Toast
import com.mulgundkar.wallpaper_manager.WallpaperManagerPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.schedulers.Schedulers
import java.io.IOException
import java.util.*

class MainActivity: FlutterActivity() {
    private val UPDATE_WALLPAPER_CHANNEL = "update_wallpaper"
    private val HOME_SCREEN = "set_home_screen"
    private val  LOCK_SCREEN = "set_lock_screen"
    private val  BOTH_SCREENS = "set_both_screens"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, UPDATE_WALLPAPER_CHANNEL).setMethodCallHandler { call, result -> handleWallpaperMethod(call, result)
        }
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
                        result.success("ok")
                    }, {
                        result.notImplemented()
                    })
        }
    }
}
