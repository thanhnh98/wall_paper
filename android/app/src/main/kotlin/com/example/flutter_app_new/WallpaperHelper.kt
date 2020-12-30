package com.example.flutter_app_new

import android.app.WallpaperManager
import android.content.Context
import android.graphics.BitmapFactory
import android.os.Build
import io.reactivex.rxjava3.core.Observable
import java.util.*

class WallpaperHelper {
    companion object {
        fun setHomeScreen(context: Context, path: String): Observable<Any> {
            return Observable.just(path)
                    .map {
                        val bitmap = BitmapFactory.decodeFile(path)
                        val wm = WallpaperManager.getInstance(context)
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                            wm.setBitmap(bitmap, null, false, WallpaperManager.FLAG_SYSTEM)
                        } else {
                            wm.setBitmap(bitmap)
                        }
                    }
        }

        fun setLockScreen(context: Context, path: String): Observable<Any> {
            return Observable.just(path)
                    .map {
                        val bitmap = BitmapFactory.decodeFile(path)
                        val wm = WallpaperManager.getInstance(context)
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                            wm.setBitmap(bitmap, null, false, WallpaperManager.FLAG_LOCK)
                        } else {
                            wm.setBitmap(bitmap)
                        }
                    }
        }

        fun setBothScreens(context: Context, path: String): Observable<Any> {
            return setHomeScreen(context, path).flatMap { setLockScreen(context, path) }

        }
    }
}