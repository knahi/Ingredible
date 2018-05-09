//
//  HomeViewController.swift
//  Ingredible
//
//  Created by Kayla Nahi on 4/13/18.
//  Copyright © 2018 Ingredible. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Synchronize state when app opens
        let defaults = UserDefaults.standard
        let pantriesDict = defaults.object(forKey: "Pantries") as! [String: [String]]
        PantriesModel.pantries = pantriesDict
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
