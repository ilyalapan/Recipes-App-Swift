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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.feed.loadNextPosts(completed: {result in
        //    self.tableView.reloadData() TODO: Proper refreshing of posts
        //})
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let currentUser = FIRAuth.auth()?.currentUser
        currentUser?.getTokenForcingRefresh(true) {idToken, error in
            if let error = error {
                // Handle error
                return
            }
            self.feed.refreshPosts(idToken: idToken!,completed: {result in
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
            print(feed.posts[indexPath.row].recipe.name)
            feedCell.configureCell(post: feed.posts[indexPath.row])
        }
        else
        {
            print("error")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feed.posts.count
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
