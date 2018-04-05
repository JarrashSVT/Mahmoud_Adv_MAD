package com.jarrash.mahmoud.restaurantx.Adapters

import android.app.Activity
import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.ImageView
import android.widget.TextView
import com.jarrash.mahmoud.restaurantx.Model.Menu
import com.jarrash.mahmoud.restaurantx.R

/**
 * Created by mahmoud on 4/2/18.
 */


class MenuListAdapter( private var activity: Activity, private var sections: ArrayList<Menu>): BaseAdapter()
{
    private class ViewHolder(row: View?)
    {
        var sectionTitle: TextView? = null
        var sectionImg: ImageView? = null

        init
        {
            this.sectionTitle = row?.findViewById<TextView>(R.id.sectionTitle)
            this.sectionImg = row?.findViewById<ImageView>(R.id.sectionImg)
        }
    }

    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        val view: View?
        val viewHolder: ViewHolder

        if(convertView == null)
        {
            val inflater = activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            view = inflater.inflate(R.layout.menu_list_row, null)
            viewHolder = ViewHolder(view)
            view?.tag = viewHolder

        }
        else
        {
            view = convertView
            viewHolder = view.tag as ViewHolder
        }

        var menu = sections[position]
        viewHolder.sectionTitle?.text = menu.section
        viewHolder.sectionImg?.setImageResource(menu.img)

        return view as View
    }

    override fun getItem(position: Int): Any {
        return sections[position]
    }

    override fun getItemId(position: Int): Long {
        return  position.toLong()
    }

    override fun getCount(): Int {
        return sections.size
    }

}