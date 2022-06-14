//
//  ProfileViewController.swift
//  Bucket List
//
//  Created by amr on 07/06/2022.
//

import UIKit
import SideMenu

class ProfileViewController: UIViewController {

    @IBOutlet weak var SignOutButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var profileStackView: UIStackView!
    @IBOutlet weak var navButtonStackView: UIStackView!
    @IBOutlet var profileView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    let sign = SignIn()
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = 50
        profileImage.layer .cornerCurve = .continuous
        
//        let bottomLine = CALayer()
//        bottomLine.frame = CGRect(x: profileStackView.frame.width - 190, y: navButtonStackView.frame.height - 40 , width: 190, height: 0.4)
//        bottomLine.backgroundColor = UIColor.gray.cgColor
//        profileView.layer.addSublayer(bottomLine)
//        profileImage.layer.borderWidth = 5
//        profileImage.layer.borderColor = UIColor(hexString:"#8236BF")?.cgColor
        // Do any additional setup after loading the view.
    }
   
    @IBAction func SignInUp(_ sender: UIButton) {
        let regView =  sign.Sign { [weak self] name in
            self?.userFullName.text = name
            self?.userFullName.isHidden = false
            self?.signInButton.isHidden = true
            self?.SignOutButton.isHidden = false
        }
        present(regView, animated: true)
//        present(sign.Sign(), animated: true)
    }
    
    
}


