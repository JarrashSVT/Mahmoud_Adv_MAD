package com.jarrash.mahmoud.statecounties.Adapters

import android.app.Activity
import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.TextView
import com.jarrash.mahmoud.statecounties.Model.State
import com.jarrash.mahmoud.statecounties.R

/**
 * Created by mahmoud on 5/1/18.
 */
class StateAdapter(private val activity: Activity, private val states: ArrayList<State>): BaseAdapter()
{
    private class ViewHolder(row: View?)
    {
        var nameTxt: TextView? = null
        var capitalTxt: TextView? = null
        var abbreviationTxt: TextView? = null


        init
        {
            this.nameTxt = row?.findViewById<TextView>(R.id.nameTxt)
            this.capitalTxt = row?.findViewById<TextView>(R.id.capitalTxt)
            this.abbreviationTxt = row?.findViewById<TextView>(R.id.abbreviationTxt)
        }
    }
    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        val view: View?
        val viewHolder: StateAdapter.ViewHolder

        if(convertView == null)
        {
            val inflater = activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
            view = inflater.inflate(R.layout.states_row, null)
            viewHolder = StateAdapter.ViewHolder(view)
            view?.tag = viewHolder

        }
        else
        {
            view = convertView
            viewHolder = view.tag as StateAdapter.ViewHolder
        }

        val state = states[position]

        viewHolder.nameTxt?.text = state.name
        viewHolder.capitalTxt?.text = state.capital
        viewHolder.abbreviationTxt?.text = "(${state.abbreviation})"

        return view as View
    }

    override fun getItem(position: Int): Any {
        return states[position]
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun getCount(): Int {
        return states.size
    }
}