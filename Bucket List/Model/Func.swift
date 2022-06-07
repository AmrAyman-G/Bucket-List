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
    
    func textFieldValidation(textField:UITextField,placeholder: String = "  Add new item" , color:CGColor){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 5, width: textField.frame.width, height: 1.0)
        bottomLine.backgroundColor = color
        textField.layer.addSublayer(bottomLine)
        textField.placeholder = placeholder
    }
    
    func ViewUnderLine(_ view:UIView){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: view.frame.height - 5, width: view.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        view.layer.addSublayer(bottomLine)
    }
}
