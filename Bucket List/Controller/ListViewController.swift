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
import Lottie

class ListViewController: UIViewController{
    
    
    
    
    
    
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var list: UIView!
    @IBOutlet weak var listViewLabel: UILabel!
    @IBOutlet weak var delete: UIView!
    @IBOutlet weak var deleteViewLabel: UILabel!
    @IBOutlet weak var done: UIView!
    @IBOutlet weak var doneViewLabel: UILabel!
    @IBOutlet weak var whoIsThatLabel: UILabel!
    @IBOutlet weak var whatList: UILabel!
    @IBOutlet weak var tabelView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let  fC = Func()
    let alert = Alert()
    var listArray = [List]()
    var deletedItem = [Deleted]()
    var doneItem = [Done]()
    var currentUser : Users?  {
        didSet{
            UserDefaults.standard.string(forKey: "CurrentUser")
        }
    }
    var collectionArray = ["🏠 Main","✅ Done","🗑️ Trash"]
    var sData = Func.showData.list
    var animationView : AnimationView?
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        animationView = .init(name: "Green-done")
//        animationView?.frame = view.bounds
//
//        animationView?.animationSpeed = 0.8
//        animationView?.play(fromFrame: frame.start.rawValue, toFrame: frame.end.rawValue, loopMode: .playOnce, completion: { [weak self] _ in
//            self?.animationView?.isHidden = true
//        })
//
        
    
        
