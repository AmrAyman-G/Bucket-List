//
//  AlertViewController.swift
//  Bucket List
//
//  Created by amr on 03/06/2022.
//

import UIKit
import ChameleonFramework
import UIView_Shake



class AlertViewController: UIViewController {
    
    
    
    
    
    
    @IBOutlet weak var popUpBack: UIImageView!
    @IBOutlet weak var addButtionOutlet: UIButton!
    @IBOutlet weak var cancelButtionOutlet: UIButton!
    @IBOutlet var MainView: UIView!
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var AlertView: UIView!
    let fC = Func()
    var text:String?
    var addTapped : ((_ text:String?)-> Void)?
    var cancelTapped : (()-> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstToRun()
        
    }
    
    //MARK: - ALertView Buttons -
    
    @IBAction func cancelButton(_ sender: UIButton) {
        cancelTapped?()
        dismiss(animated: true)
    }
    
    
    @IBAction func addButton(_ sender: UIButton) {

        action()
     
    }
    
    
    
    
}


//MARK: -  UITextFieldDelegate Extension -

extension AlertViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // make sure the result is under 16 characters
        return updatedText.count <= 80
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //delegate method
        action()
       
        
       return true
    }
    
    
    
    //MARK: - Text Field Change ditector Function -
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        fC.textFieldValidation(textField: itemTextField, color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1))
    }
    
    
}



//MARK: - Extension  For Other Function -

extension AlertViewController{
    
    
    func firstToRun(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        
        
        
        //Text Field Valedation
        itemTextField.addTarget(self, action: #selector(AlertViewController.textFieldDidChange(_:)), for:
                                        .editingChanged)
        fC.textFieldValidation(textField: itemTextField, color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1))
        addButtionOutlet.layer.cornerRadius =  15
        addButtionOutlet.layer.shadowOpacity = 1
        addButtionOutlet.layer.shadowColor = UIColor.flatTeal().cgColor
        addButtionOutlet.layer.shadowOffset.height = 1
        addButtionOutlet.layer.shadowOffset.width = 1
        cancelButtionOutlet.layer.cornerRadius = 15
        cancelButtionOutlet.layer.shadowOpacity = 0.7
        cancelButtionOutlet.layer.shadowColor = UIColor.flatRed().cgColor
        cancelButtionOutlet.layer.shadowOffset.height = 1
        cancelButtionOutlet.layer.shadowOffset.width = 1
        itemTextField.becomeFirstResponder()
        hideKeyboardWhenTappedAround()
        //AlertView UI Style
        AlertView.layer.cornerCurve = .continuous
        AlertView.layer.cornerRadius = 20
        popUpBack.layer.cornerCurve = .continuous
        popUpBack.layer.cornerRadius = 20
        itemTextField.layer.shadowColor = UIColor.flatBlack().cgColor
        itemTextField.layer.shadowOpacity = 0.5
        //        AlertView.layer.shadowColor = UIColor.purple.cgColor
        //        AlertView.layer.shadowOpacity = 1
        //        AlertView.layer.shadowOffset.width = 5
        //        AlertView.layer.shadowOffset.height = 2
        //        AlertView.layer.
        
        
           
            
        
           
        
        
    }
    
    
    func placeholderColor(_ value: String)
    {
        itemTextField.attributedPlaceholder = NSAttributedString(
            string: value,
            attributes:
                [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        
    }
    
    
    func action(){
//        itemTextField.becomeFirstResponder()
        let currentText = itemTextField.text ?? ""
        let set = CharacterSet(charactersIn: currentText)
        //        let freedSpaceString = currentText.filter {!$0.isWhitespace}
        let freedSpaceString = currentText.trimmingCharacters(in: .whitespaces)
        
        // Valedation Statment
        if itemTextField.text == "" || CharacterSet.whitespaces.isSuperset(of: set){
            itemTextField.text = ""
            fC.textFieldValidation(textField: itemTextField, placeholder: "Please Enter Item Name!", color: UIColor.red)
            self.AlertView.shake()
            
        }else if currentText.count < 3{
            
            itemTextField.text = ""
            fC.textFieldValidation(textField: itemTextField, placeholder: "Minmum 3 character", color: UIColor.red)
            self.AlertView.shake()
        }else{
           
            addTapped?(freedSpaceString)
            itemTextField.resignFirstResponder()
            dismiss(animated: true, completion: nil)
           
        }
    }
    
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -=  AlertView.frame.height / 2
            }
//        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
}
