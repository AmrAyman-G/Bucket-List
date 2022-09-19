//
//  Func.swift
//  Bucket List
//
//  Created by amr on 02/06/2022.
//

import UIKit

struct Func{
    
    enum showData:Int{
        case list
        case delete
        case done
    }
    
    func getHourForData(_ date:Date?) -> String{
        guard let inputDate = date else{
            
            return "error"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: inputDate)
        
    }
    
    func textFieldValidation(textField:UITextField,placeholder: String = "  Add new item" , color:UIColor){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 5, width: textField.frame.width, height: 1.0)
        bottomLine.backgroundColor = color.cgColor
        textField.layer.addSublayer(bottomLine)
        placeholderColor( placeholder, textField, color)
    }
    
    func placeholderColor(_ value: String,_ textField:UITextField ,_ color: UIColor = UIColor.green)
    {
        textField.attributedPlaceholder = NSAttributedString(
            string: value,
            attributes:
                [NSAttributedString.Key.foregroundColor: color])
    }
    
    func ViewUnderLine(_ view:UIView){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: view.frame.height - 5, width: view.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        view.layer.addSublayer(bottomLine)
    }
    
    func ViewUi(view:UIView){
        view.layer.cornerRadius = 20
        view.layer.cornerCurve = .continuous
    }
    
    func shadowViewFunc(state:Bool,_ view:UIView){
        UIView.animate(withDuration: 0.5, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
            view.layer.backgroundColor = UIColor.black.cgColor
            view.layer.opacity = 0.7
            view.isHidden = state
        }, completion: { (finished:Bool) -> Void in
        })
    }
    
    
    
}



extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
