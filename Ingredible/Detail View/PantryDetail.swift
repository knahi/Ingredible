//
//  PantryDetail.swift
//  Ingredible
//
//  Created by Kayla Nahi on 4/13/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//

import UIKit

class PantryDetail: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var pantryTitle: UILabel!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        pantryTitle.text = PantriesModel.title
        
        // set tableview border
        tableView.layer.masksToBounds = true
        tableView.layer.borderColor = UIColor(red: 124/255, green: 154/255, blue: 114/255, alpha: 1).cgColor
        tableView.layer.borderWidth = 2.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PantriesModel.ingredients.count
    }
    
    // override
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) 
        cell.textLabel?.text = PantriesModel.ingredients[indexPath.item]
        return cell
    }
    
    //Swipe right to go back
    @IBAction func swipeRight(_ sender: Any) {
        if presentingViewController is UITabBarController{
            dismiss(animated: true, completion: nil)
            
        }else if let owningNavController = navigationController{
            owningNavController.popViewController(animated: true)
        }else{
            fatalError("view is not contained by a navigation controller")
        }
    }
    
    //Back button
    @IBAction func back(_ sender: Any) {
        if presentingViewController is UITabBarController{
            dismiss(animated: true, completion: nil)
            
        }else if let owningNavController = navigationController{
            owningNavController.popViewController(animated: true)
        }else{
            fatalError("view is not contained by a navigation controller")
        }
    }
    
}
