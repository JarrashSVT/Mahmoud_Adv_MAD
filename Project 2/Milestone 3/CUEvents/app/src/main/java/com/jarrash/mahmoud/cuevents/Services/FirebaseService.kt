package com.jarrash.mahmoud.cuevents.Services

import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseUser
import com.google.firebase.database.DatabaseReference
import com.google.firebase.database.FirebaseDatabase
import com.google.firebase.storage.FirebaseStorage
import com.google.firebase.storage.StorageReference

/**
 * Created by mahmoud on 4/22/18.
 */

object FirebaseService
{
    //prepare singleton properties
    var auth: FirebaseAuth? = null
    var database: FirebaseDatabase? = null
    var eventsRef: DatabaseReference? = null
    var imagesRef: StorageReference? = null

    init {
        auth = FirebaseAuth.getInstance()
        database = FirebaseDatabase.getInstance()
        eventsRef = database?.getReference("production")?.child("events")
        imagesRef = FirebaseStorage.getInstance().reference
    }

    fun getLoggedInUser() : FirebaseUser?
    {
         return  this.auth?.currentUser
    }

    fun signOut()
    {
        this.auth?.signOut()
    }
}