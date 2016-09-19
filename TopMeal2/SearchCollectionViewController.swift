//
//  SearchCollectionViewController.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 15/09/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit

private let reuseIdentifier = "IngridientsSelectionCell"

class SearchCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
    var ingridientsChoices : [IngridientsChoice] = []
    
    var searchObject : RecipeSearch = RecipeSearch()
    
    var cookingTimeSliderValue: Float = 0.0
    
    @IBOutlet weak var revealButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Temporary
        self.ingridientsChoices = [ IngridientsChoice(title: "Мясо",identifier: "meat", ingridients:["Курица","Говядина"]), IngridientsChoice(title: "Морепродукты",identifier: "fish", ingridients: ["Лосось","Тунец"]),IngridientsChoice(title: "Овощи",identifier: "vegetables", ingridients: ["Помидор","Томат"]),IngridientsChoice(title: "Соусы",identifier: "sauce", ingridients: ["Помидор","Томат"]) , IngridientsChoice(title: "Приправы",identifier: "spices", ingridients: ["Карри","Тмин"]), ]
        //populateIngridientsChoices()
        /////////////////
        
    }
    
    //TODO: Implement downlading of types and ingredients
    /*
    func populateIngridientsChoices() {
        let path = Bundle.main.path(forResource: "choices", ofType: "txt")
        
        do{
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            print(rows)
        } catch let error as NSError
        {
            print(error.debugDescription)
        }
    }
    */
    
    @IBAction func revealIngredientsChoicesButton(_ sender: AnyObject) {
        
        if self.revealViewController() != nil {
            let revealController = self.revealViewController() as! RevealViewController
            revealController.selectedIngridients = self.searchObject.ingridients
            print(self.searchObject.ingridients)
            self.revealViewController().rightRevealToggle(animated: true)
        }
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
        return self.ingridientsChoices.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? SearchCollectionViewCell){
        
            cell.configureCell(choice: self.ingridientsChoices[indexPath.row])
            return cell
        }
        else {
            return UICollectionViewCell()
        }

    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let choice: IngridientsChoice! = self.ingridientsChoices[indexPath.row]
        print(searchObject.ingridients) //debug
        performSegue(withIdentifier: "ingredientsDetail", sender: choice)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "ingredientsDetail" {
            if let detailsVC = segue.destination as? IngredientsDetailTableViewController {
                if let choice = sender as? IngridientsChoice {
                    detailsVC.ingredients = choice.ingridients
                    detailsVC.searchObject = self.searchObject
                }
            }
        }
        
    }

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2.03, height:80)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "mainHeader", for: indexPath) as! SearchCollectionReusableView
            headerView.parent = self
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
        
    // MARK: UICollectionViewDelegate

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
