//
//  imagePikerView.swift
//  Bucket List
//
//  Created by amr on 12/06/2022.
//

import UIKit
import CoreData


class imagePikerView: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    var contxt = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var userImage = [Users]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewContainer.layer.cornerRadius = 20
        backGroundImage.layer.cornerRadius = 20
        profileImage.layer.cornerRadius = 20
        fetchUserData()
//        print(email ?? "no data")
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func addImage(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.profileImage.image = image
        let imageData = profileImage.image!.pngData()
        let newImage = Users(context: contxt)
        
//        for user in userImage {
//            if user.email == email {
//                newImage.image = imageData
//                userImage.append(newImage)
//                saveUser()
//            }
//        }
        
        picker.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }
    
    
    func checkForUser(){
        
    }

    
}



extension imagePikerView {
    
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
             userImage = try contxt.fetch(request)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    func imageView(complition:@escaping (_ text:String?)->Void) -> RegistrationView {
        let storyBoard = UIStoryboard(name: "RegistrationView", bundle: nil)
        let alertVC = storyBoard.instantiateViewController(withIdentifier: "RegView") as! RegistrationView
        alertVC.passEmail = complition

        return alertVC
    }
    
}
