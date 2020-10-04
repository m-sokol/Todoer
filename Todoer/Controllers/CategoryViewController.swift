//
//  CategoryViewController.swift
//  Todoer
//
//  Created by Marta Sokołowska on 12/08/2020.
//  Copyright © 2020 Marta Sokołowska. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    var categories : Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        categoryCell.textLabel?.text = categories?[indexPath.row].name ?? "No Categorires Added yet"
        
        return categoryCell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var categoryTextField = UITextField()
        
        let categoryAlert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let categoryAction = UIAlertAction(title: "Add Category", style: .default) { (categoryAction) in
            
            let newCategory = Category()
            newCategory.name = categoryTextField.text!

            self.saveCategory(category: newCategory)
        }
        
        categoryAlert.addTextField { (categoryAlertTextField) in
            categoryTextField = categoryAlertTextField
            categoryAlertTextField.placeholder = "Create new category"
        }
        
        categoryAlert.addAction(categoryAction)
        
        present(categoryAlert, animated: true, completion: nil)
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveCategory(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context in category \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategory() {
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
}
