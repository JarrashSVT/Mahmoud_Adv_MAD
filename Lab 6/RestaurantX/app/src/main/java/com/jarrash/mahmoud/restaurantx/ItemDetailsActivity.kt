package com.jarrash.mahmoud.restaurantx

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.widget.ImageView
import android.widget.TextView

class ItemDetailsActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_item_details)

        val nameTxt = findViewById<TextView>(R.id.nameTxt)
        val priceTxt = findViewById<TextView>(R.id.priceTxt)
        val itemImg = findViewById<ImageView>(R.id.itemImg)

        nameTxt.text = intent.getStringExtra("NAME")
        priceTxt.text = "$" + intent.getDoubleExtra("PRICE", 0.0).toString()
        itemImg.setImageResource(intent.getIntExtra("IMG",0))

    }
    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater?.inflate(R.menu.menu_main, menu)
        return super.onCreateOptionsMenu(menu)
    }

    override fun onOptionsItemSelected(item: MenuItem?): Boolean {

        when(item?.itemId)
        {
            R.id.cart -> {
                val i = Intent(this@ItemDetailsActivity, OrderActivity::class.java)
                startActivity(i)
                return true
            }
            else -> return super.onOptionsItemSelected(item)

        }

    }


}
