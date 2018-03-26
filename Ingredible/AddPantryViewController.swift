//
//  AddPantryViewController.swift
//  Ingredible
//
//  Created by Chloe Johnson on 3/26/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//

import UIKit

class AddPantryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Temporary back button
    // Takes you back to pantries screen
    // Unfortunately, that means the pantry tab bar controller does not maintain the tab bar
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "backToPantries", sender: self)
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
