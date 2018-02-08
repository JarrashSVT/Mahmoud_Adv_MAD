//
//  FirstViewController.swift
//  CU Courses
//
//  Created by Mahmoud Aljarrash on 1/29/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.


//

import UIKit

class FirstViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var coursesPicker: UIPickerView!
    @IBOutlet weak var selectedCourseLabel: UILabel!
    
    let departmentComponent = 0
    let coursesComponent = 1
    
    var departmentCourses = [String: [String]]()
    var departments = [String]()
    var courses = [String]()
    var courseUrl : String = "CSCI%205809"
    var courseTitle : String = ""
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if component == departmentComponent
        {
            return departments.count
        }
        else
        {
            return courses.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if component == departmentComponent
        {
            return departments[row]
        }
        else
        {
            //print("Before: ",courses[row])
            
            let course = courses[row].split(separator: ";")
            let courseTitleTemp = String(course[0])

            return courseTitleTemp
            
        }
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if component == departmentComponent
        {
            let selectDepartment = departments[row]
            courses = departmentCourses[selectDepartment]!
            
            coursesPicker.reloadComponent(coursesComponent)
            coursesPicker.selectRow(0, inComponent: coursesComponent, animated: true)
        }
            let selectedDepartment = pickerView.selectedRow(inComponent: departmentComponent)
            let selectedCourse = pickerView.selectedRow(inComponent: coursesComponent)
        
            let course = courses[selectedCourse].split(separator: ";")
        
            courseTitle = String(course[0])
            courseUrl = String(course[1])
            print("courseTitle", courseTitle)
            print("courseUrl", courseUrl)

            selectedCourseLabel.text = "You've selected \(courseTitle) from \(departments[selectedDepartment]) department"
        
        
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // URL for our plist
        if let pathURL = Bundle.main.url(forResource: "departmentCourses",withExtension:"plist"){
            //creates a property list decoder object
            let plistdecoder = PropertyListDecoder()
            do
            {
                let data = try Data(contentsOf: pathURL)
                //decodes the property list
                departmentCourses = try plistdecoder.decode([String: [String]].self, from: data)
                departments = Array(departmentCourses.keys)
                courses = departmentCourses[departments[0]]! as [String]
                //print(courses)
            }
            catch
            {
                // handle error
                print(error)
            }
        }
    }

    @IBAction func courseUrlBtnClicked(_ sender: UIButton)
    {
        print("accessing https://catalog.colorado.edu/search/?P=" + courseUrl)
        if let url = URL(string: "https://catalog.colorado.edu/search/?P=" + courseUrl)
        {
            UIApplication.shared.open(url, options: [:])
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



// <div>Icons made by <a href="http://www.freepik.com" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
