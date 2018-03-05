//
//  AddEventViewController.swift
//  CU Events v1.0
//
//  Created by Mahmoud Aljarrash on 2/23/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var eventTitleTxt: UITextField!
    @IBOutlet weak var addressTxt: UITextField!
    @IBOutlet weak var startDateTxt: UITextField!
    @IBOutlet weak var endDateTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var campusTxt: UITextField!
    @IBOutlet weak var eventImg: UIImageView!
    
    let datePicker = UIDatePicker()
    let campusPicker = UIPickerView()
    var toolBar = UIToolbar()
    var activeTextField: UITextField!
    
    let campuses = ["CU Boulder", "CU Denver", "CU Colorado Springs"]
    
    func createDatePicker(forField field: UITextField)
    {
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(datePicker:)), for: .valueChanged)
    }
    
    func createToolBar()
    {
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        
        let todayButton = UIBarButtonItem(title: "Now", style: .plain, target: self, action: #selector(todayBtnTapped(sender:)))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBtnTapped(sender:)))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width/3, height: 40))
        label.text = "Choose a Date"
        let labelButton = UIBarButtonItem(customView:label)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolBar.setItems([todayButton,flexibleSpace,labelButton,flexibleSpace,doneButton], animated: true)
    }
    
    @objc func datePickerValueChanged(datePicker: UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        activeTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func todayBtnTapped(sender: UIBarButtonItem)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        datePicker.date = Date()
        activeTextField.text = dateFormatter.string(from: datePicker.date)

    }

    @objc func doneBtnTapped(sender: UIBarButtonItem)
    {
        activeTextField.resignFirstResponder()
    }
    
    @IBAction func onSubmitBtnTapped(_ sender: UIButton)
    {
        guard let title = eventTitleTxt.text, title != "",
            let address = addressTxt.text, address != "",
            let description = descriptionTxt.text, description != "",
            let campus = campusTxt.text, campus != "",
            let startDate = startDateTxt.text, startDate != "",
            let endDate = endDateTxt.text, endDate != ""
            else
            {
                AlertController.showAlert(inViewController: self, title: "Missing Info", message: "Please fill out all fields")
                return
            }
        
        // generate random image name
        let uploadedImageName = NSUUID().uuidString
        
        // uploading the image
        let storegeRef = DatabaseService.shared.storageReference.child("\(uploadedImageName).png")
        
        // get the binary format of the selected image
        if let imgToUpload = UIImagePNGRepresentation(eventImg.image!)
        {
            //upload the selected image to the firebase storage
            storegeRef.putData(imgToUpload, metadata: nil) { (metadata, error) in
                
                guard error == nil else
                {
                    print(error!.localizedDescription)
                    return
                }
                //image upload successfully
                // get the uploaded image url
                if let eventImgUrl = metadata?.downloadURL()?.absoluteString
                {
                    // construct the value dict
                    let parameter = ["title" : title,
                                     "address" : address,
                                     "description": description,
                                     "campus": campus,
                                     "startDate": startDate,
                                     "endDate": endDate,
                                     "image": eventImgUrl]
                    
                    self.createEventInDatabase(values: parameter)
                }

            }
        }

        //fromAddEventVCToEventTVCSegue

        self.performSegue(withIdentifier: "fromAddEventVCToEventTVCSegue", sender: nil)

    }
    
    
    private func createEventInDatabase(values: [String: Any])
    {
        DatabaseService.shared.eventsReference.childByAutoId().setValue(values)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        campusTxt.inputView = campusPicker
        campusPicker.delegate = self
        // round the corners of description txt view
        descriptionTxt.layer.cornerRadius = 10
        
        // assigning delegats
        startDateTxt.delegate = self
        endDateTxt.delegate = self
        
        // create date pickers & toolbar
        createDatePicker(forField: startDateTxt)
        createDatePicker(forField: endDateTxt)
        createToolBar()
        
        // assigning date pickers & toolbars
        startDateTxt.inputView = datePicker
        startDateTxt.inputAccessoryView = toolBar
        
        endDateTxt.inputView = datePicker
        endDateTxt.inputAccessoryView = toolBar
        
        // uploading image view setup
        eventImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectEventImage)))
        eventImg.isUserInteractionEnabled = true
    }

    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        activeTextField = textField
//        print("** activeTextField is ", activeTextField)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapGestureRecognized(_ sender: Any)
    {
        eventTitleTxt.resignFirstResponder()
        addressTxt.resignFirstResponder()
        startDateTxt.resignFirstResponder()
        endDateTxt.resignFirstResponder()
        descriptionTxt.resignFirstResponder()
        campusTxt.resignFirstResponder()
    }
    
    // Picker datasource & delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return campuses.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return campuses[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        campusTxt.text = campuses[row]
    }

    // Image Picker Functions
    
    @objc func selectEventImage()
    {
        print("selecting an Event Image ...")
        let imgPicker = UIImagePickerController()
        
        imgPicker.delegate = self
        imgPicker.allowsEditing = true
        present(imgPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("image picked")
//        print(info)
        
        var selectedImgFromPicker: UIImage?
        
        if let editedImg = info["UIImagePickerControllerEditedImage"] as? UIImage
        {
            selectedImgFromPicker = editedImg
            print("editedImg selected")
        }
        else if let originalImg = info["UIImagePickerControllerOriginalImage"] as? UIImage
        {
            selectedImgFromPicker = originalImg
            print("originalImg selected")

        }
        
        if let selectedImg = selectedImgFromPicker
        {
            eventImg.image = selectedImg
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("image picker cancelled by user")
        
        dismiss(animated: true, completion: nil)
    }


}
