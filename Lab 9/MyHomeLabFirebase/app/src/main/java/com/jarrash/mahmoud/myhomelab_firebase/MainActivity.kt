package com.jarrash.mahmoud.myhomelab_firebase

import android.content.Intent
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
import com.jarrash.mahmoud.myhomelab_firebase.Adapters.DevicesAdapter
import com.jarrash.mahmoud.myhomelab_firebase.Model.Device
import com.jarrash.mahmoud.myhomelab_firebase.Services.FirebaseService
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.content_main.*

class MainActivity : AppCompatActivity() {

    var devices = mutableListOf<Device>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setSupportActionBar(toolbar)

        fab.setOnClickListener { view ->
            startActivity(Intent(this@MainActivity, AddDeviceActivity::class.java))
        }

        registerForContextMenu(devicesList)

        devicesList.setOnItemClickListener { parent, view, position, id ->
            val device = devices[position]

            val intent = Intent(this@MainActivity, UpdateDeviceActivity::class.java)
            intent.putExtra("HOSTNAME", device.hostName)
            intent.putExtra("IP", device.ip)
            intent.putExtra("OS", device.os)
            intent.putExtra("ID", device.id)
            startActivity(intent)
        }

//        devicesList.adapter = DevicesAdapter(this@MainActivity, devices)

        FirebaseService.devicesRef?.addValueEventListener(object : ValueEventListener{
            override fun onCancelled(p0: DatabaseError?) {
                TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
            }

            override fun onDataChange(snapshot: DataSnapshot?) {
                if (snapshot!!.exists())
                {
                    devices.clear()
                    for(d in snapshot.children)
                    {
                        val device = d.getValue(Device::class.java)
                        devices.add(device!!)
                    }

                    devicesList.adapter = DevicesAdapter(this@MainActivity, devices)
//                    DevicesAdapter(this@MainActivity, devices).notifyDataSetChanged()

                }
                else
                {
                    devicesList.adapter = DevicesAdapter(this@MainActivity, devices)
                }
            }
        })
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        // Inflate the menu; this adds items to the action bar if it is present.
//        menuInflater.inflate(R.menu.menu_main, menu)
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

    override fun onCreateContextMenu(menu: ContextMenu?, v: View?, menuInfo: ContextMenu.ContextMenuInfo?) {
        super.onCreateContextMenu(menu, v, menuInfo)

        val adapterContextMenuInfo = menuInfo as AdapterView.AdapterContextMenuInfo
        val hostName = this.devices[menuInfo.position].hostName
        //set the menu title
        menu?.setHeaderTitle("Delete " + hostName)
        //add the choices to the menu
        menu?.add(1, 1, 1, "Yes")
        menu?.add(2, 2, 2, "No")
    }

    override fun onContextItemSelected(item: MenuItem?): Boolean {
        val itemId = item?.itemId

        if(itemId == 1) // yes
        {
            val info = item.menuInfo as AdapterView.AdapterContextMenuInfo

            val deviceToRemove = devices[info.position]
            Log.i("deviceToRemove", deviceToRemove.id)

            FirebaseService.devicesRef?.child(deviceToRemove.id)?.removeValue()
            devices.removeAt(info.position)
//            DevicesAdapter(this@MainActivity, devices).notifyDataSetChanged()

        }
        return true
    }
}
