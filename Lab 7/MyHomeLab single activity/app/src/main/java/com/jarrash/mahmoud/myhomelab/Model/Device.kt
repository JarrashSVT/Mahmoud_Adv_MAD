package com.jarrash.mahmoud.myhomelab.Model

/**
 * Created by mahmoud on 4/13/18.
 */

class Device
{
    var os :String = ""
    var ip: String = "DHCP"
    var hostName: String = ""

    var myServers = arrayListOf<Device>()
    constructor(){}

    constructor(os: String, ip: String, hostName: String)
    {
        this.hostName = hostName
        this.os = os
        this.ip = ip
    }



//    fun getServers(): ArrayList<Device>
//    {
////        val servers = this.myServers
//
//        this.myServers.add(Device("Windows", "10.2.50.40", "DeServer"))
//
//        return this.myServers
//    }

//    fun addServer(hostName: String, ip: String, os: String): ArrayList<Device>
//    {
////        val servers = this.myServers
//        this.myServers.add(Device(hostName,ip,os))
//        return this.myServers
//    }

}