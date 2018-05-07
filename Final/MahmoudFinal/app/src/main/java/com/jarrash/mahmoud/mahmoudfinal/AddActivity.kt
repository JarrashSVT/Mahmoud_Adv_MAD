package com.jarrash.mahmoud.mahmoudfinal

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.widget.Toast
import com.jarrash.mahmoud.mahmoudfinal.Models.MyActivity
import com.jarrash.mahmoud.mahmoudfinal.Services.FirebaseService
import kotlinx.android.synthetic.main.activity_add.*

class AddActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add)


        Log.i("WWWWW","WWwwwwwwwwww")
        addBtn.setOnClickListener {
            if(activityNameTxt.text.isEmpty())
            {
                Toast.makeText(this,"Please fill in the activity name", Toast.LENGTH_SHORT).show()
            }
            else {
                println("---------addActivity()")
                addActivity()
            }
        }

    }

    private fun addActivity()
    {
        val name = activityNameTxt.text?.toString()
        val url = activityUrlTxt.text?.toString()
        val type = intent.getStringExtra("TYPE2")

        val newActivityId = FirebaseService.activitiesRef?.push()?.key
        val newActivity =  MyActivity(newActivityId!!, name!!, url!!, type)  // Device(newDeviceId!! ,hostName!!, os,ip!!)

        FirebaseService.activitiesRef?.child(newActivityId)?.setValue(newActivity)?.addOnCompleteListener { task ->
            if(task.isSuccessful)
            {
                Log.i("@onCreate", "New Activity Added Successfully :)")
                Toast.makeText(this,"Activity Added Successfully", Toast.LENGTH_SHORT).show()

                val i = Intent(this@AddActivity, ActivitiesActivity::class.java)
                i.putExtra("TYPE",type)
                startActivity(i)
            }
            else
            {
                Log.i("@onCreate","Oops, something went wrong.")
                Toast.makeText(this,"Oops, something went wrong! Please try again", Toast.LENGTH_LONG).show()

            }

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
            R.id.action_settings -> {
                startActivity(Intent(this@AddActivity, LoginActivity::class.java))
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }
}
