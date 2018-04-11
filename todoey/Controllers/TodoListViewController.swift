//
//  ViewController.swift
//  todoey
//
//  Created by Nguyen Duc Tai on 2/23/18.
//  Copyright © 2018 Nguyen Duc Tai. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework
//import SwipeCellKit
class TodoListViewController: SwipeTableViewCellViewController
{
    @IBOutlet weak var searchBar: UISearchBar!
    
    var toDoItem : Results<Item>?
    let realm = try! Realm()
    var selectedCategory : Category? {
        didSet {
            loadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        tableView.separatorStyle = .none
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let colorID = selectedCategory?.hexString else {fatalError()}
        guard let color = UIColor(hexString: colorID) else {fatalError()}
        guard let nav = navigationController?.navigationBar else {fatalError()}
        nav.barTintColor = UIColor(hexString: colorID)
        nav.tintColor = ContrastColorOf(color, returnFlat: true)
        nav.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : ContrastColorOf(color, returnFlat: true)]
        searchBar.barTintColor = color
    }
    override func viewWillDisappear(_ animated: Bool) {
        guard let nav = navigationController?.navigationBar else {fatalError()}
        nav.tintColor = ContrastColorOf(UIColor(hexString: "00FDFF")!, returnFlat: true)
        nav.barTintColor = UIColor(hexString: "00FDFF")
        nav.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : ContrastColorOf(UIColor(hexString: "00FDFF")!, returnFlat: true)]
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItem?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let item = toDoItem?[indexPath.row] {
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
            if let color = FlatSkyBlue().darken(byPercentage: CGFloat(CGFloat(indexPath.row)/CGFloat((toDoItem?.count)!))) {
        cell.backgroundColor = color
        cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            }
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
    override func updateDataInRealm(indexPath: IndexPath) {
        if let needDelete = self.toDoItem?[indexPath.row] {
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

