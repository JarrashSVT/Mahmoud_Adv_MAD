package com.jarrash.mahmoud.myhomelab.Fragments

import android.app.AlertDialog
import android.app.Fragment
import android.content.Context
import android.content.DialogInterface
import android.os.Bundle
import android.util.Log
import android.view.*
import android.widget.*
import com.jarrash.mahmoud.myhomelab.Adapters.DevicesAdapter
import com.jarrash.mahmoud.myhomelab.Model.Device
import com.jarrash.mahmoud.myhomelab.Model.Lab
import com.jarrash.mahmoud.myhomelab.R



/**
 * A simple [Fragment] subclass.
 * Activities that contain this fragment must implement the
 * [DetailsFragment.OnFragmentInteractionListener] interface
 * to handle interaction events.
 * Use the [DetailsFragment.newInstance] factory method to
 * create an instance of this fragment.
 */
class DetailsFragment : Fragment() {

    private var devicesType: String = ""
    private var devices =  arrayListOf<Device>()
    private lateinit var masterList: ListView //class property
    private lateinit var devicesAdapter: BaseAdapter //class property

    override fun onCreateView(inflater: LayoutInflater?, container: ViewGroup?, savedInstanceState: Bundle?): View
    {
        if (savedInstanceState != null)
        {
            devicesType = savedInstanceState.getString("devicesType")
        }
        return LayoutInflater.from(container?.context).inflate(R.layout.fragment_details, container, false)
    }

    override fun onSaveInstanceState(outState: Bundle?) {
        outState?.putString("devicesType", devicesType)
    }

    override fun onStart() {
        super.onStart()
        val view = getView()

        if (view != null)
        {
             masterList = view.findViewById<ListView>(R.id.detailsList)
             var devicesTypeTxt = view.findViewById<TextView>(R.id.devicesTypeTxt)
             devicesTypeTxt.text = devicesType

            when(devicesType)
            {
                "Servers" -> this.devices = Lab.servers
                "Laptops" -> this.devices = Lab.laptops
                "Desktops" -> this.devices = Lab.desktops
            }
            devicesAdapter = DevicesAdapter(activity, this.devices)
            masterList.adapter = devicesAdapter


            val addBtn = view.findViewById<Button>(R.id.addBtn)

            addBtn.setOnClickListener(){
                Log.i("@addBtnClicked", "Click")
                addDevice()
            }

            registerForContextMenu(masterList)
        }
    }



    fun setDevicesType(type: String)
    {
        this.devicesType = type
    }

    fun addDevice()
    {

        Log.i("@addDevice", "New device will be added :)")
        val dialogBuilder = AlertDialog.Builder(this@DetailsFragment.activity)
        val inflater = activity.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
        val dialogView = inflater.inflate(R.layout.add_device_dialog, null)
        dialogBuilder.setView(dialogView)

        val newHostName = dialogView.findViewById<View>(R.id.newHostNameTxt) as EditText
        val newIp = dialogView.findViewById<View>(R.id.newIpTxt) as EditText
        val newOs = dialogView.findViewById<Spinner>(R.id.osSpinner) as Spinner

        dialogBuilder.setTitle("New Device")

        dialogBuilder.setPositiveButton("Save", DialogInterface.OnClickListener { dialog, whichButton ->

            when(devicesType) //switch statement
            {
                "Servers" -> {
                    Lab.servers.add(Device(newOs.selectedItem.toString(), newIp.text.toString(), newHostName.text.toString()))
                    DevicesAdapter(activity, Lab.servers).notifyDataSetChanged()
                }
                "Desktops" -> {
                    Lab.desktops.add(Device(newOs.selectedItem.toString(), newIp.text.toString(), newHostName.text.toString()))
                    DevicesAdapter(activity, Lab.desktops).notifyDataSetChanged()
                }
                "Laptops" -> {
                    Lab.laptops.add(Device(newOs.selectedItem.toString(), newIp.text.toString(), newHostName.text.toString()))
                    DevicesAdapter(activity, Lab.laptops).notifyDataSetChanged()
                }
            }

        })
        dialogBuilder.setNegativeButton("Cancel", DialogInterface.OnClickListener { dialog, whichButton ->

        })
        val b = dialogBuilder.create()
        b.show()

    }

    override fun onContextItemSelected(item: MenuItem?): Boolean {
        val itemId = item?.itemId

        if(itemId == 1) // yes
        {
            val info = item.menuInfo as AdapterView.AdapterContextMenuInfo
            // for some reasons we have to reset the listview adapter !!
            // else the listview won't refresh after the deletion
            masterList.adapter = DevicesAdapter(activity, this.devices)

            when(devicesType) //switch statement
            {
                "Servers" -> {
                    Lab.servers.removeAt(info.position)
                    DevicesAdapter(activity, Lab.servers).notifyDataSetChanged()
                }
                "Desktops" -> {
                    Lab.desktops.removeAt(info.position)
                    DevicesAdapter(activity, Lab.desktops).notifyDataSetChanged()
                }
                "Laptops" -> {
                    Lab.laptops.removeAt(info.position)
                    DevicesAdapter(activity, Lab.laptops).notifyDataSetChanged()
                }
            }
        }
        return true
    }

    override fun onCreateContextMenu(menu: ContextMenu?, v: View?, menuInfo: ContextMenu.ContextMenuInfo?) {
        super.onCreateContextMenu(menu, v, menuInfo)

        val adapterContextMenuInfo = menuInfo as AdapterView.AdapterContextMenuInfo
        val hostName = this.devices[menuInfo.position].hostName
        //set the menu title
        menu?.setHeaderTitle("Delete " + hostName)
        //add the choices to the menu
        menu?.add(1, 1, 1, "Yes")
        menu?.add(2, 2, 2, "No")
    }

}
