//
//  ViewController.swift
//  Sociaphobia 2
//
//  Created by Evgeniy Uskov on 30.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var sexPickerView: UIView!
    @IBOutlet weak var sexPicker: UIPickerView!
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var selectSexLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    var selectedSex: String = ""
    
    var sexes: [Int: String] = [
        0: "",
        1: "Мужской",
        2: "Женский",
    ]
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sexPickerView.layer.cornerRadius = 10
        continueButton.layer.cornerRadius = 10
        continueButton.backgroundColor = UIHelper.getViewBackgroundColor()
        continueButton.setBackgroundImage(UIImage(named: "button-back"), for: .normal)
        
        headerLabel.tintColor = UIHelper.getTextForegroundColor()
        selectSexLabel.tintColor = UIHelper.getTextForegroundColor()
        view.backgroundColor = UIHelper.getViewBackgroundColor()
        sexPicker.delegate = self
        sexPicker.dataSource = self
        if let sex = defaults.string(forKey: "voiceSex") {
            selectedSex = sex
            performSegue(withIdentifier: "goToPhrases", sender: nil)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sexes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let sex = sexes[row] {
            selectedSex = sex
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        if let sex = sexes[row] {
            return NSAttributedString(string: sex, attributes: [NSAttributedString.Key.foregroundColor: UIColor.hexValue(hex: "2b2b2b")])
        }
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        defaults.set(selectedSex, forKey: "voiceSex")
        
        let destinationViewController = segue.destination as! ChooseSexViewController
        destinationViewController.sex = selectedSex
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "goToPhrases" {
            if validateFields() {
                return true
            }
        }
        return false
    }
    
    func validateFields() -> Bool {
        return selectedSex != ""
    }
    
    func getStylizedText(quote: String) -> NSAttributedString{
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.blue,
        ]
        return NSAttributedString(string: quote, attributes: attributes)
    }
    
}

