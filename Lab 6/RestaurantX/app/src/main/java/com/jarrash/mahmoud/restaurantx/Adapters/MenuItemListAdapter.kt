package com.jarrash.mahmoud.restaurantx.Adapters

import android.app.Activity
import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.ImageView
import android.widget.TextView
import com.jarrash.mahmoud.restaurantx.Model.MenuItem
import com.jarrash.mahmoud.restaurantx.R

/**
 * Created by mahmoud on 4/4/18.
 */

class MenuItemListAdapter(private var activity: Activity, private var items: ArrayList<MenuItem>): BaseAdapter()
{
    private class ViewHolder(row: View?)
    {
        var nameTxt: TextView? = null
        var priceTxt: TextView? = null
        var cuisineTxt: TextView? = null
        var itemImg: ImageView? = null

        init
        {
            this.nameTxt = row?.findViewById<TextView>(R.id.nameTxt)
            this.cuisineTxt = row?.findViewById<TextView>(R.id.cuisineTxt)
            this.priceTxt = row?.findViewById<TextView>(R.id.priceTxt)
            this.itemImg = row?.findViewById<ImageView>(R.id.itemImg)
        }
    }
    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        val view: View?
        val viewHolder: MenuItemListAdapter.ViewHolder

        if(convertView == null)
        {
            val inflater = activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            view = inflater.inflate(R.layout.menu_item_list_row, null)
            viewHolder = MenuItemListAdapter.ViewHolder(view)
            view?.tag = viewHolder

        }
        else
        {
            view = convertView
            viewHolder = view.tag as MenuItemListAdapter.ViewHolder
        }

        val menuItem = items[position]

        viewHolder.nameTxt?.text = menuItem.name
        viewHolder.priceTxt?.text = "$" + menuItem.price.toString()
        viewHolder.cuisineTxt?.text = menuItem.cuisine
        viewHolder.itemImg?.setImageResource(menuItem.img)

        return view as View
    }

    override fun getItem(position: Int): Any {
        return items[position]
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun getCount(): Int {
        return items.size
    }

}