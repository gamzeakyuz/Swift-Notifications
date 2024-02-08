//
//  ViewController2.swift
//  Notifications
//
//  Created by Gamze Akyüz on 8.02.2024.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func sendNotification(_ sender: Any) {
        
        let person = Person(name: "Ahmet", age: 18)
        
        NotificationCenter.default.post(name: .notificationName, object: nil, userInfo: ["message":"merhaba","date":Date().formatted(),"object":person])
        
        dismiss(animated: true, completion: nil)
    }

}
