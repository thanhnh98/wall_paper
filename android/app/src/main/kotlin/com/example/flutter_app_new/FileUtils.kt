package com.example.flutter_app_new

import android.content.Context
import java.io.File

class FileUtils {
    companion object{
        fun removeFilePath(context: Context, path: String){
            val fdelete = File(path)
            if (fdelete.exists()) {
                if (fdelete.delete()) {
                    //System.out.println("file Deleted :" + path)
                } else {
                    //System.out.println("file not Deleted :" + path)
                }
            }
        }
    }
}