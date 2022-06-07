//
//  ProfileViewController.swift
//  Bucket List
//
//  Created by amr on 07/06/2022.
//

import UIKit
import SideMenu

class ProfileViewController: UIViewController {

    @IBOutlet var profileView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    let sign = SignIn()
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = 50
        profileImage.layer .cornerCurve = .continuous
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: profileImage.frame.width - 85, y: profileImage.frame.height + 220, width: 190, height: 0.4)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        profileView.layer.addSublayer(bottomLine)
//        profileImage.layer.borderWidth = 5
//        profileImage.layer.borderColor = UIColor(hexString:"#8236BF")?.cgColor
        // Do any additional setup after loading the view.
    }

    @IBAction func SignInUp(_ sender: UIButton) {
        present(sign.Sign(), animated: true)
    }
    
}

extension ProfileViewController: SideMenuNavigationControllerDelegate {

    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }

    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }

    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }

    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
}
