//
//  Alert.swift
//  Bucket List
//
//  Created by amr on 03/06/2022.
//

import UIKit

class Alert {
    func alert(complition:@escaping (_ text:String?)->Void, cancelation:@escaping ()-> Void ) -> AlertViewController {
        let storyBoard = UIStoryboard(name: "AlertView", bundle: .main)
        let alertVC = storyBoard.instantiateViewController(withIdentifier: "AlertVC") as! AlertViewController
        alertVC.addTapped = complition
        alertVC.cancelTapped = cancelation
        return alertVC
    }
    
//    func switsher(complition:@escaping ()->Void) -> Bool{
//        let storyBoard = UIStoryboard(name: "AlertView", bundle: .main)
//        let alertVC = storyBoard.instantiateViewController(withIdentifier: "AlertVC") as! AlertViewController
//        
//        
//        return false
//    }
    
}

class SignIn{
    func Sign(complition:@escaping (_ text:String?)->Void) -> RegistrationView {
        let storyBoard = UIStoryboard(name: "RegistrationView", bundle: nil)
        let alertVC = storyBoard.instantiateViewController(withIdentifier: "RegView") as! RegistrationView
        alertVC.passName = complition

        return alertVC
    }
}


