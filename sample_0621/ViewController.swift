//
//  ViewController.swift
//  sample_0621
//
//  Created by 吉田れい on 2019/06/21.
//  Copyright © 2019 吉田れい. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController {
    
    @IBOutlet var labeltest : UILabel!
    @IBOutlet var buttonTest : UIButton!
    
    @IBOutlet weak var koment: UITextView!
    var count = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labeltest.text = "Swift Test"
        
        buttonTest.setTitle("Button", for:UIControl.State.normal)
    }
    func SendPostRequestToLineNotify(_ message: String) {
        
        let env = ProcessInfo.processInfo.environment
        
        guard let LINENOTIFY_TOKEN = env["LINENOTIFY_TOKEN"] else {
            fatalError("LINENOTIFY_TOKENの値がnilです")
        }
        let url = "https://notify-api.line.me/api/notify"
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Bearer "+LINENOTIFY_TOKEN
        ]
        let parameters:[String: Any] = [
            "message": message
        ]
        
        AF.request(url,method: .post, parameters: parameters,encoding: URLEncoding.default,headers: headers).responseString {
            response in
            switch response.result {
            case .success(let value):
                self.labeltest.text = value
            case .failure(let error):
                self.labeltest.text = error.localizedDescription
            }
        }
        
    }
    @IBAction func buttonTapped(_ sender :Any)
    {
        SendPostRequestToLineNotify(koment.text)
        
        
    }
    
    
    
}

