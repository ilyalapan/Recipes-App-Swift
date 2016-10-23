//
//  FeedViewController.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 09/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit
import Firebase



class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var feed : FeedObject = FeedObject()
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged) 
        self.tableView.addSubview(refreshControl)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let currentUser = FIRAuth.auth()?.currentUser
        currentUser?.getTokenForcingRefresh(true) {idToken, error in
            if let error = error {
                // Handle error
                return
            }
            self.feed.load(idToken: idToken!,completed: {result in
                self.tableView.reloadData()
            })
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? FeedTableViewCell
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let feedCell = cell as? FeedTableViewCell{
            feedCell.configureCell(post: feed.posts[indexPath.row])
        }
        else
        {
            print("error")
        }
        if indexPath.row == feed.posts.count - 1 {
            let currentUser = FIRAuth.auth()?.currentUser
            currentUser?.getTokenForcingRefresh(true) {idToken, error in
                if let error = error {
                    // Handle error
                }
                self.feed.loadMore(idToken: idToken!) {result  in
                    if (result as? ServerRequestResponse == ServerRequestResponse.Success) {
                        self.tableView.reloadData()
                    }
                }
            }

        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feed.posts.count
    }
    
    
    //TODO: This still looks nasty
    //doing this in the controller and not in the FeedTableViewCell because I need to conform to MVC protocol
    @IBAction func likeButtonPressed(_ sender: AnyObject) {
        if let button = sender as? UIButton {
            if let cell = button.superview?.superview as? FeedTableViewCell { //superview twice to get cell beacuse first is a content view
                let indexPath = self.tableView.indexPath(for: cell) //get index path of the cell
                let post = self.feed.posts[(indexPath?.row)!]
                cell.switchCellLikedState()//change the state of the button immediatly(responsive interface)
                let currentUser = FIRAuth.auth()?.currentUser
                currentUser?.getTokenForcingRefresh(true) { idToken, error in //probably move firebase in to like method
                    if let error = error {
                        cell.configureCellLikes(post: post) //operation failed, return to the initial button state and handle the error
                        //TODO: output an error message
                        return
                    }
                    post.like(idToken: idToken!) { result in
                        if result != ServerRequestResponse.Success{
                            cell.configureCellLikes(post: post) //operation failed, return to the initial button state and handle the error
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func refreshButtonPressed(_ sender: AnyObject) {
        self.refresh()
    }
    
    
    
    func refresh() {
        let currentUser = FIRAuth.auth()?.currentUser
        currentUser?.getTokenForcingRefresh(true) {idToken, error in
            if let error = error {
                // Handle error
                return
            }
            self.feed.load(idToken: idToken!,completed: {result in
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
                self.tableView.setContentOffset( CGPoint(x: 0, y: 0) , animated: true)
            })
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




