package com.jarrash.mahmoud.mahmoudfinal.Adapters

import android.app.Activity
import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.TextView
import com.jarrash.mahmoud.mahmoudfinal.Models.MyActivity
import com.jarrash.mahmoud.mahmoudfinal.R

/**
 * Created by mahmoud on 5/6/18.
 */
class MyActivityAdapter(val activity: Activity, val myActivities: MutableList<MyActivity>) : BaseAdapter()
{

    private class ViewHolder(row: View?)
    {
        var actNameTxt: TextView? = null
        var actUrlTxt: TextView? = null

        init
        {
            this.actNameTxt = row?.findViewById(R.id.actNameTxt)
            this.actUrlTxt = row?.findViewById(R.id.actUrlTxt)
        }
    }
    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        val view: View?
        val viewHolder: MyActivityAdapter.ViewHolder

        if(convertView == null)
        {
            val inflater = activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            view = inflater.inflate(R.layout.activity_row, null)
            viewHolder = MyActivityAdapter.ViewHolder(view)
            view?.tag = viewHolder

        }
        else
        {
            view = convertView
            viewHolder = view.tag as MyActivityAdapter.ViewHolder
        }

        val myActivity = myActivities[position]

        viewHolder.actNameTxt?.text = myActivity.name
        viewHolder.actUrlTxt?.text = myActivity.url

        return view as View
    }

    override fun getItem(position: Int): Any {
        return myActivities[position]
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun getCount(): Int {
        return myActivities.size
    }
}