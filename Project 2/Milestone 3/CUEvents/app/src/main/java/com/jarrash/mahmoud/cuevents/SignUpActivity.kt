package com.jarrash.mahmoud.cuevents

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.widget.Button
import android.widget.EditText
import android.widget.ProgressBar
import android.widget.Toast
import com.google.firebase.auth.UserProfileChangeRequest
import com.jarrash.mahmoud.cuevents.Services.FirebaseService


class SignUpActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_sign_up)

        val toolbar = findViewById<android.support.v7.widget.Toolbar>(R.id.toolbar)
        toolbar.title = resources.getString(R.string.app_name)
//        toolbar.inflateMenu(R.menu.menu_main)

        val createUserBtn = findViewById<Button>(R.id.createUserBtn)
        createUserBtn.setOnClickListener{
            createUser()
        }
    }

    fun createUser()
    {
        val displayNameTxt = findViewById<EditText>(R.id.displayNameTxt)
        val newEmailTxt = findViewById<EditText>(R.id.newEmailTxt)
        val newPasswordTxt = findViewById<EditText>(R.id.newPasswordTxt)

        val progressBar = findViewById<ProgressBar>(R.id.progressBar)
        progressBar.visibility = View.VISIBLE



        val displayName = displayNameTxt.text.toString()
        val email = newEmailTxt.text.toString()
        val password = newPasswordTxt.text.toString()

        FirebaseService.auth?.createUserWithEmailAndPassword(email, password)?.addOnCompleteListener(this){ task ->
            if(task.isSuccessful)
            {
                progressBar.visibility = View.GONE
                Toast.makeText(this, "Account created successfully", Toast.LENGTH_LONG).show()
                setUserDisplayName(displayName)
                startActivity(Intent(this@SignUpActivity, AddEventActivity ::class.java))
            }
            else
            {
                Toast.makeText(this, "Oops, something went wrong. Please try again", Toast.LENGTH_LONG).show()

            }
        }
    }

    fun setUserDisplayName(displayName: String)
    {
        val user = FirebaseService.auth?.currentUser
        val profileUpdates = UserProfileChangeRequest.Builder()
                .setDisplayName(displayName)
                .build()

        user?.updateProfile(profileUpdates)!!.addOnCompleteListener { task ->
            if (task.isSuccessful) {
                Log.i("", "User profile updated.")
            }
        }
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater?.inflate(R.menu.menu_main, menu)
        return super.onCreateOptionsMenu(menu)
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
