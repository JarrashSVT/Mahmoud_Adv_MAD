package com.jarrash.mahmoud.cuevents

import android.app.Activity
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem

class SignUpActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_sign_up)

        val toolbar = findViewById<android.support.v7.widget.Toolbar>(R.id.toolbar)
        toolbar.title = resources.getString(R.string.app_name)
        toolbar.inflateMenu(R.menu.menu_main)
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
