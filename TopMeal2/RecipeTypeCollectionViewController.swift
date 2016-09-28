//
//  RecipeTypeCollectionViewController.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 27/09/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit

private let reuseIdentifier = "typeCell"

class RecipeTypeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var searchObject : RecipeSearch? = nil
    var recipeTypes: [Dictionary<String,String>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.recipeTypes.append(["Name":"Горячее","Identifier":"main"])
        self.recipeTypes.append(["Name":"Закуска","Identifier":"starter"])
        self.recipeTypes.append(["Name":"Завтрак","Identifier":"breakfast"])
        self.recipeTypes.append(["Name":"Паста","Identifier":"pasta"])
        self.recipeTypes.append(["Name":"Салат","Identifier":"salad"])
        self.recipeTypes.append(["Name":"Cуп","Identifier":"soup"])
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.recipeTypes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let type = recipeTypes[indexPath.row]["Identifier"]!
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? TypeCollectionViewCell {
            let isSelected = searchObject?.types.contains(type)
            cell.configureCell(typeDict: recipeTypes[indexPath.row], isSelected: isSelected!)
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }

    // MARK: UICollectionViewDelegate

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let type = recipeTypes[indexPath.row]["Identifier"]!
        if let cell = collectionView.cellForItem(at: indexPath) as? TypeCollectionViewCell {
            if cell.checkImageView.isHidden {
                cell.checkImageView.isHidden = false
                searchObject?.types.append(type)
            } else {
                cell.checkImageView.isHidden = true
                searchObject?.types = (searchObject?.ingridients.filter{$0 != type})!

            }
        }
        print(searchObject?.types) //DEBUG

    }
    
    //MARK: Collection View Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2.1, height:80)
    }
    
    
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
