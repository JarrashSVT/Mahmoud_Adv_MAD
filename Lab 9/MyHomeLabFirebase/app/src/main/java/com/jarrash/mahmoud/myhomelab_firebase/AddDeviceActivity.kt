package com.jarrash.mahmoud.myhomelab_firebase

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.widget.Toast
import com.jarrash.mahmoud.myhomelab_firebase.Model.Device
import com.jarrash.mahmoud.myhomelab_firebase.Services.FirebaseService
import kotlinx.android.synthetic.main.activity_add_device.*

class AddDeviceActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_device)



        addDeviceBtn.setOnClickListener {
            if(hostNameTxt.text.isEmpty())
            {
                Toast.makeText(this,"Please fill in the host name", Toast.LENGTH_SHORT).show()
            }
            else {
                addDevice()
            }
        }
    }

    private fun addDevice()
    {

        val oslist = arrayListOf("Windows", "macOS", "Linux") // Resources.getSystem().getStringArray(R.array.osList)
        val hostName = hostNameTxt.text?.toString()
        val os = oslist[osSpinner.selectedItemPosition]
        val ip = ipTxt.text?.toString()

        val newDeviceId = FirebaseService.devicesRef?.push()?.key
        val newDevice = Device(newDeviceId!! ,hostName!!, os,ip!!)

        FirebaseService.devicesRef?.child(newDeviceId)?.setValue(newDevice)?.addOnCompleteListener { task ->
            if(task.isSuccessful)
            {
                Log.i("@onCreate", "New Device Added Successfully :)")
                Toast.makeText(this,"Device Added Successfully", Toast.LENGTH_SHORT).show()
                startActivity(Intent(this@AddDeviceActivity, MainActivity::class.java))
            }
            else
            {
                Log.i("@onCreate","Oops, something went wrong.")
                Toast.makeText(this,"Oops, something went wrong! Please try again", Toast.LENGTH_LONG).show()

            }

        }
    }
}
