//
//  ViewController.swift
//  Symptom Tracker
//
//  Created by Chimera Van Rhyn on 03/06/2021.
//

import UIKit
import Foundation


var justOnce: Bool = true

let dateFormatter = DateFormatter()

let viewControllerB = ViewControllerB()
let viewControllerC = ViewControllerC()

// PROFILE SETTINGS
var userMail: String = ""
var dataConsent: Bool = false
class ProfileSettings {
    var dataConsent: Bool = false
    var userMail: String = ""
}

// LOGGING
var currentTime : Date? = nil
var logTimeString : String = ""
var labelName = viewControllerB.labelName
var logRating = viewControllerC.logRating
var logDescription = viewControllerC.logDescription

struct LogItem {
    var time : String
    var label : String     // color + labelName?
    var rating : Int
    var description : String?

    init?(description: String, time : String, label : String, rating: Int){
        self.time = time
        self.label = label
        self.rating = rating

        if description == "" {
            return nil
        }else{
            self.description = description
        }
    }
}

// NOTIFICATION SETTINGS
var notifEnabled : Bool = true
var notificationTime : Date? = nil
var notifTimeString : String = ""
var notificationFrequency : Bool = true
var notifDay : String = ""

class NotifSettings {
    var frequency : Bool = true
    var time : String = ""
    var day : String?
    
    init(frequency : Bool, time : String, day : String?) {
        self.frequency = frequency
        self.time = time
        self.day = day
    }
}

class ViewController: UIViewController {
    

    
    let userLicenseAgreement  = """
                                    This Long Covid Symptom Tracker app will be handling personal data that you input as part of the logging process.
                                    You may export or delete you data at any time.
                                    For further details on the use of your data, read our Privacy Policy.
                                    
                                    You can also choose to opt-in to your data contributing to research on Long Covid.
                                    For further details on this research, see our website.

                                    Accepting the Privacy Policy is the minimum requirement to use this app.
                                    Do you accept the Privacy Policy and agree to your data contributing to the study detailed above?
                                    """
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if justOnce {
            displayLicenceAgreement(message: self.userLicenseAgreement)
            
            justOnce = false
        }
        if let label = chooseDay {
            label.delegate = self
            label.delegate = self
        }
    }
    
    func displayLicenceAgreement(message:String){
        let alert = UIAlertController(title: "Privacy Policy", message: message, preferredStyle: .alert)

        let declineAction = UIAlertAction(title: "Accept Privacy Policy only" , style: .default){ (action) -> Void in
            dataConsent = false
        }

        let acceptAction = UIAlertAction(title: "Accept both", style: .default) { (action) -> Void in
            dataConsent = true
        }

        alert.addAction(declineAction)
        alert.addAction(acceptAction)
        self.present(alert, animated: true, completion: nil)
    }

    // GEN SETTINGS
    
    func deleteAlert(){
        let alert = UIAlertController(title: "Are you sure?", message: "Deleting your data will restart your logging journey and delete your profile information", preferredStyle: .alert)

        let declineAction = UIAlertAction(title: "Delete Data" , style: .destructive){ (action) -> Void in
            // Account data would be deleted, app refreshed
        }
        let acceptAction = UIAlertAction(title: "Cancel", style: .default) { (action) -> Void in
            // Return
        }

        alert.addAction(declineAction)
        alert.addAction(acceptAction)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func onDelete(_ sender: UIButton) {
        deleteAlert()
    }

    func emailAlert(mail: String){
        // Additional checks would ideally be done on to verify the email?
        if mail == ""{
            let alert = UIAlertController(title: "Go to Manage Profile", message: "An email address is required to send your exported data", preferredStyle: .alert)
            let declineAction = UIAlertAction(title: "Ok" , style: .default){ (action) -> Void in}
            alert.addAction(declineAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    func exportAlert(mail: String){
        if mail != ""{
            let alert = UIAlertController(title: "Export succesful", message: "Your exported data will arrive in your inbox soon", preferredStyle: .alert)
            let declineAction = UIAlertAction(title: "Ok" , style: .default){ (action) -> Void in}
            alert.addAction(declineAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func onExport(_ sender: UIButton) {
        emailAlert(mail: userMail)
        exportAlert(mail: userMail)
    }
    
    func formatDates(inputDate: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        
        let outputDate = dateFormatter.string(from: inputDate)
        print(outputDate)
        return outputDate
    }
    
    // PROFILE SETTINGS
    
    func emailSubmit(mail: String){
        if mail != ""{
            let alert = UIAlertController(title: "Email Accepted", message: "Please check your inbox to validate this email address", preferredStyle: .alert)
            let declineAction = UIAlertAction(title: "Ok" , style: .default){ (action) -> Void in}
            alert.addAction(declineAction)
            self.present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Please enter a valid email", message: "", preferredStyle: .alert)
            let declineAction = UIAlertAction(title: "Ok" , style: .default){ (action) -> Void in}
            alert.addAction(declineAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBOutlet weak var emailOutput: UITextField!
    @IBAction func submitEmail(_ sender: UIButton) {
        // Additional checks would ideally be done to verify the email
        userMail = emailOutput.text!
        emailSubmit(mail: userMail)
        
    }
    
    @IBAction func onRevise(_ sender: UIButton) {
        displayLicenceAgreement(message: self.userLicenseAgreement)
    }
    
    // LOGGING INSTANCES
    @IBAction func unwind( _ seg: UIStoryboardSegue) {}
    
    @IBOutlet weak var symptomDate: UIDatePicker!
    @IBAction func logTypeOne(_ sender: UIButton) {
        currentTime = symptomDate.date
        logTimeString = formatDates(inputDate: currentTime!)
        
        labelName = sender.currentTitle!
        print(labelName)
    }
    
    // NOTIFICATION SETTINGS
    
    @IBOutlet weak var notifEnable: UISwitch!
    @IBOutlet weak var frequencyControl: UISegmentedControl!
    @IBOutlet weak var notifTime: UIDatePicker!
    @IBOutlet weak var chooseDay: UIPickerView!
    let weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    
    @IBAction func onEnabledChange(_ sender: UISwitch) {
        notifEnabled = !notifEnabled
    }
    
    @IBAction func onFrequencyChange(_ sender: UISegmentedControl) {
        notificationFrequency = !notificationFrequency
    }
    
    @IBAction func onSaveNotifs(_ sender: UIButton) {
        // if enabled:
        //        read frequency, time
        //        if weekly:
        //              read pickerview
        
//        print(notifEnabled)
        
//        print(notificationFrequency)
        
        notificationTime = notifTime.date
        notifTimeString = formatDates(inputDate: notificationTime!)
        let formattedString = String( notifTimeString.suffix(5))
//        print(formattedString)
        
//        print(notifDay)
        
        var currentNotifSettings = NotifSettings(frequency: notificationFrequency, time: formattedString, day: notifDay)
        print(currentNotifSettings.frequency)
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weekdays.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return weekdays[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        notifDay = weekdays[row]
        
    }
}





