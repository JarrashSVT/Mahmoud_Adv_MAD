package com.jarrash.mahmoud.myhomelab.Fragments

import android.app.Fragment
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import android.widget.ListView
import com.jarrash.mahmoud.myhomelab.R




/**
 * A simple [Fragment] subclass.
 * Activities that contain this fragment must implement the
 * [MasterFragment.OnFragmentInteractionListener] interface
 * to handle interaction events.
 * Use the [MasterFragment.newInstance] factory method to
 * create an instance of this fragment.
 */
class MasterFragment : Fragment() {

    val types = arrayListOf("Servers", "Desktops","Laptops")

    override fun onCreateView(inflater: LayoutInflater?, container: ViewGroup?, savedInstanceState: Bundle?): View {
        return LayoutInflater.from(container?.context).inflate(R.layout.fragment_master, container, false)
    }

//    override fun onCreateView(inflater: LayoutInflater?, container: ViewGroup?, savedInstanceState: Bundle?): View {
//        return inflater!!.inflate(R.layout.fragment_master, container, false)
//    }

    override fun onStart() {
        super.onStart()
        val view = getView()

        if (view != null)
        {
            val masterList = view.findViewById<ListView>(R.id.masterList)
            val typesAdapter = ArrayAdapter(activity, android.R.layout.simple_list_item_1, types)

            masterList.adapter = typesAdapter

            masterList.setOnItemClickListener { parent, view, position, id ->
                Log.i("@masterListClicked", types[position])
                loadFragment(DetailsFragment(), types[position])
            }
        }
    }

    private fun loadFragment(fragment: DetailsFragment, type :String)
    {
        Log.i("@LoadFragment", "Loading...")
        val ft = fragmentManager.beginTransaction()

        Log.i("@LoadFragment", "DetailsFragment")
        fragment.setDevicesType(type)
        ft.replace(R.id.detailsFragment, fragment)

        ft.commit()
    }
}
