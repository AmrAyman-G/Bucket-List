//
//  ProfileViewController.swift
//  Bucket List
//
//  Created by amr on 07/06/2022.
//

import UIKit
import SideMenu

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("HEllo")
        // Do any additional setup after loading the view.
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
