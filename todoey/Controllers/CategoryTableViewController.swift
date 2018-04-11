//
//  CategoryTableViewController.swift
//  todoey
//
//  Created by Nguyen Duc Tai on 3/24/18.
//  Copyright © 2018 Nguyen Duc Tai. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryTableViewController: SwipeTableViewCellViewController {
    
    var realm = try! Realm()
    var categories : Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        tableView.rowHeight = 70.0
        tableView.separatorStyle = .none
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let category = categories?[indexPath.row] {
        cell.textLabel?.text = category.name
        guard let color = UIColor(hexString: category.hexString) else {fatalError()}
        cell.backgroundColor = color
        cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
        }
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
        categories = realm.objects(Category.self)
        tableView.reloadData()
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
            new.hexString = UIColor.randomFlat.hexValue()
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
            destinationVC.selectedCategory = categories?[(indexPath.row)]
        }
    }
    override func updateDataInRealm(indexPath: IndexPath) {
        if let needDelete = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                self.realm.delete(needDelete)
                }
            }
            catch {
                print("delete error \(error)")
                }
            }
    }
    
}




