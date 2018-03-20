//
//  SearchResultTableViewController.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 20/09/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit

class SearchResultTableViewController: UITableViewController {

    
    var searchObject : RecipeSearch = RecipeSearch()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.searchObject.types)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchObject.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as? SearchResultTableViewCell
        cell?.configureCell(searchResult: searchObject.searchResults[indexPath.row])

        return cell!
    }


    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if ( indexPath.row == (self.searchObject.searchResults.count - 1) ) && (!self.searchObject.noMoreResults)
        {
            self.searchObject.loadMore{result in
                if result == ServerRequestResponse.Success{
                    self.tableView.reloadData()
                }
                else if result == ServerRequestResponse.Empty
                {
                    return
                }
                else {
                    let alert = UIAlertController(title: "Error", message: result.rawValue, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }

            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 4.66
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchRes = self.searchObject.searchResults[indexPath.row]
        self.performSegue(withIdentifier: "postSegue", sender: searchRes)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "postSegue" {
            if let detailsVC = segue.destination as? PostViewController {
                if let searchResult = sender as? RecipeSearchResult {
                    detailsVC.recipe = searchResult as Recipe
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
