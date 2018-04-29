package com.jarrash.mahmoud.cuevents

import android.app.Activity
import android.os.Bundle
import com.jarrash.mahmoud.cuevents.Helpers.DownloadImageTask
import kotlinx.android.synthetic.main.activity_event_details.*

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

    }
}
