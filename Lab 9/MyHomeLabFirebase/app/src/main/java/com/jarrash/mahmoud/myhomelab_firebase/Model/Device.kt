package com.jarrash.mahmoud.myhomelab_firebase.Model

/**
 * Created by mahmoud on 4/29/18.
 */
class Device
{
    var id: String = ""
    var hostName:String = ""
    var os: String = ""
    var ip: String = ""

    constructor(){}

    constructor(id: String, hostName: String, os: String, ip: String)
    {
        this.id = id
        this.hostName = hostName
        this.os = os
        this.ip = ip
    }
}