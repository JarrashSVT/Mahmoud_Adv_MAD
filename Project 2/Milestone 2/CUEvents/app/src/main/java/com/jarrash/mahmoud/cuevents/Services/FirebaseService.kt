package com.jarrash.mahmoud.cuevents.Services

import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseUser

/**
 * Created by mahmoud on 4/22/18.
 */

object FirebaseService
{
    //prepare singleton properties
    var auth: FirebaseAuth? = null

    init {
        auth = FirebaseAuth.getInstance()
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