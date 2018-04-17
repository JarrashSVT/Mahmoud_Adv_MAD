package com.jarrash.mahmoud.myhomelab.Adapters

import android.app.Activity
import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.ImageView
import android.widget.TextView
import com.jarrash.mahmoud.myhomelab.Model.Device
import com.jarrash.mahmoud.myhomelab.R

/**
 * Created by mahmoud on 4/13/18.
 */

class DevicesAdapter(private var activity: Activity, private var devices: ArrayList<Device>): BaseAdapter()
{
    private class ViewHolder(row: View?)
    {
        var hostNameTxt: TextView? = null
        var ipTxt: TextView? = null
        var osImage: ImageView? = null

        init
        {
            this.hostNameTxt = row?.findViewById(R.id.hostNameTxt)
            this.osImage = row?.findViewById(R.id.osImage)
            this.ipTxt = row?.findViewById(R.id.ipTxt)
        }
    }
    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {

        val view: View?
        val viewHolder: ViewHolder

        if(convertView == null)
        {
            val inflater = activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            view = inflater.inflate(R.layout.device_row , null)
            viewHolder = ViewHolder(view)
            view?.tag = viewHolder

        }
        else
        {
            view = convertView
            viewHolder = view.tag as ViewHolder
        }

        val device = devices[position]
        viewHolder.hostNameTxt?.text = device.hostName
        viewHolder.ipTxt?.text = device.ip

        when(device.os)
        {
            "Windows" -> viewHolder.osImage?.setImageResource(R.drawable.windows)
            "Mac" -> viewHolder.osImage?.setImageResource(R.drawable.apple)
            "Ubuntu" ->  viewHolder.osImage?.setImageResource(R.drawable.ubuntu)
        }

        return view as View

    }

    override fun getItem(position: Int): Any {
        return devices[position]
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun getCount(): Int {
        return devices.size
    }
}