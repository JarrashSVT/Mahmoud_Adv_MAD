package com.jarrash.mahmoud.myhomelab

import android.app.Activity
import android.app.Fragment
import android.os.Bundle
import android.util.Log
import com.jarrash.mahmoud.myhomelab.Fragments.MasterFragment

class MainActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        loadFragment(MasterFragment())
        //loadFragment(DetailsFragment())
    }

    private fun loadFragment(fragment: Fragment)
    {
        Log.i("@LoadFragment", "Loading...")
        val ft = fragmentManager.beginTransaction()
        if (fragment is MasterFragment)
        {
            Log.i("@LoadFragment", "MasterFragment")
            ft.replace(R.id.masterFragment, fragment)
        }
        else
        {
            Log.i("@LoadFragment", "DetailsFragment")
            ft.replace(R.id.detailsFragment, fragment)
        }
        ft.commit()
    }


}
