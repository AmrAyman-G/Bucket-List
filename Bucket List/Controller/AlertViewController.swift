//
//  AlertViewController.swift
//  Bucket List
//
//  Created by amr on 03/06/2022.
//

import UIKit




class AlertViewController: UIViewController {
    
    
    
   

    @IBOutlet weak var addButtionOutlet: UIButton!
    @IBOutlet weak var cancelButtionOutlet: UIButton!
    @IBOutlet var MainView: UIView!
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var AlertView: UIView!
    let fC = Func()
    var text:String?
    var addTapped : ((_ text:String?)-> Void)?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        firstToRun()
        
    }
    
    //MARK: - ALertView Buttons -
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func addButton(_ sender: UIButton) {
        
        // Const For The Text Field
        
        let currentText = itemTextField.text ?? ""
        let set = CharacterSet(charactersIn: currentText)
//        let freedSpaceString = currentText.filter {!$0.isWhitespace}
        let freedSpaceString = currentText.trimmingCharacters(in: .whitespaces)

        // Valedation Statment
        if itemTextField.text == "" || CharacterSet.whitespaces.isSuperset(of: set){
            itemTextField.text = ""
            fC.textFieldValidation(textField: itemTextField, placeholder: "Please Enter Item Name!", color: UIColor.red.cgColor)
            
        }else if currentText.count < 3{
            
            itemTextField.text = ""
            fC.textFieldValidation(textField: itemTextField, placeholder: "Min Number of Charecter is 3", color: UIColor.red.cgColor)
            
        }else{
            print("Pass point 1")
            addTapped?(freedSpaceString)
            print("Pass point 2")
            dismiss(animated: true, completion: nil)
            print("Pass point 3")
        }
        
        
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
           return updatedText.count <= 20
    }
    
    //MARK: - Text Field Change ditector Function -
    
    @objc func textFieldDidChange(_ textField: UITextField) {
   
        fC.textFieldValidation(textField: itemTextField, color: UIColor(red: 60/255, green: 212/255, blue: 248/255, alpha: 1).cgColor)
    }
    
   
}



//MARK: - Extension  For Other Function -

extension AlertViewController{
    
    
    func firstToRun(){
        
        
        //Text Field Valedation
        itemTextField.addTarget(self, action: #selector(AlertViewController.textFieldDidChange(_:)), for:
                                        .editingChanged)
        
        fC.textFieldValidation(textField: itemTextField, color: UIColor(red: 60/255, green: 212/255, blue: 248/255, alpha: 1).cgColor)
       
        
        //AlertView UI Style
        AlertView.layer.cornerCurve = .circular
        AlertView.layer.cornerRadius = 20
        AlertView.layer.shadowColor = UIColor.cyan.cgColor
        AlertView.layer.shadowOpacity = 0.3
        
      
    
    }
    
    
    func invalidTextField(_ value: String) -> String?
        {
           
           
            return nil
        }
    
}
