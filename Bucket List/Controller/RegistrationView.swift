//
//  RegistrationView.swift
//  Bucket List
//
//  Created by amr on 07/06/2022.
//

import UIKit

class RegistrationView: UIViewController {
    
    
    @IBOutlet weak var navSignUPButton: UIButton!
    @IBOutlet weak var needAnAccountLabel: UILabel!
    @IBOutlet weak var SignInButton: UIButton!
    @IBOutlet weak var SignLabel: UILabel!
    @IBOutlet weak var cantSignInButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var signViewContiner: UIView!
    
    @IBOutlet weak var goSignUpButton: UIButton!
    @IBOutlet weak var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goButton.layer.cornerRadius = 30
        goButton.layer.cornerCurve = .continuous
        goSignUpButton.layer.cornerRadius = 30
        goSignUpButton.layer.cornerCurve = .continuous
        signViewContiner.layer.cornerRadius = 20
        signViewContiner.layer.cornerCurve = .continuous
        backImage.layer.cornerRadius = 20
        backImage.layer.cornerCurve = .continuous
    }
    
    
    @IBAction func submitButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SignUP(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
            
            self.nameTextField.isHidden = false
            self.cantSignInButton.isHidden = true
            self.SignLabel.text = "Sign Up"
            self.SignInButton.isHidden = false
            self.goButton.isHidden = true
            self.goSignUpButton.isHidden = false
            self.needAnAccountLabel.isHidden = true
            self.navSignUPButton.isHidden = true
            self.navSignUPButton.alpha = 0.0
            self.needAnAccountLabel.alpha = 0.0
        }, completion: { (finished:Bool) -> Void in
        })
        
    }
    @IBAction func signInPage(_ sender: Any) {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
            self.navSignUPButton.alpha = 1
            self.needAnAccountLabel.alpha = 1
            self.nameTextField.isHidden = true
            self.cantSignInButton.isHidden = false
            self.SignLabel.text = "Sign In"
            self.SignInButton.isHidden = true
            self.goButton.isHidden = false
            self.goSignUpButton.isHidden = true
            self.needAnAccountLabel.isHidden = false
            self.navSignUPButton.isHidden = false
        }, completion: { (finished:Bool) -> Void in
        })
    }
    
    @IBAction func goSignUP(_ sender: UIButton) {
        
    }
    
    
    
    
    
    
}

