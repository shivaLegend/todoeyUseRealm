//
//  ViewController.swift
//  todoey
//
//  Created by Nguyen Duc Tai on 2/23/18.
//  Copyright © 2018 Nguyen Duc Tai. All rights reserved.
//

import UIKit
import CoreData
class TodoListViewController: UITableViewController
{
    
    var itemArray = [Item]()
//    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedCategory : Category? {
        didSet {
//            loadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask))

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        return cell
    }
    //Mark: tableview
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
//    Mark: addPressed
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
//        let alert = UIAlertController.init(title: "Add", message: nil, preferredStyle: .alert)
//        var textF = UITextField()
//        alert.addTextField { (txt) in
//            txt.placeholder = "Fill in the blank"
//            textF = txt
//        }
//        let alertAction = UIAlertAction.init(title: "Add", style: .default) { (action) in
//            let new = Item(context: self.context)
//            new.title = textF.text!
//            new.done = false
//            new.yourParents = self.selectedCategory
//            self.itemArray.append(new)
//            self.saveData()
//
//        }
//        alert.addAction(alertAction)
//        present(alert, animated: true, completion: nil)
    }
    func saveData()
    {
//        do {
//            try context.save()
//        }
//        catch
//        {
//            print("fail cmn r \(error)")
//        }
//        tableView.reloadData()
    }
//    func loadData(with request : NSFetchRequest<Item> = Item.fetchRequest(),predicate : NSPredicate? = nil )
//    {
//        let predicateCategory = NSPredicate(format: "yourParents.name MATCHES %@", selectedCategory!.name!)
//        if let predicateNew = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateCategory,predicateNew])
//        }
//        else {
//            request.predicate = predicateCategory
//        }
//        do {
//
//            try itemArray = context.fetch(request)
//        }
//        catch
//        {
//            print("save data from context is \(error)")
//        }
//        tableView.reloadData()
    }
//}
//Mark : Extension
//extension TodoListViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        let predicate = NSPredicate.init(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.predicate = predicate
//        let sort = [NSSortDescriptor.init(key: "title", ascending: true)]
//        request.sortDescriptors = sort
//        loadData(with: request,predicate: predicate)
//    }
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0
//        {
//            loadData()
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//    }
//}

