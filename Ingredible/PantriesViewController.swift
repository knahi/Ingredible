//
//  PantriesViewController.swift
//  Ingredible
//
//  Created by Chloe Johnson on 4/4/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//

import UIKit

class PantriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
//    
//    func loadDefaults() {
//
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        
        let defaults = UserDefaults.standard
        var pantriesDict = defaults.object(forKey: "Pantries") as! [String: [String]]
        PantriesModel.pantries = pantriesDict
        print(PantriesModel.pantries)
    }
    
    
    // Returns the same number of cells as recipes in our list
    // override
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PantriesModel.pantries.count - 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var titles = Array(PantriesModel.pantries.keys)
        print(titles)
        let index = titles.index(of: "No pantry")
        titles.remove(at: index!)
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath)
        cell.textLabel?.text = titles[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var titles = Array(PantriesModel.pantries.keys)
        let index = titles.index(of: "No pantry")
        titles.remove(at: index!)
        let pantryTitle = titles[indexPath.row]
        let ingredients = PantriesModel.pantries[pantryTitle]
        
        PantriesModel.title = pantryTitle as! String
        PantriesModel.ingredients = ingredients as! [String]
        
        performSegue(withIdentifier: "showPantryDetail", sender: self)
    }
    
    //Deletes pantry from list and from pantry model when swiped
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            
            var titles = Array(PantriesModel.pantries.keys)
            let index = titles.index(of: "No pantry")
            titles.remove(at: index!)
            PantriesModel.pantries.removeValue(forKey: titles[indexPath.row])
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // State saving when pantry is deleted
            let defaults = UserDefaults.standard
            defaults.set(PantriesModel.pantries, forKey: "Pantries")
            defaults.synchronize()
            print(defaults.object(forKey: "Pantries"))
        }
    }
    
    @IBAction func addPantry(_ sender: Any) {
        performSegue(withIdentifier: "addPantry", sender: self)
    }
    

}
