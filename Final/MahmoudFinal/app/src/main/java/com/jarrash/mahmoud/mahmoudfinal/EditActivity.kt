package com.jarrash.mahmoud.mahmoudfinal

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.view.Menu
import android.view.MenuItem
import com.jarrash.mahmoud.mahmoudfinal.Models.MyActivity
import com.jarrash.mahmoud.mahmoudfinal.Services.FirebaseService
import kotlinx.android.synthetic.main.activity_edit.*

class EditActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_edit)
        activityNameTxtUpdate.setText(intent.getStringExtra("NAME"))
        activityUrlTxtUpdate.setText(intent.getStringExtra("URL"))


        updateBtn.setOnClickListener {
            updateActivity()
        }
    }

    private fun updateActivity()
    {
        val updatedName = activityNameTxtUpdate.text?.toString()
        val updatedUrl = activityUrlTxtUpdate.text?.toString()
        val id = intent.getStringExtra("ID")
        val type = intent.getStringExtra("TYPE")

        val updatedActivity = MyActivity(id,updatedName!!, updatedUrl!!, type)

        FirebaseService.activitiesRef?.child(id)?.setValue(updatedActivity)

        val i = Intent(this@EditActivity, ActivitiesActivity::class.java)
        i.putExtra("TYPE",type)
        startActivity(i)
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
                startActivity(Intent(this@EditActivity, LoginActivity::class.java))
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }
}
