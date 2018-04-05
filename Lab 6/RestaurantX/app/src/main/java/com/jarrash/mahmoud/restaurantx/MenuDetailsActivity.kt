package com.jarrash.mahmoud.restaurantx

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.widget.ListView
import com.jarrash.mahmoud.restaurantx.Adapters.MenuItemListAdapter
import com.jarrash.mahmoud.restaurantx.Model.Menu
import com.jarrash.mahmoud.restaurantx.Model.MenuItem

class MenuDetailsActivity : Activity() {

    var menuItems = arrayListOf<MenuItem>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_menu_details)

        var itemsList = findViewById<ListView>(R.id.detailMenuList)

        val section = intent.getStringExtra("SECTION")
        Log.i("MenuDetailsActivity ==>", section)

        when(section)
        {
            "Breakfast" -> this.menuItems = Menu().getBreakfast()
            "Sandwiches" -> this.menuItems = Menu().getSandwiches()
            "Pizza" -> this.menuItems = Menu().getPizzas()
        }

        val adapter = MenuItemListAdapter(this, menuItems)
        itemsList?.adapter = adapter

        itemsList?.setOnItemClickListener { parent, view, position, id ->
            val intent = Intent(this@MenuDetailsActivity, ItemDetailsActivity::class.java)
            val menuItem = parent.getItemAtPosition(position) as MenuItem
            intent.putExtra("NAME", menuItem.name)
            intent.putExtra("PRICE", menuItem.price)
            intent.putExtra("IMG", menuItem.img)
            intent.putExtra("CUISINE", menuItem.cuisine)

            startActivity(intent)
        }
    }

    override fun onCreateOptionsMenu(menu: android.view.Menu?): Boolean {
        menuInflater?.inflate(R.menu.menu_main, menu)
        return super.onCreateOptionsMenu(menu)
    }

    override fun onOptionsItemSelected(item: android.view.MenuItem?): Boolean {

        when(item?.itemId)
        {
            R.id.cart -> {
                val i = Intent(this@MenuDetailsActivity, OrderActivity::class.java)
                startActivity(i)
                return true
            }
            else -> return super.onOptionsItemSelected(item)

        }

    }
}
