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
    @IBOutlet var ingredients: UILabel!
    @IBOutlet var procedure: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "backToResults", sender: self)
    }
    
}
