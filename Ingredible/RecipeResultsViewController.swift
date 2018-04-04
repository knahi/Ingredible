//
//  RecipeResultsViewController.swift
//  Ingredible
//
//  Created by Chloe Johnson on 3/14/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//  HUGE thanks to https://www.youtube.com/watch?v=tv5c1mZttVE

import UIKit
import Firebase

class RecipeResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet var tableView: UITableView!
    
    var ref: DatabaseReference!
    var refHandle: UInt!
    var recipeList = [Recipe]()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        fetchRecipes()
        // Do any additional setup after loading the view.
    }
    
    // Returns the same number of cells as recipes in our list
    // override
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    // override
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath as IndexPath)
        
        // Set cell contents
        cell.textLabel?.text = recipeList[indexPath.row].recipes
        return cell
    }
    
    
    func fetchRecipes(){
        //refHandle = ref.child("Recipes").observe(.childAdded, with: { (snapshot) in
        refHandle = ref.child("Recipes").observe(.value, with: { (snapshot) in
            // if it doesn't return null
            if let dictionary = snapshot.value as? [String: AnyObject] {
                print(dictionary)
                
                let recipe = Recipe()
                
                recipe.setValuesForKeys(dictionary)
                self.recipeList.append(recipe)

                //dispatch_async(dispatch_get_main_queue(), {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Temporary back button
    // Takes you back to home screen
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "backToIngredients", sender: self)
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
