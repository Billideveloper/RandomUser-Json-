//
//  ViewController.swift
//  RandomUser(Json)
//
//  Created by Ravi Thakur on 04/10/20.
//

import UIKit
import Alamofire



class ViewController: UIViewController {
    
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    
    @IBOutlet weak var phone: UILabel!
    
    
    
    @IBOutlet weak var gender: UISegmentedControl!
    
    //MARK: - after importing alamofire

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    //MARK: - get a Json response from web with the help of request Url with the hwlp of alamofire
    
    func requestData(){
        
        let murl = "https://randomuser.me/api"
      
        AF.request(murl).response { (response) in
            
            let results = response.result
            
            print(results)
            
            print(response.request as Any)
            
            print(response.response as Any)
            
            
        }
    }
    
    
    
    
    
    @IBAction func fetchNew(_ sender: Any) {
        
        requestData()
       
        
        
        
    }
    

}

