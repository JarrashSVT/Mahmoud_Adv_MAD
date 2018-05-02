package com.jarrash.mahmoud.statecounties

import android.os.AsyncTask
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.view.View
import android.widget.ArrayAdapter
import com.jarrash.mahmoud.statecounties.Model.County
import com.jarrash.mahmoud.statecounties.Model.Urls
import kotlinx.android.synthetic.main.activity_counties.*
import org.json.JSONArray
import java.net.HttpURLConnection
import java.net.URL

class CountiesActivity : AppCompatActivity() {

    val counties = ArrayList<String>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_counties)

        progressBar2.visibility = View.VISIBLE

        val state = intent.getStringExtra("STATE")
        println(state)

        val countyUrl = Urls.setState(state)
        println(countyUrl)
        CountyAsyncTask().execute(countyUrl)

    }


    inner class CountyAsyncTask: AsyncTask<String, String, String>()
    {


        override fun doInBackground(vararg params: String?): String {
            val line: String
            val connection = URL(params[0]).openConnection() as HttpURLConnection
            try {
                connection.connect()
                line  = connection.inputStream.use { it.reader().use { reader -> reader.readText() } }
            }
            finally {
                connection.disconnect()
            }
            return line
        }

        override fun onPostExecute(result: String?) {
            super.onPostExecute(result)
            parseJson(result)
        }
    }

    private fun parseJson(result: String?)
    {
        val jsonArray = JSONArray(result)


        for (i in 0 until jsonArray.length())
        {
            val jsonObject = jsonArray.getJSONObject(i)
            println(jsonObject.toString())
            val county = County(
                    jsonObject.getString("nm")
            )
            counties.add(county.name)
        }

        progressBar2.visibility = View.GONE
        counties_list.adapter = ArrayAdapter(this, android.R.layout.simple_list_item_1, counties)
    }
}
