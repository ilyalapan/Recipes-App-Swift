//
//  IngredientsDetailTableViewController.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 16/09/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit

class IngredientsDetailTableViewController: UITableViewController {

    var ingredients : [String] = []
    
    var searchObject : RecipeSearch? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ingredients.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)

        // Configure the cell...
        let ingredient = ingredients[indexPath.row]
        cell.textLabel?.text = ingredient
        if (searchObject?.ingridients.contains(ingredient))!{
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ingredient = ingredients[indexPath.row]
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                searchObject?.ingridients = (searchObject?.ingridients.filter{$0 != ingredient})!
            } else {
                cell.accessoryType = .checkmark
                searchObject?.ingridients.append(ingredient)
            }
        }    
    }

    
}
