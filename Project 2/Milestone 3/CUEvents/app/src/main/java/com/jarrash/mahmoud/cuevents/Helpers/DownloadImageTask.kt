package com.jarrash.mahmoud.cuevents.Helpers

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.AsyncTask
import android.util.Log
import android.widget.ImageView


/**
 * Created by mahmoud on 4/29/18.
 */
class DownloadImageTask(var bmImage: ImageView) : AsyncTask<String, Void, Bitmap>() {
    override fun doInBackground(vararg urls: String): Bitmap? {
        val urldisplay = urls[0]

        var mIcon: Bitmap? = null
        try {
            val inputStream = java.net.URL(urldisplay).openStream()
            //creates a bitmap from the input stream
            mIcon = BitmapFactory.decodeStream(inputStream)
        } catch (e: Exception) {
            Log.e("Error", e.message)
            e.printStackTrace()
        }

        return mIcon
    }

    override fun onPostExecute(result: Bitmap) {
        bmImage.setImageBitmap(result)
    }
}