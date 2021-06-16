//
//  ViewControllerC.swift
//  Symptom Tracker
//
//  Created by Chimera Van Rhyn on 15/06/2021.
//

import UIKit


class ViewControllerC: UIViewController {
    
    var currentTime : Date? = nil
    var logTimeString : String = ""
    var labelName = viewControllerB.labelName
    var logRating : Int = 0
    var logDescription : String = ""

    struct LogItem {
        var time : String
        var label : String      // color + labelName?
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
    
    weak var delegate: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var rating1: UIButton!
    @IBOutlet weak var rating2: UIButton!
    @IBOutlet weak var rating3: UIButton!
    @IBOutlet weak var rating4: UIButton!
    @IBOutlet weak var rating5: UIButton!
    
    @IBAction func onChooseRating(_ sender: UIButton) {
        // all very inneficient X-X
        rating1.setTitleColor(UIColor(red: 0.84, green: 0.32, blue: 0.15, alpha: 1.00), for: .normal)
        rating2.setTitleColor(UIColor(red: 0.84, green: 0.32, blue: 0.15, alpha: 1.00), for: .normal)
        rating3.setTitleColor(UIColor(red: 0.84, green: 0.32, blue: 0.15, alpha: 1.00), for: .normal)
        rating4.setTitleColor(UIColor(red: 0.84, green: 0.32, blue: 0.15, alpha: 1.00), for: .normal)
        rating5.setTitleColor(UIColor(red: 0.84, green: 0.32, blue: 0.15, alpha: 1.00), for: .normal)

        sender.setTitleColor(.black, for: .normal)
        
        logRating = Int(sender.currentTitle!)!
        print(sender.currentTitle!)
    }

    @IBOutlet weak var readDescription: UITextField!
    @IBAction func backToA(_ sender: UIButton) {
        logDescription = readDescription.text!
//        print(readDescription.text!)
        
        var logInstanceOne = LogItem(description: logDescription, time: logTimeString, label: labelName, rating: logRating)
        
        performSegue(withIdentifier: "unwindToA", sender: self)
    }
}
