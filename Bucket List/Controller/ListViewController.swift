//
//  ViewController.swift
//  Bucket List
//
//  Created by amr on 01/06/2022.
//

import UIKit
import CoreData
import ChameleonFramework

class ListViewController: UIViewController{
   
    
    
    
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var tabelView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let  fC = Func()
    let alert = Alert()
    let alertVC = AlertViewController()
    var listArray = [List]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowView.layer.isHidden = true
//        shadowView.layer.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3).cgColor
        let nib = UINib(nibName: "ListCell", bundle: nil)
        tabelView.register(nib, forCellReuseIdentifier: "listCell")
        load()
        // Do any additional setup after loading the view.
    }
    
  
    override func  viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: false)
//        shadowView.layer.isHidden = true
    }
    
    
    
    @IBAction func addList(_ sender: UIBarButtonItem) {
//        alert(titel: "Bucket List", message: nil, perferredStayle: .alert, buttonTitel: "Add", actionStayle: .default)
//        navigationController?.setNavigationBarHidden(true, animated: false)
//        shadowView.layer.isHidden = true
        let alertView = alert.alert()
        present(alertView, animated: true)
        
    }
}







extension ListViewController :  UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListCell
        if let name = listArray[indexPath.row].name ,let color = listArray[indexPath.row].color {
            cell.cellView.backgroundColor = UIColor(hexString: color)
            cell.itemLabel.textColor = ContrastColorOf(UIColor(hexString: color)!, returnFlat: true)
            cell.itemLabel.text = name
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "stepSegua", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sVC = segue.destination as! StepsViewController
        if let indexPath = tabelView.indexPathForSelectedRow {
            sVC.selectedItem = listArray[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Archive") { [weak self] (action, view, completionHandler) in
            guard let strongSelf = self else {return}
            strongSelf.atchiveHandeler()
            completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [action])
    }
  
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            tableView.beginUpdates()
            context.delete(listArray[indexPath.row])
            listArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            save()
            tableView.endUpdates()
    }
    
    
    private func atchiveHandeler() {
        print("Marked as favourite")
    }
}








extension ListViewController {
    
    func alert( titel:String, message:String?, perferredStayle: UIAlertController.Style , buttonTitel:String? , actionStayle: UIAlertAction.Style){
        var textField = UITextField()
        let alert = UIAlertController(title: titel, message: message, preferredStyle: perferredStayle)
        let action = UIAlertAction(title: buttonTitel, style: actionStayle) { action in
            let newInList = List(context: self.context)
            newInList.name = textField.text
            newInList.time = Date.now
            newInList.color = UIColor.randomFlat().hexValue()
            self.listArray.append(newInList)
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
        let request = List.fetchRequest() as! NSFetchRequest
        let sort  = NSSortDescriptor(key: "time", ascending: false)
        request.sortDescriptors = [sort]
        do{
            self.listArray =   try context.fetch(request)
            
            DispatchQueue.main.async {
                self.tabelView.reloadData()
            }
        }catch{
            
        }
    }
}


