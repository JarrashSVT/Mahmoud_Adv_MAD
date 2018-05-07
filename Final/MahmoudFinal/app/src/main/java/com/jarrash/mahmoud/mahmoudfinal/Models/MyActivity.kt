package com.jarrash.mahmoud.mahmoudfinal.Models

/**
 * Created by mahmoud on 5/6/18.
 */
class MyActivity {

    var id: String = ""
    var name: String = ""
    var url: String = ""
    var type: String =""

    constructor(){}

    constructor(name:String, url: String)
    {
        this.name = name
        this.url = url
    }

    constructor(id: String, name:String, url: String, type:String)
    {
        this.id = id
        this.name = name
        this.url = url
        this.type = type
    }
}