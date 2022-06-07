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
   
    
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabelView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let  fC = Func()
    let alert = Alert()
    var listArray = [List]()
    var collectionArray = ["Main","Done"]
    
    
    
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
        listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListCell
        if let name = listArray[indexPath.row].name ,let color = listArray[indexPath.row].color {
            cell.imageLabel.tintColor = UIColor(hexString: color)
            cell.itemCountLabel.text = "\(indexPath.row + 1)"
//           cell.itemLabel.textColor = ContrastColorOf(UIColor(hexString: color)!, returnFlat: true)
            cell.itemLabel.text = name
            
          
            
        }
        return cell
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
            strongSelf.itemDone()
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
    
    
    private func itemDone() {
        print("Marked as favourite")
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
     let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: cell.ViewNav.frame.height - 5, width: cell.ViewNav.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        cell.ViewNav.layer.addSublayer(bottomLine)
    }
    
    
}




extension ListViewController {
    
    func firstToLoad(){
        
        
        let nib = UINib(nibName: "ListCell", bundle: nil)
        tabelView.register(nib, forCellReuseIdentifier: "listCell")
        let collectionNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(collectionNib, forCellWithReuseIdentifier: "CollectionViewCell")
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





