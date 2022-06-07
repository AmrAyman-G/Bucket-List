//
//  Alert.swift
//  Bucket List
//
//  Created by amr on 03/06/2022.
//

import UIKit

class Alert {
    func alert(complition:@escaping (_ text:String?)->Void) -> AlertViewController {
        let storyBoard = UIStoryboard(name: "AlertView", bundle: .main)
        let alertVC = storyBoard.instantiateViewController(withIdentifier: "AlertVC") as! AlertViewController
        alertVC.addTapped = complition
        return alertVC
    }
}

class SignIn{
    func Sign() -> RegistrationView {
        let storyBoard = UIStoryboard(name: "RegistrationView", bundle: nil)
        let alertVC = storyBoard.instantiateViewController(withIdentifier: "RegView") as! RegistrationView

        return alertVC
    }
}


