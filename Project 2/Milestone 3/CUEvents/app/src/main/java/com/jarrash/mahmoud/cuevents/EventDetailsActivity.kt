package com.jarrash.mahmoud.cuevents

import android.app.Activity
import android.os.Bundle
import android.widget.TextView

class EventDetailsActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_event_details)

        val toolbar = findViewById<android.support.v7.widget.Toolbar>(R.id.toolbar)
        toolbar.title = resources.getString(R.string.app_name)
        toolbar.inflateMenu(R.menu.menu_main)

        val titleTxt = findViewById<TextView>(R.id.dTitleTxt)
        val descTxt = findViewById<TextView>(R.id.dDescTxt)
        val campusTxt = findViewById<TextView>(R.id.dCampusTxt)
        val addressTxt = findViewById<TextView>(R.id.dAddressTxt)
        val startDateTxt = findViewById<TextView>(R.id.dStartDateTxt)
        val endDateTxt = findViewById<TextView>(R.id.dEndDateTxt)

        titleTxt.text = intent.getStringExtra("TITLE")
        descTxt.text = intent.getStringExtra("DESC")
        campusTxt.text = "Campus: " + intent.getStringExtra("CAMPUS")
        addressTxt.text = "Address: ${intent.getStringExtra("ADDRESS")}"
        startDateTxt.text = "Start Date: " + intent.getStringExtra("STARTDATE")
        endDateTxt.text = "End Date: " + intent.getStringExtra("ENDDATE")

    }
}
