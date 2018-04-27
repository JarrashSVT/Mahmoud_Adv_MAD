package com.jarrash.mahmoud.cuevents

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import com.google.firebase.auth.FirebaseUser
import com.jarrash.mahmoud.cuevents.Services.FirebaseService

class LoginActivity : Activity() {

    var loggedInUser: FirebaseUser? = null


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login)

        val toolbar = findViewById<android.support.v7.widget.Toolbar>(R.id.toolbar)
        toolbar.title = resources.getString(R.string.app_name)

        val signInBtn = findViewById<Button>(R.id.signInBtn )
        signInBtn.setOnClickListener{
            Login()
        }

        val signUpBtn = findViewById<Button>(R.id.signUpBtn)
        signUpBtn.setOnClickListener{
            val intent = Intent(this@LoginActivity, SignUpActivity::class.java)
            intent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP
            startActivity(intent)
        }

    }
    override fun onBackPressed() {

        loggedInUser = FirebaseService.getLoggedInUser()
        //check if any user is logged in
        if( loggedInUser == null)
        {
            Log.i("@onBackPressed", "No user is logged in")
            startActivity(Intent(this@LoginActivity, MainActivity::class.java))
        }
        else
        {
            Log.i("@onBackPressed", "${loggedInUser?.displayName} is logged in")
        }
        super.onBackPressed()
    }
    private fun Login()
    {
        val emailTxt = findViewById<EditText>(R.id.emailTxt)
        val passwordTxt = findViewById<EditText>(R.id.passwordTxt)

        val email = emailTxt.text.toString()
        val password = passwordTxt.text.toString()

        FirebaseService.auth?.signInWithEmailAndPassword(email, password)?.addOnCompleteListener(this) { task ->
            Log.i("LoginActivity@Login",task.isSuccessful.toString())
            if (task.isSuccessful)
            {
                Toast.makeText(this,"You're logged in",Toast.LENGTH_LONG).show()
                startActivity(Intent(this@LoginActivity, AddEventActivity::class.java))
            }
            else
            {
                Toast.makeText(this,"Wrong username Or password. Please try again",Toast.LENGTH_LONG).show()

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
