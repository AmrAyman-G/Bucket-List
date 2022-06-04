//
//  StepsViewController.swift
//  Bucket List
//
//  Created by amr on 02/06/2022.
//

import UIKit
import CoreData

class StepsViewController: UIViewController {

    @IBOutlet weak var tabelView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var stepsArray = [Steps]()
    var selectedItem : List? {
        didSet{
            load()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "StepCell", bundle: nil)
        tabelView.register(nib, forCellReuseIdentifier: "stepsCell")

        
    }
    

    @IBAction func addStep(_ sender: UIBarButtonItem) {
        
    }
    
}


extension StepsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stepsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepsCell", for: indexPath) as! StepCell
        
        return cell
    }
    
    
    
}
    



extension StepsViewController {
    
    func alert( titel:String, message:String?, perferredStayle: UIAlertController.Style , buttonTitel:String? , actionStayle: UIAlertAction.Style){
        var textField = UITextField()
        let alert = UIAlertController(title: titel, message: message, preferredStyle: perferredStayle)
        let action = UIAlertAction(title: buttonTitel, style: actionStayle) { action in
            let newStep = Steps(context: self.context)
            newStep.step = textField.text
            newStep.time = Date.now
            self.stepsArray.append(newStep)
            self.save()
        }
        alert.addTextField { field in
            textField = field
            textField.placeholder = "Add what you wanna do"
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func save(){
        do{
            try context.save()
            load()
        }catch{
            
        }
    }
    
    func load(){
        let request = Steps.fetchRequest() as! NSFetchRequest
        let sort  = NSSortDescriptor(key: "time", ascending: false)
        let predacit = NSPredicate(format: "list.name MATCHES %@", selectedItem!.name!)
        request.sortDescriptors = [sort]
        request.predicate = predacit
        do{
            self.stepsArray =   try context.fetch(request)
            
            DispatchQueue.main.async {
                self.tabelView.reloadData()
            }
        }catch{
            
        }
    }

}
