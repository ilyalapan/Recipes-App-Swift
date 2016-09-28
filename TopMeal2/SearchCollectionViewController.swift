//
//  SearchCollectionViewController.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 15/09/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit
import Alamofire



private let reuseIdentifier = "IngridientsSelectionCell"


class SearchCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, SWRevealViewControllerDelegate{

    @IBOutlet weak var dietButton: TagButton!
    
    var ingridientsChoices : [IngridientsChoice] = []
    
    var searchObject : RecipeSearch = RecipeSearch()
    
    var cookingTimeSliderValue: Float = 0.0
    
    @IBOutlet weak var revealButton: UIBarButtonItem!
    
    //Activity Indicator
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.revealViewController().delegate = self
        self.revealViewController().panGestureRecognizer()
        self.revealViewController().tapGestureRecognizer()
        self.revealViewController().panGestureRecognizer().isEnabled = false
        
        //Create Floating button
        let buttonWidth = CGFloat(120)
        let buttonHeight = self.view.bounds.size.height * 0.05
        let buttonY = self.view.bounds.size.height*0.91 - buttonHeight
        let buttonX = self.view.bounds.size.width/2 - buttonWidth/2
        let searchButton: UIButton = UIButton(frame: CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight))
        searchButton.layer.backgroundColor = UIColor.magenta.cgColor
        searchButton.layer.cornerRadius = 10
        searchButton.setTitle("Поиск", for: UIControlState.normal)
        searchButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        searchButton.addTarget(self, action: #selector(SearchCollectionViewController.performRecipeSearch), for: .touchUpInside)
        //Shadow
        searchButton.layer.masksToBounds = false
        searchButton.layer.shadowRadius = 1.5
        searchButton.layer.shadowOffset = CGSize(width: 0, height: 0.3)
        searchButton.layer.shadowColor = UIColor.black.cgColor
        searchButton.layer.shadowOpacity = 1.0
        //Add to view
        self.view.addSubview(searchButton)
        self.view.bringSubview(toFront: searchButton)
        searchButton.becomeFirstResponder()
        
        
        //Temporary
        self.ingridientsChoices = [ IngridientsChoice(title: "Мясо",identifier: "meat", ingridients:["Курица","Говядина","Баранина","Телятина"]), IngridientsChoice(title: "Морепродукты",identifier: "fish", ingridients: ["Лосось","Тунец"]),IngridientsChoice(title: "Овощи",identifier: "vegetables", ingridients: ["Томат","Огурец","Баклажан","Лук","Чеснок","Соевые ростки","Кукуруза"]),IngridientsChoice(title: "Соусы",identifier: "sauce", ingridients: ["Соевый соус","Томат"]) , IngridientsChoice(title: "Приправы",identifier: "spices", ingridients: ["Карри","Тмин"]), IngridientsChoice(title: "Мучное",identifier: "bread", ingridients: ["Лаваш","Черный Хлеб","Пшеничная Лапша","Гречневая Лапша"]), IngridientsChoice(title: "Общее",identifier: "general", ingridients: ["Молоко","Яйцо","Куриный бульон в кубиках","Пармезан"]), ]
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
    
    
    
    
    
    //reveal the detail view with list of selected ingredients
    @IBAction func revealIngredientsChoicesButton(_ sender: AnyObject) {
        
        if self.revealViewController() != nil {
            print(self.searchObject.ingridients)//Debug
            self.revealViewController().rightRevealToggle(animated: true) //Reveal the table view to the right
        }
    }
    
    
    
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
        performSegue(withIdentifier: "ingredientsDetail", sender: choice)
    }


    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "mainHeader", for: indexPath) as! SearchCollectionReusableView
            headerView.parent = self
            
            // MARK: BEGIN Prepare buttons
            let cornerRadius = CGFloat(15)
            let borderWidth = CGFloat(0.5)
            headerView.veganButton.layer.cornerRadius = cornerRadius
            headerView.veganButton.layer.borderWidth = borderWidth
            headerView.veganButton.layer.borderColor = UIColor.blue.cgColor
            headerView.veganButton.active = false
            
            headerView.dietButton.layer.cornerRadius = cornerRadius
            headerView.dietButton.layer.borderWidth = borderWidth
            headerView.dietButton.layer.borderColor = UIColor.blue.cgColor
            headerView.dietButton.active = false
            
            headerView.noGlutenButton.layer.cornerRadius = cornerRadius
            headerView.noGlutenButton.layer.borderWidth = borderWidth
            headerView.noGlutenButton.layer.borderColor = UIColor.blue.cgColor
            headerView.noGlutenButton.active = false

            headerView.noDairyButton.layer.cornerRadius = cornerRadius
            headerView.noDairyButton.layer.borderWidth = borderWidth
            headerView.noDairyButton.layer.borderColor = UIColor.blue.cgColor
            headerView.noDairyButton.active = false

            headerView.noNutsButton.layer.cornerRadius = cornerRadius
            headerView.noNutsButton.layer.borderWidth = borderWidth
            headerView.noNutsButton.layer.borderColor = UIColor.blue.cgColor
            headerView.noNutsButton.active = false

            headerView.noHoneyButton.layer.cornerRadius = cornerRadius
            headerView.noHoneyButton.layer.borderWidth = borderWidth
            headerView.noHoneyButton.layer.borderColor = UIColor.blue.cgColor
            headerView.noHoneyButton.active = false
            //MARK: END Prepare Button

            return headerView
        case UICollectionElementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "mainFooter", for: indexPath) 
            return footerView

        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    
    
    
    // MARK: Collection View Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2.03, height:80)
    }
    
    
    
    
    
    
    // MARK: SWRevealViewController Delegate

    
    func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
        if position == FrontViewPosition.leftSide {
            if let destination = revealController.rightViewController as? IngridientsChoiceTableViewController {
                destination.selectedIngridients = self.searchObject.ingridients
                self.revealViewController().panGestureRecognizer().isEnabled = true //enable pan gesture to allow to get back to original view
                destination.tableView.reloadData()
            }
        }
        
    }
    
    
    //MARK: Recipe Search
    
    func performRecipeSearch(){
        
        let messages = ["Ищем что-то вкусненькое", "Ищем чего покушать", "В поисках лучших рецептов", "Ищем...", "Подбираем...", "Ищем рецепт", "Опрашиваем своих \"Шеф-Поваров\" "] //Choose random meesage to display
        let randomIndex = Int(arc4random_uniform(UInt32(messages.count)))
        self.progressBarDisplayer(msg: messages[randomIndex], true)
        
        
        self.searchObject.loadInitialSearchResults{result in
            if result == "Success" {
                print(self.searchObject)
                self.performSegue(withIdentifier: "searchResultsSegue", sender: self.searchObject)
                self.messageFrame.removeFromSuperview()
            }
            else
            {
                //Output Error
                let alert = UIAlertController(title: "Error", message: result, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.messageFrame.removeFromSuperview()


            }
        }
    }
    
    
    func progressBarDisplayer(msg:String, _ indicator:Bool ) {
        
        //TODO: Make pretty
        let font = UIFont.systemFont(ofSize: 16)
        let myString: NSString = msg as NSString
        let width = myString.size(attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 16.0)]).width+15
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: width, height: 50))
        strLabel.font = font
        strLabel.text = msg
        strLabel.textColor = UIColor.white
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - CGFloat(width+50)/2, y: view.frame.midY - 25 , width: CGFloat(width)+50, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.startAnimating()
            messageFrame.addSubview(activityIndicator)
        }
        messageFrame.addSubview(strLabel)
        self.view.addSubview(messageFrame)
        
    }
    
    
    
    
    //MARK: prepare for segue
    
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
        else if segue.identifier == "searchResultsSegue" {
            if let searchResultVC = segue.destination as? SearchResultTableViewController {
                searchResultVC.searchObject = self.searchObject
            }
        }
        else if segue.identifier == "typeDetail" {
            if let typeDetailVC = segue.destination as? RecipeTypeCollectionViewController {
                typeDetailVC.searchObject = self.searchObject
            }
        }
        
    }
    
    
    
    // MARK: Buttons Methods
    
    func veganButtonPressed(sender: TagButton){
        if !sender.active {
            sender.active = true
            self.searchObject.vegan = true
        }
        else {
            sender.active = false
            self.searchObject.vegan = false
        }
    }
    
    func dietButtonPressed(sender: TagButton){
        if !sender.active {
            sender.active = true
            self.searchObject.diet = true
        }
        else {
            sender.active = false
            self.searchObject.diet = false
        }
    }
    
    func noDairyButtonPressed(sender: TagButton){
        if !sender.active {
            sender.active = true
            self.searchObject.noDairy = true
        }
        else {
            sender.active = false
            self.searchObject.noDairy = false
        }
    }
    
    func noNutsButtonPressed(sender: TagButton){
        if !sender.active {
            sender.active = true
            self.searchObject.noNuts = true
        }
        else {
            sender.active = false
            self.searchObject.noNuts = false
        }
    }
    
    func noGlutenButtonPressed(sender: TagButton){
        if !sender.active {
            sender.active = true
            self.searchObject.noGluten = true
        }
        else {
            sender.active = false
            self.searchObject.noGluten = false
        }
    }

    
    
}
