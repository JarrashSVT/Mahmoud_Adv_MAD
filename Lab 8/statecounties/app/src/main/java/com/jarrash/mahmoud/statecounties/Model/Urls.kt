package com.jarrash.mahmoud.statecounties.Model

/**
 * Created by mahmoud on 5/1/18.
 */
object Urls
{
    var stateUrl = "https://mysafeinfo.com/api/data?list=states&format=json&token=aGl1hZa0gNs3kChGFcfTl6MHmM9sMYb2"
    var countyUrl = "https://mysafeinfo.com/api/data?list=statecounties_"

    fun setState(state: String): String
    {
        return this.countyUrl + state.toLowerCase() + "&format=json&token=aGl1hZa0gNs3kChGFcfTl6MHmM9sMYb2"
    }
}