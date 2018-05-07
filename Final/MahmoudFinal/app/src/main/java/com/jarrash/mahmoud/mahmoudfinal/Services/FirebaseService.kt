package com.jarrash.mahmoud.mahmoudfinal.Services

import com.google.firebase.database.DatabaseReference
import com.google.firebase.database.FirebaseDatabase

/**
 * Created by mahmoud on 5/6/18.
 */
object FirebaseService {

    //prepare singleton properties

    var database: FirebaseDatabase? = null
    var activitiesRef: DatabaseReference? = null

    init {

        database = FirebaseDatabase.getInstance()
        activitiesRef = database?.getReference("activities")
    }
}