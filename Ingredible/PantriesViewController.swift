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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    // Returns the same number of cells as recipes in our list
    // override
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PantriesModel.pantries.count - 1
    }
    
    
    // override
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var titles = Array(PantriesModel.pantries.keys)
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
            print(titles[indexPath.row])
            print (titles)
            PantriesModel.pantries.removeValue(forKey: titles[indexPath.row])
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            print(PantriesModel.pantries)
        }
    }
    
    @IBAction func addPantry(_ sender: Any) {
        performSegue(withIdentifier: "addPantry", sender: self)
    }
    

}
