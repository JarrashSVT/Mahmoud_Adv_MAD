package com.jarrash.mahmoud.cuevents

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.widget.ListView
import com.google.firebase.database.DataSnapshot
import com.google.firebase.database.DatabaseError
import com.google.firebase.database.FirebaseDatabase
import com.google.firebase.database.ValueEventListener
import com.jarrash.mahmoud.cuevents.Adapters.EventAdapter
import com.jarrash.mahmoud.cuevents.Model.Event
import com.jarrash.mahmoud.cuevents.Services.FirebaseService
import kotlinx.android.synthetic.main.activity_main.*



class MainActivity : AppCompatActivity() {

//    lateinit var ref : DatabaseReference
    var events = mutableListOf<Event>()
    lateinit var eventList: ListView

    override fun onCreate(savedInstanceState: Bundle?)
    {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setSupportActionBar(toolbar)

        Log.i("MainActivity@onCreate","App Started ....")

        fab.setOnClickListener {
            startActivity(Intent(this@MainActivity, AddEventActivity ::class.java))
        }

        eventList = findViewById(R.id.eventList)
        FirebaseService.eventsRef?.addValueEventListener(object : ValueEventListener {

            override fun onCancelled(snapshot: DatabaseError?) {
                TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
            }

            override fun onDataChange(snapshot: DataSnapshot?) {
                Log.i("MainActivity@onCreate","-> onDataChange")
                if (snapshot!!.exists())
                {
                    events.clear()
                    for (e in snapshot.children)
                    {
                        val event = e.getValue(Event ::class.java)
                        Log.i("", event?.title)
                        events.add(event!!)
                    }
                    eventList.adapter = EventAdapter(this@MainActivity, events)
                }
            }
        })


        //******************** checking the firebase connectivity ********************
        val connectedRef = FirebaseDatabase.getInstance().getReference(".info/connected")
        connectedRef.addValueEventListener(object : ValueEventListener {
            override fun onDataChange(snapshot: DataSnapshot) {
                val connected = snapshot.getValue(Boolean::class.java)!!
                if (connected) {
                    Log.i("@connectedRef", "Connected")
                } else {
                    Log.i("@connectedRef", "NOT !!!! Connected")
                }
            }

            override fun onCancelled(error: DatabaseError) {
                Log.i("@connectedRef", "Listener was cancelled")
            }
        })

        //***************************************************************************

        eventList.setOnItemClickListener { parent, view, position, id ->
            Log.i("Position", position.toString())
            val event =  parent.getItemAtPosition(position) as Event

//            val intent = Intent(this@MainActivity, MenuDetailsActivity::class.java)
//            intent.putExtra("SECTION", menu.section)
//            startActivity(intent)
        }


    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        // Inflate the menu; this adds items to the action bar if it is present.
        menuInflater.inflate(R.menu.menu_main, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        return when (item.itemId) {
            R.id.action_settings -> true
            else -> super.onOptionsItemSelected(item)
        }
    }
}
