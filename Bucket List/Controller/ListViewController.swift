//
//  ViewController.swift
//  Bucket List
//
//  Created by amr on 01/06/2022.
//

import UIKit
import CoreData
import ChameleonFramework
import SideMenu

class ListViewController: UIViewController{
   
    
    
    

    @IBOutlet weak var whoIsThatLabel: UILabel!
    @IBOutlet weak var whatList: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabelView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let  fC = Func()
    let alert = Alert()
    var listArray = [List]()
    var deletedItem = [Deleted]()
    var doneItem = [Done]()
    var collectionArray = ["Main","Done","Deleted"]
    var sData = Func.showData.list
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       firstToLoad()
   
    }
    
  
    
  
    
    
    @IBAction func addList(_ sender: UIBarButtonItem) {

        let alertView = alert.alert { [weak self]  text in
            guard let item = text else {fatalError()}
            guard let strongSelf = self else {fatalError()}
            let newInList = List(context: strongSelf.context)
            newInList.name = item
            newInList.time = Date.now
            newInList.color = UIColor.randomFlat().hexValue()
            strongSelf.listArray.append(newInList)
            strongSelf.save()
        }
        present(alertView, animated: true)
        
    }
    @IBAction func slideLeft(_ sender: UIBarButtonItem) {
      let  profileViewController = ProfileViewController()
        let menu = SideMenuNavigationController(rootViewController: profileViewController)
        menu.leftSide = true
       
        present(menu, animated: true, completion: nil)
    }
}







extension ListViewController :  UITableViewDelegate, UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sData {
        case .list:
            return listArray.count
        case .delete:
        
            return deletedItem.count
        case .done:
            return doneItem.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListCell
        
        switch sData {
        case .list:
            if let name = listArray[indexPath.row].name ,let color = listArray[indexPath.row].color {
                cell.imageLabel.tintColor = UIColor(hexString: color)
                cell.itemCountLabel.text = "\(indexPath.row + 1)"
    //           cell.itemLabel.textColor = ContrastColorOf(UIColor(hexString: color)!, returnFlat: true)
                cell.itemLabel.text = name
            }
            return cell
        case .delete:
            if let name = deletedItem[indexPath.row].name ,let color = deletedItem[indexPath.row].color {
                cell.imageLabel.tintColor = UIColor(hexString: color)
                cell.itemCountLabel.text = "\(indexPath.row + 1)"
    //           cell.itemLabel.textColor = ContrastColorOf(UIColor(hexString: color)!, returnFlat: true)
                cell.itemLabel.text = name
            }
            return cell
        case .done:
            if let name = doneItem[indexPath.row].name ,let color = doneItem[indexPath.row].color {
                cell.imageLabel.tintColor = UIColor(hexString: color)
                cell.itemCountLabel.text = "\(indexPath.row + 1)"
    //           cell.itemLabel.textColor = ContrastColorOf(UIColor(hexString: color)!, returnFlat: true)
                cell.itemLabel.text = name
            }
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "stepSegua", sender: self)
            tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sVC = segue.destination as! StepsViewController
        
        if let indexPath = tabelView.indexPathForSelectedRow {
            print(indexPath)
            sVC.selectedItem = listArray[indexPath.row]
        }else{
            print("not working the index is empty")
        }
    }
    
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Done") { [weak self] (action, view, completionHandler) in
            guard let strongSelf = self else {return}
            strongSelf.itemDone(indexPath)
            completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [action])
    }
  
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        let deleted = Deleted(context: context.self)
        deleted.name = listArray[indexPath.row].name
        deleted.color = listArray[indexPath.row].color
        deleted.time = Date.now
        deletedItem.append(deleted)
        context.delete(listArray[indexPath.row])
        listArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        save()
        tableView.endUpdates()
    }
    
    
    func itemDone(_ index:IndexPath) {
        tabelView.beginUpdates()
        let done = Done(context: context.self)
        done.name = listArray[index.row].name
        done.color = listArray[index.row].color
        done.time = Date.now
        doneItem.append(done)
        context.delete(listArray[index.row])
        listArray.remove(at: index.row)
        tabelView.deleteRows(at: [index], with: .fade)
        save()
        tabelView.endUpdates()
        
    }
}






extension ListViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.collectionLabel.text = collectionArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            tabelViewAnimation(.list,"Your List")
            tabelView.allowsSelection = true
            
        }else  if indexPath.row == 1 {
            tabelViewAnimation(.done,"Done")
            tabelView.allowsSelection = false
        }else{
            tabelViewAnimation(.delete,"Deleted")
            tabelView.allowsSelection = false
            
        }
        
    }
    
    
}




extension ListViewController {
    
    
    func tabelViewAnimation(_ dataNav:Func.showData,_ text:String){
        UIView.animate(withDuration: 1.0, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
            if self.tabelView?.alpha == 1.0 {
                self.tabelView?.alpha = 0.0
                self.whatList.alpha = 0.0
                self.whatList.text = text
                self.sData = dataNav
                self.tabelView?.alpha = 1.0
                self.whatList.alpha = 1.0
                DispatchQueue.main.async {
                    self.tabelView.reloadData()
                }
            }
        }, completion: { (finished:Bool) -> Void in
        })
    }
    
    func firstToLoad(){
        
        
        let nib = UINib(nibName: "ListCell", bundle: nil)
        tabelView.register(nib, forCellReuseIdentifier: "listCell")
        let collectionNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(collectionNib, forCellWithReuseIdentifier: "CollectionViewCell")
//        (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .portrait
        load()
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    func save(){
        do{
            try context.save()
            load()
        }catch{
            
        }
    }
    
    func load(){
        
        let listRequest = List.fetchRequest() as! NSFetchRequest
        let doneRequest = Done.fetchRequest() as! NSFetchRequest
        let deleteRequest = Deleted.fetchRequest() as! NSFetchRequest
        
        let sort  = NSSortDescriptor(key: "time", ascending: false)
        listRequest.sortDescriptors = [sort]
        do{
            self.listArray =   try context.fetch(listRequest)
            self.doneItem =   try context.fetch(doneRequest)
            self.deletedItem = try context.fetch(deleteRequest)
            
            DispatchQueue.main.async {
                self.tabelView.reloadData()
            }
        }catch{
            
        }
    }
}





