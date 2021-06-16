//
//  ViewControllerB.swift
//  Symptom Tracker
//
//  Created by Chimera Van Rhyn on 15/06/2021.
//

import UIKit

class ViewControllerB: UIViewController {
    
    weak var delegate: ViewController!
    
    var labelName : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onSelectLabel(_ sender: UIButton) {
        
        labelName = sender.currentTitle!
        print(labelName)
    }
    

}
