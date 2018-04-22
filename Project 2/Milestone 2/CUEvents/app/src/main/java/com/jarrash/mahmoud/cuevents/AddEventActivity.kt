package com.jarrash.mahmoud.cuevents

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.widget.Button
import com.google.firebase.auth.FirebaseUser
import com.jarrash.mahmoud.cuevents.Services.FirebaseService

class AddEventActivity : Activity() {

    var loggedInUser: FirebaseUser? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_event)



        loggedInUser = FirebaseService.getLoggedInUser()
        if( loggedInUser == null)
        {
            Log.i("AddEventAcvty@onCreate", "No user is logged in")
            startActivity(Intent(this@AddEventActivity, LoginActivity::class.java))
        }
        else
        {
            Log.i("AddEventAcvty@onCreate", "${loggedInUser?.displayName} is logged in")

        }

        val signOutBtn = findViewById<Button>(R.id.signOutBtn)
        signOutBtn.setOnClickListener {
            FirebaseService.signOut()
            Log.i("AddEventAcvty@onCreate", "SignOut Clicked")
        }
    }
}
