//
//  ViewController.swift
//  Sitter
//
//  Created by ECE Tech on 08/03/2018.
//  Copyright © 2018 ECE Tech. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController
{
    
    let a = 0
    
    
    //The login script url make sure to write the ip instead of localhost
    //you can get the ip using ifconfig command in terminal
    let URL_USER_LOGIN = "https:/pet-sitter.000webhostapp.com/login.php"
    
    //the defaultvalues to store user data
    let defaultValues = UserDefaults.standard
    
    //the connected views
    //don't copy instead connect the views using assistant editor
    
    @IBOutlet weak var textFieldUserName: UITextField!
    
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var labelMessage: UILabel!
    //@IBOutlet weak var labelMessage: UILabel!
    //@IBOutlet weak var textFieldUserName: UITextField!
    //@IBOutlet weak var textFieldPassword: UITextField!
    
    //the button action function
    
    
    
    @IBAction func buttonLogin(_ sender: UIButton) {
        //getting the username and password
        let parameters: Parameters=[
            "username":textFieldUserName.text!,
            "password":textFieldPassword.text!
        ]
        
        //making a post request
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    //if there is no error
                    if(!(jsonData.value(forKey: "error") as! Bool)){
                        
                        //getting the user from response
                        let user = jsonData.value(forKey: "user") as! NSDictionary
                        
                        //getting user values
                        let userId = user.value(forKey: "id") as! String
                        let username = user.value(forKey: "nom") as! String
                        let userfirstname = user.value(forKey: "prenom") as! String
                        let useremail = user.value(forKey: "email") as! String
                        
                        
                        //saving user values to defaults
                        self.defaultValues.set(userId, forKey: "userid")
                        self.defaultValues.set(username, forKey: "username")
                        self.defaultValues.set(userfirstname, forKey: "userfirstname")
                        self.defaultValues.set(useremail, forKey: "useremail")
                        
                        
                        
                        //switching the screen
                        let WelcomViewController = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                        self.navigationController?.pushViewController(WelcomViewController, animated: true)
                        
                        self.dismiss(animated: false, completion: nil)
                    }else{
                        //error message in case of invalid credentialq
                        self.labelMessage.text = "Invalid username or password"
                    }
                }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //hiding the navigation button
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //if user is already logged in switching to profile screen
        /*if defaultValues.string(forKey: "username") != nil{
            let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewcontroller") as! WelcomeViewController
            self.navigationController?.pushViewController(profileViewController, animated: true)
            
        }*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
