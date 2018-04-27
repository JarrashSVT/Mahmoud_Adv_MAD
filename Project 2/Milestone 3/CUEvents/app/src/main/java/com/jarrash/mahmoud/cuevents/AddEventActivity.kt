package com.jarrash.mahmoud.cuevents

import android.app.Activity
import android.app.DatePickerDialog
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.Menu
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import com.google.firebase.auth.FirebaseUser
import com.jarrash.mahmoud.cuevents.Model.Event
import com.jarrash.mahmoud.cuevents.Services.FirebaseService
import java.util.*

class AddEventActivity : Activity() {

    var loggedInUser: FirebaseUser? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_event)

        val toolbar = findViewById<android.support.v7.widget.Toolbar>(R.id.toolbar)
        toolbar.title = resources.getString(R.string.app_name)
//        toolbar.inflateMenu(R.menu.menu_main)

        loggedInUser = FirebaseService.getLoggedInUser()
        //check if any user is logged in
        if( loggedInUser == null)
        {
            Log.i("AddEventAcvty@onCreate", "No user is logged in")
            startActivity(Intent(this@AddEventActivity, LoginActivity::class.java))
        }
        else
        {
            Log.i("AddEventAcvty@onCreate", "${loggedInUser?.displayName} is logged in")
        }

        val titleTxt = findViewById<EditText>(R.id.eventTitleTxt)
        val descTxt = findViewById<EditText>(R.id.descTxt)
        val campusTxt = findViewById<EditText>(R.id.campusTxt)
        val addressTxt = findViewById<EditText>(R.id.addressTxt)

        val startDateTxt = findViewById<EditText>(R.id.startDateTxt)
        val endDateTxt = findViewById<EditText>(R.id.endDateTxt)

//        startDateTxt.isEnabled = false

        startDateTxt.setOnClickListener {
                getDate(startDateTxt)
        }

        endDateTxt.setOnClickListener{
            getDate(endDateTxt)
        }
        val addEventBtn = findViewById<Button>(R.id.addEventBtn)

        addEventBtn.setOnClickListener {

            val title = titleTxt.text.toString()
            val desc = descTxt.text.toString()
            val campus = campusTxt.text.toString()
            val address = addressTxt.text.toString()
            val startDate = startDateTxt.text.toString()
            val endDate = endDateTxt.text.toString()

            val newEvent = Event(title, campus, address, startDate, endDate, desc,"img")

            addEvent(newEvent)
        }


    }



    fun addEvent(newEvent: Event)
    {
        val eventRef = FirebaseService.eventsRef
        val newEventId = eventRef?.push()?.key

        Log.i("@addEvent", "The new event ID = ${newEventId}")
        Log.i("newEventTitle", newEvent.title)

        eventRef?.child(newEventId)?.setValue(newEvent)?.addOnCompleteListener {task ->
            if(task.isSuccessful) {
                Log.i("@addEvent", "New Event Created Successfully :)")
                Toast.makeText(this,"Event Created Successfully", Toast.LENGTH_SHORT).show()
                startActivity(Intent(this@AddEventActivity, MainActivity::class.java))
            }
            else
            {
                Log.i("@addEvent","Oops, something went wrong.")
                Toast.makeText(this,"Oops, something went wrong! Please try again", Toast.LENGTH_LONG).show()

            }
        }
    }

    override fun onBackPressed() {
        startActivity(Intent(this@AddEventActivity, MainActivity::class.java))
    }

    fun getDate(view: EditText)
    {
        val calendar = Calendar.getInstance()
        val day = calendar.get(Calendar.DAY_OF_MONTH)
        val month = calendar.get(Calendar.MONTH)
        val year = calendar.get(Calendar.YEAR)

        val datePickerDialog = DatePickerDialog(this,android.R.style.Theme_Holo_Dialog, DatePickerDialog.OnDateSetListener { datePicker, year, monthOfYear, dayOfMonth ->
            view.setText("$year/$monthOfYear/$dayOfMonth", TextView.BufferType.EDITABLE)
        }, year, month, day)

        datePickerDialog.show()
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        // Inflate the menu; this adds items to the action bar if it is present.
        menuInflater.inflate(R.menu.menu_main, menu)
        return true
    }

//    override fun onOptionsItemSelected(item: MenuItem): Boolean {
//        // Handle action bar item clicks here. The action bar will
//        // automatically handle clicks on the Home/Up button, so long
//        // as you specify a parent activity in AndroidManifest.xml.
//        return when (item.itemId) {
//            R.id.action_settings -> {
//                FirebaseService.signOut()
//                Toast.makeText(this,"Logged Off 3", Toast.LENGTH_SHORT).show()
//
//                true
//            }
//            else -> super.onOptionsItemSelected(item)
//        }
//    }
}
