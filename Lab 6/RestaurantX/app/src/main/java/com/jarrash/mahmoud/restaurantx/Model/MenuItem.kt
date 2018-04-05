package com.jarrash.mahmoud.restaurantx.Model

/**
 * Created by mahmoud on 4/4/18.
 */
class MenuItem
{
    var name: String = ""
    var img: Int = 0
    var price: Double = 0.0
    var cuisine: String = ""

    constructor() {}

    constructor(name: String, img: Int, price: Double, cuisine: String)
    {
        this.img = img
        this.name = name
        this.price = price
        this.cuisine = cuisine
    }
}