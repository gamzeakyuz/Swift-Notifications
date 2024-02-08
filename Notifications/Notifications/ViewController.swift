//
//  ViewController.swift
//  Notifications
//
//  Created by Gamze Akyüz on 8.02.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.sender(notification:)),
                                               name: .notificationName,
                                               object: nil)
        
    }
    @objc func sender(notification:NSNotification){
        
        let sendMessage = notification.userInfo?["message"]
        let sendDate = notification.userInfo?["date"]
        let sendPersonObject = notification.userInfo?["object"] as! Person
        
        label.text = "Person Name : \(sendPersonObject.name!) \n Person Age: \(sendPersonObject.age!) \n Message : \(sendMessage!) \n Date : \(sendDate!)"
    }

}
extension Notification.Name {
    static let notificationName = Notification.Name("myNotification")
}

