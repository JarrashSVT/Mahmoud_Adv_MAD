package com.jarrash.mahmoud.cuevents.Adapters

import android.app.Activity
import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.ImageView
import android.widget.TextView
import com.jarrash.mahmoud.cuevents.Helpers.DownloadImageTask
import com.jarrash.mahmoud.cuevents.Model.Event
import com.jarrash.mahmoud.cuevents.R

/**
 * Created by mahmoud on 4/26/18.
 */
class EventAdapter(private var activity: Activity, private var events: MutableList<Event>) : BaseAdapter()
{
    private class ViewHolder(row: View?)
    {
        var eventTitleTxt: TextView? = null
        var eventImg: ImageView? = null
        var campusTxt: TextView? = null

        init
        {
            this.eventTitleTxt = row?.findViewById<TextView>(R.id.titleTxt_row)
            this.campusTxt = row?.findViewById(R.id.campusTxt_row)
            this.eventImg = row?.findViewById<ImageView>(R.id.eventImg_row)
            this.eventImg?.setImageResource(android.R.color.transparent)
        }
    }


    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        val view: View?
        val viewHolder: EventAdapter.ViewHolder

        if(convertView == null)
        {
            val inflater = activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            view = inflater.inflate(R.layout.event_row, null)
            viewHolder = EventAdapter.ViewHolder(view)
            view?.tag = viewHolder

        }
        else
        {
            view = convertView
            viewHolder = view.tag as EventAdapter.ViewHolder
        }

        val event = events[position]

        viewHolder.eventTitleTxt?.text = event.title
        viewHolder.campusTxt?.text = event.campus
        viewHolder.eventImg!!.setImageResource(android.R.color.transparent)
        val imgUrl = event.image
        DownloadImageTask(viewHolder.eventImg!!).execute(imgUrl)
//        viewHolder.eventImg?.setImageURI(Uri.parse(event.image))
//        viewHolder.nameTxt?.text = menuItem.name
//        viewHolder.priceTxt?.text = "$" + menuItem.price.toString()
//        viewHolder.cuisineTxt?.text = menuItem.cuisine
//        viewHolder.itemImg?.setImageResource(menuItem.img)

        return view as View
    }

    override fun getItem(position: Int): Any {
        return events[position]
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun getCount(): Int {
        return events.size
    }
}