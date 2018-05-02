package com.jarrash.mahmoud.statecounties

import android.content.Intent
import android.os.AsyncTask
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.view.View
import com.jarrash.mahmoud.statecounties.Adapters.StateAdapter
import com.jarrash.mahmoud.statecounties.Model.State
import com.jarrash.mahmoud.statecounties.Model.Urls
import kotlinx.android.synthetic.main.activity_main.*
import org.json.JSONArray
import java.net.HttpURLConnection
import java.net.URL

class MainActivity : AppCompatActivity() {

    var statesList = ArrayList<State>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)


        progressBar1.visibility = View.VISIBLE

        StateAsyncTask().execute(Urls.stateUrl)

        states_List.setOnItemClickListener { parent, view, position, id ->
            val intent = Intent(this@MainActivity, CountiesActivity::class.java)
            intent.putExtra("STATE", statesList[position].abbreviation)
            intent.putExtra("STATENAME", statesList[position].name)

            startActivity(intent)
        }
    }

    inner class StateAsyncTask: AsyncTask<String, String, String>()
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
            val state = State(
                    jsonObject.getString("nm"),
                    jsonObject.getString("cp"),
                    jsonObject.getString("ab")
            )
            statesList.add(state)
        }

        progressBar1.visibility = View.GONE
        states_List.adapter = StateAdapter(this@MainActivity, statesList)
    }
}
