//
//  WelcomeViewController.swift
//  Sitter
//
//  Created by ECE Tech on 16/03/2018.
//  Copyright © 2018 ECE Tech. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    
    //label again don't copy instead connect
    //@IBOutlet weak var labelUserName: UILabel!
    
    @IBOutlet weak var labelUserName: UILabel!
    
    //button
    //@IBAction func buttonLogout(_ sender: UIButton) {
        
        //removing values from default
    @IBAction func buttonLogout(_ sender: UIButton) {
    
    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        
        //switching to login screen
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(loginViewController, animated: true)
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hiding back button
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        //getting user data from defaults
        let defaultValues = UserDefaults.standard
        if let name = defaultValues.string(forKey: "username"){
            //setting the name to label
            labelUserName.text = name
        }else{
            //send back to login view controller
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