        firstToLoad()
        
    }
    
    
    @objc func fireTimer() {
        animationView?.stop()
        animationView?.isHidden = true
    }
    
    
    @IBAction func addList(_ sender: UIBarButtonItem) {
        
        fC.shadowViewFunc(state: false, shadowView)
        let alertView = alert.alert { [weak self]  text in
            guard let item = text else {fatalError()}
            guard let strongSelf = self else {fatalError()}
            let newInList = List(context: strongSelf.context)
            newInList.name = item
            newInList.time = Date.now
            let co = UIColor.init(randomFlatColorExcludingColorsIn: [UIColor.flatBlack(),UIColor.flatBlue(), UIColor.blue, UIColor.black, UIColor.brown,UIColor.flatBrown()])
            newInList.color = co.hexValue()
            newInList.user = strongSelf.currentUser
            strongSelf.listArray.append(newInList)
            strongSelf.save()
            strongSelf.fC.shadowViewFunc(state: true, strongSelf.shadowView)
        } cancelation: { [weak self] in
            guard let strongSelf = self else {fatalError()}
            strongSelf.fC.shadowViewFunc(state: true, strongSelf.shadowView)
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
                cell.imageLabel.image = UIImage(systemName: "seal")
                //           cell.itemLabel.textColor = ContrastColorOf(UIColor(hexString: color)!, returnFlat: true)
                cell.itemLabel.text = name
            }
            return cell
        case .delete:
            if let name = deletedItem[indexPath.row].name  {
                cell.imageLabel.tintColor = UIColor.red
                cell.itemCountLabel.text = ""
                cell.imageLabel.image = UIImage(systemName: "xmark.seal")
                //           cell.itemLabel.textColor = ContrastColorOf(UIColor(hexString: color)!, returnFlat: true)
                cell.itemLabel.text = name
            }
            return cell
        case .done:
            if let name = doneItem[indexPath.row].name {
                cell.imageLabel.tintColor = UIColor.green
                cell.imageLabel.image = UIImage(systemName: "checkmark.seal")
                cell.itemCountLabel.text = ""
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
        if sData == .list {
            let doneAction = UIContextualAction(style: .normal,
                                                title: "Done") { [weak self] (action, view, completionHandler) in
                
                guard let strongSelf = self else {return}
                strongSelf.animation("Green-done", with: 1)
                strongSelf.itemDone(indexPath)
                completionHandler(true)
            }
            let deleteAction = UIContextualAction(style: .normal,
                                                  title: "Delete") { [weak self] (action, view, completionHandler) in
                guard let strongSelf = self else {return}
                strongSelf.animation("deletes", with: 1)
                strongSelf.itemDelete(indexPath)
                completionHandler(true)
            }
            doneAction.backgroundColor = .flatGreen()
            deleteAction.backgroundColor = .flatRed()
            let swipeAction = UISwipeActionsConfiguration(actions: [doneAction,deleteAction])
            swipeAction.performsFirstActionWithFullSwipe = false
            return swipeAction
        }else if  sData == .delete{
            
            let deleteAction = UIContextualAction(style: .destructive,
                                                  title: "Delete") { [weak self] (action, view, completionHandler) in
                guard let strongSelf = self else {return}
                strongSelf.animation("destroy", with: 2, 130)
                strongSelf.itemDelete(indexPath)
                completionHandler(true)
            }
            
            let putBackAction = UIContextualAction(style: .destructive,
                                                   title: "Put Back") { [weak self] (action, view, completionHandler) in
                guard let strongSelf = self else {return}
                strongSelf.animation("restored2", with: 0.8)
                strongSelf.putBack(indexPath)
                completionHandler(true)
            }
            deleteAction.backgroundColor = .flatRed()
            putBackAction.backgroundColor = .flatBlue()
            let swipeAction = UISwipeActionsConfiguration(actions: [putBackAction,deleteAction])
            swipeAction.performsFirstActionWithFullSwipe = false
            return swipeAction
        }else{
            
            let deleteAction = UIContextualAction(style: .destructive,
                                                  title: "Delete") { [weak self] (action, view, completionHandler) in
                guard let strongSelf = self else {return}
                strongSelf.animation("deletes", with: 1)
                strongSelf.itemDelete(indexPath)
                completionHandler(true)
            }
            
            let unChackAction = UIContextualAction(style: .destructive,
                                                   title: "Un Chack") { [weak self] (action, view, completionHandler) in
                guard let strongSelf = self else {return}
                strongSelf.animation("uncheck", with: 1.5, 100)
                strongSelf.notDone(indexPath)
                completionHandler(true)
            }
            deleteAction.backgroundColor = .flatRed()
            unChackAction.backgroundColor = .flatBlue()
            let swipeAction = UISwipeActionsConfiguration(actions: [unChackAction,deleteAction])
            swipeAction.performsFirstActionWithFullSwipe = false
            return swipeAction
            
            
        }
        
        
    }
    
   
    func itemDelete(_ index:IndexPath) {
        
        if sData == .list {
            tabelView.beginUpdates()
            let deleted = Deleted(context: context.self)
            deleted.name = listArray[index.row].name
            deleted.color = listArray[index.row].color
            deleted.time = Date.now
            deletedItem.append(deleted)
            context.delete(listArray[index.row])
            listArray.remove(at: index.row)
            
            self.tabelView.deleteRows(at: [index], with: .fade)
            self.save()
            tabelView.endUpdates()
            
        }else if sData == .delete{
            context.delete(deletedItem[index.row])
            deletedItem.remove(at: index.row)
            DispatchQueue.main.async { [weak self] in
                self?.tabelView.deleteRows(at: [index], with: .fade)
            }
            
            save()
            
            
        }else{
            tabelView.beginUpdates()
            let deleted = Deleted(context: context.self)
            deleted.name = doneItem[index.row].name
            deleted.color = doneItem[index.row].color
            deleted.time = Date.now
            deletedItem.append(deleted)
            context.delete(doneItem[index.row])
            doneItem.remove(at: index.row)
            self.tabelView.deleteRows(at: [index], with: .fade)
            self.save()
            tabelView.endUpdates()
            
        }
        
        
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
    
    func putBack(_ index:IndexPath) {
        
        let restord = List(context: context.self)
        restord.name = deletedItem[index.row].name
        restord.color = deletedItem[index.row].color
        restord.time = Date.now
        listArray.append(restord)
        context.delete(deletedItem[index.row])
        deletedItem.remove(at: index.row)
        DispatchQueue.main.async { [weak self] in
            self?.tabelView.deleteRows(at: [index], with: .fade)
        }
       save()
        
    }
    
    func notDone(_ index:IndexPath) {
        
        let restord = List(context: context.self)
        restord.name = doneItem[index.row].name
        restord.color = doneItem[index.row].color
        restord.time = Date.now
        listArray.append(restord)
        context.delete(doneItem[index.row])
        doneItem.remove(at: index.row)
        DispatchQueue.main.async { [weak self] in
            self?.tabelView.deleteRows(at: [index], with: .fade)
        }
       save()
        
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
        animationView?.isHidden = true
        list.setOnClickListener {
            self.addBarButton.isEnabled = true
            self.tabelViewAnimation(.list,"Your List")
            self.tabelView.allowsSelection = true
        }
        delete.setOnClickListener {
            self.addBarButton.isEnabled = false
            self.tabelViewAnimation(.delete,"Trash")
            self.tabelView.allowsSelection = false
        }
        done.setOnClickListener {
            self.addBarButton.isEnabled = false
            self.tabelViewAnimation(.done,"Done")
            self.tabelView.allowsSelection = false
        }
        
        fC.ViewUi(view: list)
        fC.ViewUi(view: delete)
        fC.ViewUi(view: done)
        listViewLabel.text = collectionArray[0]
        doneViewLabel.text = collectionArray[1]
        deleteViewLabel.text = collectionArray[2]
        let nib = UINib(nibName: "ListCell", bundle: nil)
        tabelView.register(nib, forCellReuseIdentifier: "listCell")
       
        load()
                        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
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



class ClickListener: UITapGestureRecognizer {
    var onClick : (() -> Void)? = nil
}




extension UIView {
    
    func setOnClickListener(action :@escaping () -> Void){
        let tapRecogniser = ClickListener(target: self, action: #selector(onViewClicked(sender:)))
        tapRecogniser.onClick = action
        self.addGestureRecognizer(tapRecogniser)
    }
    
    @objc func onViewClicked(sender: ClickListener) {
        if let onClick = sender.onClick {
            onClick()
        }
    }
    
}


extension ListViewController{
    
    func animation(_ value:String ,with speed:CGFloat,_ endFrame: CGFloat = 35){
        animationView = .init(name: value)
        animationView?.frame = view.bounds
        animationView?.animationSpeed = speed
//        animationView?.loopMode = .playOnce
        animationView?.play(fromFrame: 0, toFrame: endFrame, loopMode: .playOnce, completion: { [weak self] _ in
            self?.animationView?.isHidden = true
        })
        if let aView = animationView {
            view.addSubview(aView)
        }
    }
    
}


extension UISwipeActionsConfiguration{
    
   
}
