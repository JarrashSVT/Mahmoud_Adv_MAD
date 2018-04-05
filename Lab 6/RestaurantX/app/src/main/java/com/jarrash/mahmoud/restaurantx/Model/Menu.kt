package com.jarrash.mahmoud.restaurantx.Model

import android.util.Log
import com.jarrash.mahmoud.restaurantx.R

/**
 * Created by mahmoud on 4/2/18.
 */

class Menu
{
    var section: String = ""
    var img: Int = 0
    var items = arrayListOf<MenuItem>()

    constructor() {}

    constructor(section: String, img: Int)
    {
        this.img = img
        this.section = section
    }

    constructor(section: String, img: Int, items: ArrayList<MenuItem>)
    {
        this.img = img
        this.section = section
        this.items = items
    }

    fun getMenu(): ArrayList<Menu>
    {
        var menu = ArrayList<Menu>()
        val breakfastItems = arrayListOf<MenuItem>(
                MenuItem("Fried Eggs", R.drawable.friedeggs,3.99,"International"),
                MenuItem("Eggs Benedict", R.drawable.benedict,9.99,"American"),
                MenuItem("Pancakes", R.drawable.pancakes,4.49, "American"),
                MenuItem("Falafel", R.drawable.falafel, 5.59, "Middle Eastern"),
                MenuItem("Hummus", R.drawable.hummus, 4.99, "Middle Eastern")
        )

        val sandwichesItems = arrayListOf<MenuItem>(
                MenuItem("Cheeseburger", R.drawable.lunch, 8.99, "American"),
                MenuItem("Philly Steak", R.drawable.phillysteak, 10.99, "American"),
                MenuItem("Chicken Shawarma", R.drawable.shawarma, 7.99, "Middle Eastern")
                )

        val pizzaItems = arrayListOf<MenuItem>(
                MenuItem("Veggie", R.drawable.veggie, 12.99, "Italian"),
                MenuItem("Margherita", R.drawable.margherita, 11.99, "Italian"),
                MenuItem("Pepperoni", R.drawable.pepperoni, 13.99, "Italian")
        )

        Log.i("R.drawable.breakfast", R.drawable.breakfast.toString())
        menu.add(Menu("Breakfast", R.drawable.breakfast, breakfastItems))
        menu.add(Menu("Sandwiches", R.drawable.lunch, sandwichesItems))
        menu.add(Menu("Pizza", R.drawable.margherita, pizzaItems))
        return menu
    }
    fun getBreakfast(): ArrayList<MenuItem>
    {
        Log.i("@getBreakfast", "Yaay Breakfast !!")

        return this.getMenu()[0].items
    }


    fun getSandwiches(): ArrayList<MenuItem>
    {
        Log.i("@getSandwiches", "Yaay sandwiches !!")

        return this.getMenu()[1].items
    }

    fun getPizzas(): ArrayList<MenuItem>
    {
        Log.i("@getPizzas", "Yaay Pizza !!")

        return  this.getMenu()[2].items
    }
//    val sections = arrayOf(Menu("Breakfast",0))

}