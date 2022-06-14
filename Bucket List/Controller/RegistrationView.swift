//
//  RegistrationView.swift
//  Bucket List
//
//  Created by amr on 07/06/2022.
//

import UIKit
import CoreData

class RegistrationView: UIViewController {
    
    
    @IBOutlet weak var navSignUPButton: UIButton!
    @IBOutlet weak var needAnAccountLabel: UILabel!
    @IBOutlet weak var SignInButton: UIButton!
    @IBOutlet weak var SignLabel: UILabel!
    @IBOutlet weak var cantSignInButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var signViewContiner: UIView!
    @IBOutlet weak var goSignUpButton: UIButton!
    @IBOutlet weak var goButton: UIButton!
    
    let contxt = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var passName : ((_ text:String?)-> Void)?
    var passEmail:((_ text:String?)-> Void)?
    var users = [Users]()
    var email: String?
    var pass: String?
    var name: String?
    
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
        fetchUserData()
        
    }
    
    @IBAction func SignUP(_ sender: UIButton) {
        signUpPage()
        
    }
    @IBAction func signInPage(_ sender: Any) {
        signInPage()
    }
    
    
    
    
    
    @IBAction func goSignIn(_ sender: UIButton) {
        
        print("goSignIn")
        checkForUser()
        if  email != nil , pass != nil {
            passName?(name)
            print(name ?? "no data")
            UserDefaults.standard.set(emailTextField.text, forKey: "CurrentUser")
            dismiss(animated: true, completion: nil)
        }else{
            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let alet = UIAlertController(title: "Error", message: "Wrong Username or Password!", preferredStyle: .alert)
            alet.addAction(action)
            present(alet, animated: true, completion: nil)
        }
        
        
    }
    
    
    @IBAction func goSignUP(_ sender: UIButton) {
        print("goSignUp")
        checkForUser()
        if email != nil && pass != nil{
            let action = UIAlertAction(title: "Sign In", style: .default) { [weak self] _  in
                self?.signInPage()
            }
            let alet = UIAlertController(title: "Worrning", message: "Your email already exists" , preferredStyle: .alert)
            alet.addAction(action)
            present(alet, animated: true, completion: nil)
            
        }else{
            let userSignUp = Users(context: contxt)
            userSignUp.email  = emailTextField.text
            userSignUp.password = passwordTextField.text
            userSignUp.name = nameTextField.text
            users.append(userSignUp)
            saveUser()
            signInPage()
           
            
        }
        
    }
    
   
    
}



extension RegistrationView {
    
    func saveUser(){
        do{
            
            try contxt.save()
            fetchUserData()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    func fetchUserData(){
        let request =  Users.fetchRequest() as! NSFetchRequest
        do {
            users = try contxt.fetch(request)
        }catch{
            print(error.localizedDescription)
        }
    }
    
}



extension RegistrationView{
    
    func signInPage(){
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
    
    
    func signUpPage(){
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
    
    
    func checkForUser(){
        for user in users {
            if user.email == emailTextField.text && user.password == passwordTextField.text{
                email = emailTextField.text
                pass = passwordTextField.text
                name = user.name
            }
        }
    }
    
    
}
