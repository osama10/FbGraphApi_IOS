//
//  DetailViewController.swift
//  FBGraphApiIos
//
//  Created by Admin on 8/21/17.
//  Copyright © 2017 Mujadidia Inc. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var ivImageView : UIImageView!
    @IBOutlet weak var lbId : UILabel!
    @IBOutlet weak var lbName : UILabel!
    @IBOutlet weak var btnLogut: UIButton!
    
    var data : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let _data =  data.picture?["data"] as! [String : Any]
        let imgUrl  = _data["url"] as! String
        ivImageView.setImageFromURl(stringImageUrl: imgUrl)
        lbId.text = "Id : \(data.id!)"
        lbName.text = "Name : " + data.name!
        // Do any additional setup after loading the view.
    }
    
    @IBAction func postData(_ sender: UIButton) {
        
        if(FBSDKAccessToken.current() != nil){
            
            
            let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
            fbLoginManager.logIn(withPublishPermissions: ["publish_actions"], from: self) { (result, error) -> Void in
                if (error == nil){
                    let fbloginresult : FBSDKLoginManagerLoginResult = result!
                    
                    if(fbloginresult.grantedPermissions.contains("publish_actions"))
                    {
                        self.postData()
                        
                    }
                    else {
                        
                        print("permission not granted")
                        
                    }
                }
                    
                    
                else {
                    
                    print(error?.localizedDescription)
                    
                }
                
            }
            
        }
    }
    
    func postData (){
        
        
        FBSDKGraphRequest.init(graphPath: "me/feed", parameters: ["message" : "I am a disco dancer tun tun tun tana"], httpMethod: "POST").start(completionHandler: { (connection, result, error) -> Void in
            if (error == nil){
                //everything works print the user data
                
                print("done")
                
            }
            else {
                
                print(error!.localizedDescription)
            }
        })
        
        
        
        
    }
    
    @IBAction func logout(_ sender: UIButton) {
        
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logOut()
        
        performSegue(withIdentifier: "signout", sender: self)
        
        
    }
    
    
}

extension UIImageView{
    
    func setImageFromURl(stringImageUrl url: String){
        
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOf: url as URL) {
                self.image = UIImage(data: data as Data)
            }
        }
    }
}
