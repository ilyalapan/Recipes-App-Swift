//
//  IngridientsChoiceTableViewController.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 16/09/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit

class IngridientsChoiceTableViewController: UITableViewController {

    var selectedIngridients: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ingridientsChoiceCell")
        self.tableView.contentInset.left = 50.0
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedIngridients.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingridientsChoiceCell", for: indexPath)
        cell.textLabel?.text = self.selectedIngridients[indexPath.row]
        cell.textLabel?.textAlignment = NSTextAlignment.right
        // Configure the cell...

        return cell
    }
    
}
