//
//  TMFeedCollectionController.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 24/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit
import Firebase



/// Base class for Feeds presented as a collectionView. Examples - Discover Feed, Profile Page and others. Allready implements pagination and
/// loading for fast scrolling, which are two methods that should be implemented on all such views. To use just wrap the Loadable & Pagination object in to a
/// an alias with getter and setters and use it
/// DO NOT FORGET TO CONNECT A VIEW OUTLET WHEN SETTING UP //TODO: Actually, do I need to do that?
class TMFeedCollectionController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var refreshControl: UIRefreshControl!

    
    
    var feed: Loadable & Pagination?
    
    var isLoading: Bool = false
    var isRefreshing: Bool = false
    
    var lastOffset:CGPoint? = CGPoint(x: 0,y: 0)
    var lastOffsetCapture:TimeInterval? = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    func loadMoreData() {
        if isLoading || isRefreshing {
            return //Do not load if is already loading
        }
        self.isLoading = true
        let currentUser = FIRAuth.auth()?.currentUser
        currentUser?.getTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                // Handle error
            }
            self.feed?.loadMore(idToken: idToken!) {result  in
                if (result == ServerRequestResponse.Success) {
                    self.isLoading = false
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    
    func refresh() {
        isRefreshing = true
        isLoading = false
        let currentUser = FIRAuth.auth()?.currentUser
        currentUser?.getTokenForcingRefresh(true) {idToken, error in
            if let error = error {
                // Handle error
                return
            }
            self.feed?.load(idToken: idToken!,completed: {result in
                if (self.refreshControl != nil) {
                    self.refreshControl.endRefreshing()
                }
                self.collectionView.reloadData()
                self.isRefreshing = false
            })
        }
    }

    
    
    // MARK: - Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == ( feed?.count() )! - 1 {
            self.loadMoreData()
        }
    
    }
    
    
    // MARK: - Scroll View
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        let currentOffset = scrollView.contentOffset
        let currentTime = NSDate().timeIntervalSinceReferenceDate
        let timeDiff = currentTime - lastOffsetCapture!
        let captureInterval = 0.1
        
        if(timeDiff > captureInterval) {
            
            let distance = currentOffset.y - lastOffset!.y     // calc distance
            let scrollSpeedNotAbs = (distance * 10) / 1000     // pixels per ms*10
            let scrollSpeed = fabsf(Float(scrollSpeedNotAbs))  // absolute value
            
            if (scrollSpeed > 2) {
                self.loadMoreData()
            }
            
            
            lastOffset = currentOffset
            lastOffsetCapture = currentTime
            
        }
    }

}


