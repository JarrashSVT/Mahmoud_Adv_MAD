package com.jarrash.mahmoud.cuevents

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.provider.CalendarContract
import android.provider.CalendarContract.Events
import com.jarrash.mahmoud.cuevents.Helpers.DownloadImageTask
import kotlinx.android.synthetic.main.activity_event_details.*
import java.util.*


class EventDetailsActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_event_details)

        val toolbar = findViewById<android.support.v7.widget.Toolbar>(R.id.toolbar)
        toolbar.title = resources.getString(R.string.app_name)
        toolbar.inflateMenu(R.menu.menu_main)


        dTitleTxt.text = intent.getStringExtra("TITLE")
        dDescTxt.text = intent.getStringExtra("DESC")
        dCampusTxt.text = "Campus: " + intent.getStringExtra("CAMPUS")
        dAddressTxt.text = "Address: ${intent.getStringExtra("ADDRESS")}"
        dStartDateTxt.text = "Start Date: " + intent.getStringExtra("STARTDATE")
        dEndDateTxt.text = "End Date: " + intent.getStringExtra("ENDDATE")

        DownloadImageTask(dEventImg).execute(intent.getStringExtra("IMGURL"))

        addToCalendarBtn.setOnClickListener {
            createCalendarEvent()
        }

    }

   fun createCalendarEvent()
    {
        println("Creating a calendar event...")

        //to parse the date > API 26 is required
        val beginTime = Calendar.getInstance()
        // so I've used dummy dates just to demonstrate the functionality
        beginTime.set(2018, 0, 19, 7, 30)
        val endTime = Calendar.getInstance()
        endTime.set(2018, 0, 19, 8, 30)
        val intent = Intent(Intent.ACTION_INSERT)
                .setData(Events.CONTENT_URI)
                .putExtra(CalendarContract.EXTRA_EVENT_BEGIN_TIME, beginTime.timeInMillis)
                .putExtra(CalendarContract.EXTRA_EVENT_END_TIME, endTime.timeInMillis)
                .putExtra(Events.TITLE, dTitleTxt.text)
                .putExtra(Events.DESCRIPTION, dDescTxt.text)
                .putExtra(Events.EVENT_LOCATION, dAddressTxt.text)
                .putExtra(Events.AVAILABILITY, Events.AVAILABILITY_BUSY)
        startActivity(intent)
    }
}
