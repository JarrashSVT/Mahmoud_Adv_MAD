package com.jarrash.mahmoud.cuevents

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import com.jarrash.mahmoud.cuevents.Services.FirebaseService

class LoginActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login)

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
                Toast.makeText(this,"Yaay, you're logged in",Toast.LENGTH_LONG).show()
                startActivity(Intent(this@LoginActivity, AddEventActivity::class.java))
            }
            else
            {
                Toast.makeText(this,"FUCK U",Toast.LENGTH_LONG).show()

            }
        }

    }

}
