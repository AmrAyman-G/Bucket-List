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
        print("pass point 0")
        alertVC.addTapped = complition
        return alertVC
    }
}


