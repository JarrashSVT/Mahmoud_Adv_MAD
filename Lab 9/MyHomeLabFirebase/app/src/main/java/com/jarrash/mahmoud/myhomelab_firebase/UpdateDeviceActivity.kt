package com.jarrash.mahmoud.myhomelab_firebase

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.widget.Spinner
import com.jarrash.mahmoud.myhomelab_firebase.Model.Device
import com.jarrash.mahmoud.myhomelab_firebase.Services.FirebaseService
import kotlinx.android.synthetic.main.activity_update_device.*



class UpdateDeviceActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_update_device)

        hostNameTxtUpdate.setText(intent.getStringExtra("HOSTNAME"))
        ipTxtUpdate.setText(intent.getStringExtra("IP"))
        osSpinnerUpdate.setText(intent.getStringExtra("OS"))


        updateDeviceBtn.setOnClickListener {
            updateDevice()
        }
    }

    private fun updateDevice()
    {
        val oslist = arrayListOf("Windows", "macOS", "Linux")

        val updatedHostName = hostNameTxtUpdate.text?.toString()
        val updatedIp = ipTxtUpdate.text?.toString()
        val updatedOs = oslist[osSpinnerUpdate.selectedItemPosition]
        val id = intent.getStringExtra("ID")

        val updatedDevice = Device(id ,updatedHostName!!, updatedOs, updatedIp!!)
        FirebaseService.devicesRef?.child(id)?.setValue(updatedDevice)

        startActivity(Intent(this@UpdateDeviceActivity, MainActivity::class.java))
    }
    private fun Spinner.setText(text: String) // extending Spinner funtionality
    {
        for (i in 0 until this.adapter.count) {
            if (this.adapter.getItem(i).toString().contains(text))
            {
                this.setSelection(i)
            }
        }
    }
}
