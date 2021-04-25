package com.example.flutter_app_new

import android.app.WallpaperManager
import android.content.Context
import android.graphics.Bitmap
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

        fun decodeSampledBitmapFromFilePath(filepath: String, reqWidth: Int, reqHeight: Int): Bitmap? {

            // First decode with inJustDecodeBounds=true to check dimensions
            val options = BitmapFactory.Options()
            options.inJustDecodeBounds = true
            BitmapFactory.decodeFile(filepath, options)

            // Calculate inSampleSize
            options.inSampleSize = calculateInSampleSize(options, reqWidth, reqHeight)
            if(options.outHeight == 0 && options.outWidth == 0){
                return null
            }
            // Decode bitmap with inSampleSize set
            options.inJustDecodeBounds = false
            return BitmapFactory.decodeFile(filepath, options)
        }

        /**
         * Method to calculate a sample size value that is a power of two based on a target width and height.
         * @param options
         * @param reqWidth
         * @param reqHeight
         * @return sampleSize
         */
        fun calculateInSampleSize(options: BitmapFactory.Options, reqWidth: Int, reqHeight: Int): Int {
            // Raw height and width of image
            val height = options.outHeight
            val width = options.outWidth
            var inSampleSize = 1

            if (height > reqHeight || width > reqWidth) {

                /* val halfHeight = height / 2
                 val halfWidth = width / 2

                 // Calculate the largest inSampleSize value that is a power of 2 and keeps both
                 // height and width larger than the requested height and width.
                 while (halfHeight / inSampleSize >= reqHeight && halfWidth / inSampleSize >= reqWidth) {
                     inSampleSize *= 2
                 }*/
                if (width > height) {
                    inSampleSize = Math.round(width.toFloat() / reqWidth.toFloat())
                } else {
                    inSampleSize = Math.round(height.toFloat() / reqHeight.toFloat())
                }
            }

            return inSampleSize
        }
    }
}