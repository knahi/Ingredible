//
//  RecipeDetail.swift
//  Ingredible
//
//  Created by Kayla Nahi on 4/9/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//

import UIKit

class RecipeDetail: UIViewController {

    @IBOutlet var recipeTitle: UILabel!
    @IBOutlet var servings: UILabel!
    @IBOutlet var quantity: UILabel!
    @IBOutlet var procedure: UILabel!
    
    @IBOutlet var favoriteButton: UIButton!
    var pressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let quantityString = RecipeModel.quantity.joined(separator: "\n")
        
        recipeTitle.text = RecipeModel.title
        servings.text = RecipeModel.servings
        quantity.text = quantityString
        procedure.text = RecipeModel.procedure
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func favorite(_ sender: Any) {
        if !pressed {
            let image = UIImage(named: "filled-in-star") as UIImage!
            favoriteButton.setImage(image, for: .normal)
            pressed = true
        } else {
            let image = UIImage(named: "empty-star") as UIImage!
            favoriteButton.setImage(image, for: .normal)
            pressed = false
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "backToResults", sender: self)
    }
    
}
