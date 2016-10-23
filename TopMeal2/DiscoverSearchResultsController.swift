//
//  DiscoverSearchResultsController.swift
//  
//
//  Created by Ilya Lapan on 22/10/2016.
//
//

import UIKit

class DiscoverSearchResultsController: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate {

    

    
    var resultsManager = SearchResultsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.barHideOnSwipeGestureRecognizer = false
        tableView.register(UINib(nibName: "DiscoverSearchResultCell", bundle: nil), forCellReuseIdentifier: "searchResultCell")
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return resultsManager.users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as? DiscoverSearchResultCell
        cell?.configureCell(user: resultsManager.users[indexPath.row])

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    //MARK: - UISearchBarDelegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //TODO: Allowed to do this without authentication. Not sure if good idea, but makes no sense to waste time with Firebase token. Maybe store firebase token?
        resultsManager.performSearch(searchString: searchBar.text!){ result in
            if result == ServerRequestResponse.Success {
                self.tableView.reloadData()
            }
        }
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        resultsManager.performSearch(searchString: searchController.searchBar.text!){ result in
            self.tableView.reloadData()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
