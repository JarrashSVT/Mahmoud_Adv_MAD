package com.jarrash.mahmoud.cuevents.Model

/**
 * Created by mahmoud on 4/26/18.
 */
class Event
{
    var title: String = ""
    var campus: String = ""
    var address: String = ""
    var startDate: String = ""
    var endDate: String = ""
    var description: String = ""
    var image: String = ""

    constructor() {}

    constructor(title: String, campus: String, address: String,
                startDate: String, endDate: String, description:
                String, image: String)
    {
        this.campus = campus
        this.title = title
        this.startDate = startDate
        this.endDate = endDate
        this.description = description
        this.address = address
        this.image = image


    }
}