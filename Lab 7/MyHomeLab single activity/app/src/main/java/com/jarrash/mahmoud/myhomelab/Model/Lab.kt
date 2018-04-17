package com.jarrash.mahmoud.myhomelab.Model

/**
 * Created by mahmoud on 4/13/18.
 */

object Lab
{
    var servers = arrayListOf<Device>()
    var desktops = arrayListOf<Device>()
    var laptops = arrayListOf<Device>()

    // create singleton :)
    init {
        var servers = arrayListOf<Device>(
                Device("Windows", "10.2.5.4", "DNS2012"),
                Device("Windows", "10.2.5.5", "AD2012"),
                Device("Ubuntu", "10.2.4.8", "Web Server")
        )

        var desktops = arrayListOf<Device>(
                Device("Windows", "DCHP", "Cobra03"),
                Device("Mac", "DCHP", "Shelby08")
        )

        var laptops = arrayListOf<Device>(
                Device("Windows", "10.2.5.4", "Terminator03"),
                Device("Ubuntu", "DCHP", "System76"),
                Device("Mac", "DCHP", "Mach1")

        )

        this.servers = servers
        this.desktops = desktops
        this.laptops = laptops
    }


}
/*


class Lab
{
    var servers = arrayListOf<Device>()
    var desktops = arrayListOf<Device>()
    var laptops = arrayListOf<Device>()

    constructor(){}

    constructor(servers: ArrayList<Device>, desktops: ArrayList<Device>, laptops: ArrayList<Device>)
    {
        this.servers = servers
        this.desktops = desktops
        this.laptops = laptops
    }


    fun initLab(): Lab
    {
        var lab = Lab()

        var servers = arrayListOf<Device>(
            Device("Windows", "10.2.5.4", "Terminator2"),
            Device("Mac", "Dynamic", "Cobra08")
        )

        var desktops = arrayListOf<Device>(

                Device("Mac", "Dynamic", "Cobra 45")
        )

        var laptops = arrayListOf<Device>(
                Device("Windows", "10.2.5.4", "Terminator244")

        )

        lab = Lab(servers, desktops, laptops)


        return lab
    }


}
        */