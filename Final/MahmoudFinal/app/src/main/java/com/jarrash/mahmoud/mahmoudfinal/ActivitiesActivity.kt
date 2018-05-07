package com.jarrash.mahmoud.mahmoudfinal

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.view.ContextMenu
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.widget.AdapterView
import com.google.firebase.database.DataSnapshot
import com.google.firebase.database.DatabaseError
import com.google.firebase.database.ValueEventListener
import com.jarrash.mahmoud.mahmoudfinal.Adapters.MyActivityAdapter
import com.jarrash.mahmoud.mahmoudfinal.Models.MyActivity
import com.jarrash.mahmoud.mahmoudfinal.Services.FirebaseService
import kotlinx.android.synthetic.main.activity_activities.*
import kotlinx.android.synthetic.main.content_activities.*


class ActivitiesActivity : AppCompatActivity() {

    var myActivities = mutableListOf<MyActivity>()
    lateinit var type: String
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_activities)
        setSupportActionBar(toolbar)

        println(intent.getStringExtra("TYPE"))
        type = intent.getStringExtra("TYPE")
        fab.setOnClickListener { view ->

            val intent2 = Intent(this@ActivitiesActivity, AddActivity::class.java)
            intent2.putExtra("TYPE2", type)
            startActivity(intent2)
        }

        registerForContextMenu(activityList)

        activityList.setOnItemClickListener { parent, view, position, id ->

            val rUrl = myActivities[position].url
            //create new intent
            val intent = Intent(Intent.ACTION_VIEW)
            //add url to intent
            intent.data = Uri.parse(rUrl)
            //start intent
            startActivity(intent)
        }

        FirebaseService.activitiesRef?.addValueEventListener(object : ValueEventListener {
            override fun onCancelled(p0: DatabaseError?) {
                TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
            }

            override fun onDataChange(snapshot: DataSnapshot?) {
                if (snapshot!!.exists())
                {
                    myActivities.clear()
                    for(d in snapshot.children)
                    {
                        val act = d.getValue(MyActivity::class.java)
                        if (act?.type == type) {
                            myActivities.add(act)
                        }
                    }

                    activityList.adapter = MyActivityAdapter(this@ActivitiesActivity, myActivities)

                }
                else
                {
                    activityList.adapter = MyActivityAdapter(this@ActivitiesActivity, myActivities)
                }
            }
        })

    }

    override fun onCreateContextMenu(menu: ContextMenu?, v: View?, menuInfo: ContextMenu.ContextMenuInfo?) {
        super.onCreateContextMenu(menu, v, menuInfo)

        val adapterContextMenuInfo = menuInfo as AdapterView.AdapterContextMenuInfo
        val name = this.myActivities[menuInfo.position].name
        //set the menu title
        menu?.setHeaderTitle("Delete " + name)
        //add the choices to the menu
        menu?.add(1, 1, 1, "Delete")
        menu?.add(2, 2, 2, "Edit")

    }

    override fun onContextItemSelected(item: MenuItem?): Boolean {
        val itemId = item?.itemId
        val info = item?.menuInfo as AdapterView.AdapterContextMenuInfo
        if(itemId == 1) // Delete
        {
            //val info = item.menuInfo as AdapterView.AdapterContextMenuInfo

            val restToRemove = myActivities[info.position]
            Log.i("deviceToRemove", restToRemove.id)

            FirebaseService.activitiesRef?.child(restToRemove.id)?.removeValue()
            myActivities.removeAt(info.position)

        }
        else
        {
            val updateIntent = Intent(this@ActivitiesActivity, EditActivity::class.java)
            updateIntent.putExtra("NAME", myActivities[info.position].name)
            updateIntent.putExtra("URL", myActivities[info.position].url)
            updateIntent.putExtra("ID", myActivities[info.position].id)
            updateIntent.putExtra("TYPE", myActivities[info.position].type)
            startActivity(updateIntent)
        }
        return true
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
            R.id.action_settings -> {
                startActivity(Intent(this@ActivitiesActivity, LoginActivity::class.java))
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }

}
