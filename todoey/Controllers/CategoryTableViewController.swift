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
    var categories : Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
    }

   
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }

    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No category"
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
    
}
    




