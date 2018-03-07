//
//  AddEventViewController.swift
//  CU Events v1.0
//
//  Created by Mahmoud Aljarrash on 2/23/18.
//  Copyright © 2018 Mahmoud Aljarrash. All rights reserved.
//

import UIKit
import GooglePlaces

class AddEventViewController: UIViewController, UITextFieldDelegate,UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var eventTitleTxt: UITextField!
//    @IBOutlet weak var addressTxt: UITextField!
    @IBOutlet weak var startDateTxt: UITextField!
    @IBOutlet weak var endDateTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var campusTxt: UITextField!
    @IBOutlet weak var eventImg: UIImageView!
    @IBOutlet weak var addressTxt: UITextView!
    
    let datePicker = UIDatePicker()
    let campusPicker = UIPickerView()
    var toolBar = UIToolbar()
    var activeTextField: UITextField!
    var defaultImgChanged = false
    
    
    
    let campuses = ["CU Boulder", "CU Denver", "CU Colorado Springs"]
    
    // Declare variables to hold address form values.
    var street_number: String = ""
    var route: String = ""
    var neighborhood: String = ""
    var locality: String = ""
    var administrative_area_level_1: String = ""
    var country: String = ""
    var postal_code: String = ""
    var postal_code_suffix: String = ""

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
        
        //checking if the user picked an image to upload
        if !defaultImgChanged
        {
            // the user did not pick an image so assign the default image
            eventImg.image = UIImage(named: "cuboulder-600")
        }
        
        
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
//        AlertController.showAlert(inViewController: self, title: "New Event Added", message: "\(title) has been successfully added")
        self.performSegue(withIdentifier: "fromAddEventVCToEventCVCSegue", sender: nil)

    }
    
    
    private func createEventInDatabase(values: [String: Any])
    {
        print("@createEventInDatabase() Add these values to the DB ", values)
        
        DatabaseService.shared.eventsReference.childByAutoId().setValue(values)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        addressTxt.addTarget(self, action: #selector(addressTxtTapped) , for: UIControlEvents.touchDown)
        
        campusTxt.inputView = campusPicker
        campusPicker.delegate = self
        
        // round the corners of description txt view
        descriptionTxt.layer.cornerRadius = 10
        addressTxt.layer.cornerRadius = 10
        
        // assigning delegats
        startDateTxt.delegate = self
        endDateTxt.delegate = self
        addressTxt.delegate = self
        
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

    func addressTxtTapped()
    {
        print("addressTxtTapped")
        
        // source: https://developers.google.com/places/ios-api/address-form-tutorial
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self as GMSAutocompleteViewControllerDelegate
        
        // Set a filter to return only addresses.
        let addressFilter = GMSAutocompleteFilter()
        addressFilter.type = .address
        autocompleteController.autocompleteFilter = addressFilter
        
        present(autocompleteController, animated: true, completion: nil)
        
    }
    
    func fillAddress()
    {
        addressTxt.text = street_number + " " + route
        addressTxt.text = addressTxt.text! + " ," + locality + " ," + administrative_area_level_1
        
        if postal_code_suffix != "" {
            addressTxt.text = addressTxt.text! + " ," + postal_code + "-" + postal_code_suffix
        } else {
            addressTxt.text = addressTxt.text! + " ," + postal_code
        }
        
        addressTxt.text = addressTxt.text! + " ," + country
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        activeTextField = textField
//        print("** activeTextField is ", activeTextField)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.tag == 3
        {
            addressTxtTapped()
        }
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
            defaultImgChanged = true
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("image picker cancelled by user")
        
        dismiss(animated: true, completion: nil)
    }


}

extension AddEventViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//        // Print place info to the console.
//        print("Place name: \(place.name)")
//        print("Place address: \(place.formattedAddress)")
//        print("Place attributions: \(place.attributions)")
        
        // Get the address components.
        if let addressLines = place.addressComponents {
            // Populate all of the address fields we can find.
            for field in addressLines {
                switch field.type {
                case kGMSPlaceTypeStreetNumber:
                    street_number = field.name
                case kGMSPlaceTypeRoute:
                    route = field.name
                case kGMSPlaceTypeNeighborhood:
                    neighborhood = field.name
                case kGMSPlaceTypeLocality:
                    locality = field.name
                case kGMSPlaceTypeAdministrativeAreaLevel1:
                    administrative_area_level_1 = field.name
                case kGMSPlaceTypeCountry:
                    country = field.name
                case kGMSPlaceTypePostalCode:
                    postal_code = field.name
                case kGMSPlaceTypePostalCodeSuffix:
                    postal_code_suffix = field.name
                // Print the items we aren't using.
                default:
                    print("Type: \(field.type), Name: \(field.name)")
                }
            }
        }
        
        // Call custom function to populate the address form.
        fillAddress()
        
        // Close the autocomplete widget.
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Show the network activity indicator.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    // Hide the network activity indicator.
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
