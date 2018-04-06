//
//  ViewController.swift
//  todoey
//
//  Created by Nguyen Duc Tai on 2/23/18.
//  Copyright © 2018 Nguyen Duc Tai. All rights reserved.
//

import UIKit
import RealmSwift
class TodoListViewController: UITableViewController
{
    
    var toDoItem : Results<Item>?
    let realm = try! Realm()
    var selectedCategory : Category? {
        didSet {
            loadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask))

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItem?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        if let item = toDoItem?[indexPath.row] {
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        }
        else {
            cell.textLabel?.text = "No add item"
        }
        return cell
    }
    //Mark: tableview
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = toDoItem?[indexPath.row] {
            do {
                try realm.write {
                item.done = !item.done
            }
            }catch {
                print("Selected row is error , \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
//    Mark: addPressed
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController.init(title: "Add", message: nil, preferredStyle: .alert)
        var textF = UITextField()
        alert.addTextField { (txt) in
            txt.placeholder = "Fill in the blank"
            textF = txt
        }
        let alertAction = UIAlertAction.init(title: "Add", style: .default) { (action) in
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                    let new = Item()
                    new.title = textF.text!
                    new.date = Date()
                    currentCategory.items.append(new)
                    }
                } catch {
                    print("error saving item \(error)")
                }
            }
            self.tableView.reloadData()

        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func loadData( )
    {
        toDoItem = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
}
//Mark : Extension
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        toDoItem = toDoItem?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "date", ascending: true)
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0
        {
            loadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

