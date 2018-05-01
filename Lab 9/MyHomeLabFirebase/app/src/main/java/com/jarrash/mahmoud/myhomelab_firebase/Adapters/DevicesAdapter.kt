package com.jarrash.mahmoud.myhomelab_firebase.Adapters

import android.app.Activity
import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.TextView
import com.jarrash.mahmoud.myhomelab_firebase.Model.Device
import com.jarrash.mahmoud.myhomelab_firebase.R

/**
 * Created by mahmoud on 4/29/18.
 */
class DevicesAdapter(private val activity: Activity, private val devices: MutableList<Device>) :BaseAdapter()
{
    private class ViewHolder(row: View?)
    {
        var hostNameTxt: TextView? = null
        var ipTxt: TextView? = null
        var osTxt: TextView? = null

        init
        {
            this.hostNameTxt = row?.findViewById(R.id.hostName_row)
            this.ipTxt = row?.findViewById(R.id.ipTxt_row)
            this.osTxt = row?.findViewById(R.id.osTxt_row)
        }
    }
    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        val view: View?
        val viewHolder: DevicesAdapter.ViewHolder

        if(convertView == null)
        {
            val inflater = activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            view = inflater.inflate(R.layout.device_row, null)
            viewHolder = DevicesAdapter.ViewHolder(view)
            view?.tag = viewHolder

        }
        else
        {
            view = convertView
            viewHolder = view.tag as DevicesAdapter.ViewHolder
        }

        val device = devices[position]

        viewHolder.hostNameTxt?.text = device.hostName
        viewHolder.ipTxt?.text = device.ip
        viewHolder.osTxt?.text = device.os

        return view as View
    }

    override fun getItem(position: Int): Any {
        return devices[position]
    }

    override fun getItemId(position: Int): Long {
        return  position.toLong()
    }

    override fun getCount(): Int {
        return devices.size
    }
}