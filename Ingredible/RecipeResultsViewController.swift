//
//  RecipeResultsViewController.swift
//  Ingredible
//
//  Created by Chloe Johnson on 3/14/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//  HUGE thanks to https://www.youtube.com/watch?v=tv5c1mZttVE

import UIKit

class RecipeResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // Returns the same number of cells as recipes in our list
    // override
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        //return FavModel.allTitles.count
    }
    
    // override
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
//
//        // Set cell contents
//        cell.textLabel?.text = FavModel.allTitles[indexPath.row]
//        print(FavModel.allTitles[indexPath.row])
//        print(FavModel.allTitles[indexPath.item])
//        return cell
//
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = "test"
        return cell
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

}
