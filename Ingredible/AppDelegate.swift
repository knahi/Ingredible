//
//  AppDelegate.swift
//  Ingredible
//
//  Created by Kayla Nahi on 3/9/18.
//  Chloe Johnson
//  Copyright © 2018 Ingredible. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

//    var ref: DatabaseReference!
//    ref = Database.database().reference()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //Firebase Installation code
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if !launchedBefore {
            //Add default pantries -- these will populate only when the app is initially downloaded
            PantriesModel.pantries["No pantry"] = [""]
            PantriesModel.pantries["Kitchen Classics"] = ["Bread", "Brown sugar", "Butter", "Eggs", "Flour", "Milk", "Peanut butter", "Pepper", "Salt", "Vegetable oil", "White sugar"]
            PantriesModel.pantries["Dining Hall"] = ["Apples", "Bananas", "Bell peppers", "Bread", "Broccoli", "Brown sugar", "Butter", "Carrots", "Cheese", "Chocolate", "Cinnamon", "Cream cheese", "Cucumbers", "Garlic powder", "Grapefruit", "Honey", "Hot sauce", "Jam", "Ketchup", "Lettuce", "Milk", "Mustard", "Nuts", "Olives", "Olive oil", "Onions", "Oranges", "Oregano", "Peanut butter", "Pepper", "Peppers", "Quinoa", "Red wine vinegar", "Rice", "Salt", "Soy sauce", "Spinach", "Tofu", "Tomatoes", "Tortillas", "White sugar", "Yogurt"]
            PantriesModel.pantries["Fruit Basket"] = ["Apples", "Bananas", "Blueberries", "Cantaloupe", "Cherries", "Grapes", "Lemons", "Limes", "Oranges", "Pears", "Pineapples", "Raspberries", "Strawberries"]
            PantriesModel.pantries["Get Recipes"] = ["Apples", "Avocados", "Bananas", "Bay leaves", "Bread", "Brown sugar", "Butter", "Cajun seasoning", "Cayenne pepper", "Cheese", "Chicken", "Chocolate", "Cinnamon", "Cloves", "Cocoa powder", "Coconut oil", "Condensed milk", "Couscous", "Cream", "Cumin", "Eggs", "Fish", "Garlic", "Garlic powder", "Ginger", "Graham crackers", "Honey", "Lemons", "Maple syrup", "Marshmallows", "Milk", "Mustard", "Olive oil", "Onions", "Onion powder", "Oranges", "Pasta", "Peanut butter", "Pepper", "Pork", "Quinoa", "Red wine vinegar", "Rice", "Salt", "Soy sauce", "Tomatoes", "Tomato paste", "Tomato sauce", "Tortillas", "Turmeric", "Vanilla extract", "Vegetable oil", "Vegetable soup", "White sugar"]
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
        let defaults = UserDefaults.standard
        defaults.set(PantriesModel.pantries, forKey: "Pantries")
        defaults.synchronize()
        
        FirebaseApp.configure()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

