//
//  DiscoverViewController.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 21/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit
import Firebase


class DiscoverViewController: TMFeedCollectionController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    
    @IBOutlet weak var navigationItemSearchBar: UINavigationItem!
    
    var dicoverFeed: DiscoverFeedManager = DiscoverFeedManager()
    
    override var feed: (Loadable & Pagination)?{
        get {
            return dicoverFeed
        }
        set {
            self.dicoverFeed = (newValue as? DiscoverFeedManager)!
        }
    }
    
    let reuseIdentifier: String = "discoverCell"
    var searchController: UISearchController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up search controller
        let resultsController = DiscoverSearchResultsController()
        self.searchController = UISearchController(searchResultsController: resultsController)
        self.searchController?.hidesNavigationBarDuringPresentation = false
        self.navigationItemSearchBar.titleView = searchController?.searchBar
        self.navigationController?.hidesBarsOnSwipe = true
        searchController?.delegate = resultsController
        searchController?.searchResultsUpdater = resultsController
        self.definesPresentationContext = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let currentUser = FIRAuth.auth()?.currentUser
        currentUser?.getTokenForcingRefresh(true) {idToken, error in
            if let error = error {
                // Handle error
                return
            }
            self.dicoverFeed.load(idToken: idToken!,completed: {result in
                self.collectionView.reloadData()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dicoverFeed.count()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? DiscoverCollectionViewCell){
            
            cell.configureCell(post: self.dicoverFeed.posts[indexPath.row])
            return cell
        }
        else {
            return UICollectionViewCell()
        }
        
    }
    
    
    // MARK: Collection View Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width/3.05, height: self.view.frame.width/3.05)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
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
