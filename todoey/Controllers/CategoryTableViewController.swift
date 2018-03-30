//
//  CategoryTableViewController.swift
//  todoey
//
//  Created by Nguyen Duc Tai on 3/24/18.
//  Copyright © 2018 Nguyen Duc Tai. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    var realm = try! Realm()
    var categories = [Category]()
//    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask))
        
//        loadData()
        
    }

   
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    // MARK: save and load data
    func saveData(new: Category) {
        do {
            try realm.write {
                realm.add(new)
            }
        }
        catch {
            print("save data is error \(error)")
        }
        
        tableView.reloadData()
    }
    func loadData() {
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//        do {
//
//            try categories = context.fetch(request)
//
//        }
//        catch {
//            print("fetch data is error \(error)")
//        }
//        tableView.reloadData()
    }
 
    // MARK: -addButton
    
    @IBAction func addBtn(_ sender: Any) {
        let alert = UIAlertController.init(title: "Add", message: nil, preferredStyle: .alert)
        var textF = UITextField()
        alert.addTextField { (txt) in
            txt.placeholder = "Fill in the blank"
            textF = txt
        }
        let new = Category()
        let alertAction = UIAlertAction.init(title: "Add", style: .default) { (action) in
            new.name = textF.text!
            self.categories.append(new)
            self.saveData(new: new)
            
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
        }
    // MARK: Segue
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[(indexPath.row)]
        }
    }
    
}
    




