package com.jarrash.mahmoud.restaurantx

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.MenuItem
import android.widget.ListView
import com.jarrash.mahmoud.restaurantx.Adapters.MenuListAdapter
import com.jarrash.mahmoud.restaurantx.Model.Menu


class MainActivity : Activity() {

    var  menuList: ListView? = null
    var menuDetailsActivity = MenuDetailsActivity::class.java

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        menuList = findViewById(R.id.mainMenuList)

        var adapter = MenuListAdapter(this, Menu().getMenu())
        menuList?.adapter = adapter

        menuList?.setOnItemClickListener { parent, view, position, id ->
            Log.i("Position", position.toString())
            val menu =  parent.getItemAtPosition(position) as Menu
            Log.i("Section: ", menu.section)

            val intent = Intent(this@MainActivity, MenuDetailsActivity::class.java)
            intent.putExtra("SECTION", menu.section)
            startActivity(intent)

        }
    }

    override fun onCreateOptionsMenu(menu: android.view.Menu?): Boolean {
        menuInflater?.inflate(R.menu.menu_main, menu)
        return super.onCreateOptionsMenu(menu)
    }


    override fun onOptionsItemSelected(item: MenuItem?): Boolean {

        when(item?.itemId)
        {
            R.id.cart -> {
                val i = Intent(this@MainActivity, OrderActivity::class.java)
                startActivity(i)
                return true
            }
            else -> return super.onOptionsItemSelected(item)

        }

    }


}
