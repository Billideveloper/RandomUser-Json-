//
//  ViewController.swift
//  RandomUser(Json)
//
//  Created by Ravi Thakur on 04/10/20.
//

import UIKit
import Alamofire



class ViewController: UIViewController {
    
    
    @IBOutlet weak var card: ShadowView!
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    
    @IBOutlet weak var phone: UILabel!
    
    
    
    @IBOutlet weak var gender: UISegmentedControl!
    
    //MARK: - after importing alamofire

    override func viewDidLoad() {
        
        requestData()
        
        super.viewDidLoad()
        card.layer.borderColor = UIColor.black.cgColor
        card.clipsToBounds = false
        card.layer.borderWidth = 0.5
        card.layer.cornerRadius = 15
    
        // Do any additional setup after loading the view.
    }

    
    
    //MARK: - get a Json response from web with the help of request Url with the hwlp of alamofire
    
    func requestData(){
        
        let murl = "https://randomuser.me/api"
        
      //MARK: - fetch responsejson
        
        AF.request(murl).responseJSON { [self] (data) in
            
            //let result = data.result
            
            if let dict = data.value as? Dictionary<String, AnyObject>{
                
        
                print(dict)
                
                if let resultpath = (dict["results"]!as! NSArray)[0] as? Dictionary<String, AnyObject>{
                    
                    
                    if let mgender = resultpath["gender"] as? String{
                        
                        if mgender == "male"{
                            gender.selectedSegmentIndex = 0
                        }else{
                            gender.selectedSegmentIndex = 1
                        }
                        print(mgender)
                    
                    }
                    
                    if let memail = resultpath["email"] as? String{
                        
                        email.text = memail
                    }
                    
                    if let mphone = resultpath["phone"] as? String{
                        
                        phone.text = mphone
                    }
                    
                    if let infopath = resultpath["name"] as? Dictionary<String, AnyObject>{
                        
                        if let title = infopath["title"] as? String{
                            if let fullname = infopath["first"] as? String{
                                
                                
                                let mname = "\(title) \(fullname)"
                                
                                name.text = mname
                                
                                
                            }

                            
                        }
                        
                    }
                    
                    if let imagepath = resultpath["picture"] as? Dictionary<String, AnyObject>{
                        
                        
                        if let imageurl = imagepath["medium"] as? String{
                            
                            //MARK: - networkking
                            
                            if let url = URL(string: imageurl){
                            
                            let session = URLSession(configuration: .default)
                            
                            let download = session.dataTask(with: url) { (data, response, error) in
                                
                                if let e = error{
                                    print(e.localizedDescription)
                                }else{
                                    if let mresponse = response as? HTTPURLResponse{
                                        print(mresponse.statusCode)
                                        
                                        if let mdata = data{
                                            
                                            let imagedata = UIImage(data: mdata)
                                            
                                            if let mimage = imagedata{
                                                DispatchQueue.main.async {
                                                    profilePicture.image = mimage
                                                }
                                                
                                                
                                            }
                                            
                                        }
                                        
                                        
                                    }
                                    
                                    
                                    
                                }
                                
                                
                                
                                
                                
                            }
                            
                            download.resume()
                            
                            }
                            
                        }
                        
                        
                    }
                    
                    
                    
                }
                
            }
            
            
        }
    }
    
    
    
    
    
    @IBAction func fetchNew(_ sender: Any) {
        
        requestData()
       
        
        
        
    }
    

}

