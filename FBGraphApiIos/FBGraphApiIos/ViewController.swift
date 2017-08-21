//
//  ViewController.swift
//  FBGraphApiIos
//
//  Created by Admin on 8/18/17.
//  Copyright © 2017 Mujadidia Inc. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import ObjectMapper

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    //  @IBOutlet weak var btnLogin: FBSDKLoginButton!
    @IBOutlet weak var btnLogin: UIButton!
    var user : User!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(FBSDKAccessToken.current() == nil){
            
            print("Not loged in")
            
        }
            
        else {
            
            print("loged in")
            
        }
        
    }
    
    
    
    
    @IBAction func btnAction(_ sender: Any) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    
                    self.getFBUserData()
                }
                else {
                    
                    print(error?.localizedDescription)
                    
                }
            }
        }
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if(error != nil){
            
            print("error")
            return
        }
        
        let userToken = result.token
        if let token = userToken{
            
            print(token)
            print(token.appID)
            
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    
                    let data  = result as! [String : Any]
                  
                    
                    self.user = User(JSON: data)
                   
                    self.performSegue(withIdentifier: "detail_view", sender: self)
                    
                }
                else {
                    
                    print(error!.localizedDescription)
                }
            })
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "detail_view"){
        
            let detailView = segue.destination as! DetailViewController
            detailView.data = user
        
        }
    }
}

