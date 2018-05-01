package com.jarrash.mahmoud.myhomelab_firebase.Services

import com.google.firebase.database.DatabaseReference
import com.google.firebase.database.FirebaseDatabase

/**
 * Created by mahmoud on 4/29/18.
 */
object FirebaseService {


    //prepare singleton properties

    var database: FirebaseDatabase? = null
    var devicesRef: DatabaseReference? = null

    init {

        database = FirebaseDatabase.getInstance()
        devicesRef = database?.getReference("devices")
    }

}