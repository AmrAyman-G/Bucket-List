//
//  StepsViewController.swift
//  Bucket List
//
//  Created by amr on 02/06/2022.
//

import UIKit
import CoreData
import ChameleonFramework

class StepsViewController: UIViewController {

    @IBOutlet weak var stepsShadowView: UIView!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var tabelView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var stepsArray = [Steps]()
    let  fC = Func()
    let alert2 = Alert()
    var selectedItem : List? {
        didSet{
            loadsteps()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.title = selectedItem?.name
        let nib = UINib(nibName: "StepCell", bundle: nil)
        tabelView.register(nib, forCellReuseIdentifier: "stepsCell")
        loadsteps()
        print(stepsArray.count)

        
    }
    
    

    @IBAction func addStep(_ sender: UIBarButtonItem) {
        fC.shadowViewFunc(state: false, stepsShadowView)
        let alertView = alert2.alert { [weak self]  text in
            guard let item = text else {fatalError()}
            guard let strongSelf = self else {fatalError()}
            let newInSteps = Steps(context: strongSelf.context)
            newInSteps.step = item
            newInSteps.time = Date.now
            newInSteps.list = strongSelf.selectedItem
            strongSelf.stepsArray.append(newInSteps)
            print(strongSelf.stepsArray.count)
            strongSelf.saveSteps()
            strongSelf.fC.shadowViewFunc(state: true, strongSelf.stepsShadowView)
        } cancelation: { [weak self] in
            guard let strongSelf = self else {fatalError()}
            strongSelf.fC.shadowViewFunc(state: true, strongSelf.stepsShadowView)
        }
        present(alertView, animated: true)
    }
    
}


extension StepsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stepsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepsCell", for: indexPath) as! StepCell
        cell.stepNumberLabel.text = "\(indexPath.row + 1)"
        cell.stepImage.tintColor = UIColor(hexString: (selectedItem?.color)!)
        cell.stepNameLabel.text = stepsArray[indexPath.row].step
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        tableView.beginUpdates()
        context.delete(stepsArray[indexPath.row])
        stepsArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        saveSteps()
        tableView.endUpdates()
        
    }
    
    
}
    



extension StepsViewController {
    
    func alert( titel:String, message:String?, perferredStayle: UIAlertController.Style , buttonTitel:String? , actionStayle: UIAlertAction.Style){
        var textField = UITextField()
        let alert = UIAlertController(title: titel, message: message, preferredStyle: perferredStayle)
        let action = UIAlertAction(title: buttonTitel, style: actionStayle) { action in
            let newStep = Steps(context: self.context)
            newStep.step = textField.text
            if #available(iOS 15, *) {
                newStep.time = Date.now
            } else {
                // Fallback on earlier versions
            }
            newStep.list = self.selectedItem
            self.stepsArray.append(newStep)
            self.saveSteps()
        }
        alert.addTextField { field in
            textField = field
            textField.placeholder = "Add what you wanna do"
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func saveSteps(){
        do{
            try context.save()
            loadsteps()
        }catch{
            
        }
    }
    
    func loadsteps(){
        
        let request = Steps.fetchRequest() as! NSFetchRequest
        let sort  = NSSortDescriptor(key: "time", ascending: true)
        let Predicate = NSPredicate(format: "list.name MATCHES %@", selectedItem!.name!)
        request.sortDescriptors = [sort]
        request.predicate = Predicate
        do{
            self.stepsArray =   try context.fetch(request)
            
            DispatchQueue.main.async {
                self.tabelView.reloadData()
            }
        }catch{
            print(error.localizedDescription)
        }
    }

}
