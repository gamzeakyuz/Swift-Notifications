//
//  AddViewController.swift
//  Notifications
//
//  Created by Gamze Akyüz on 8.02.2024.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var commentField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!

    public var completion: ((String, String, Date) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        titleField.delegate = self
        commentField.delegate = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "add", style: .done, target: self, action: #selector(didTapSaveButton))
    }
    

    @objc func  didTapSaveButton(){
            
            if let titleText = titleField.text, !titleText.isEmpty,
               let commentText = commentField.text, !commentText.isEmpty{
                let targetDate = datePicker.date
                
                completion?(titleText, commentText, targetDate)
            }
            
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
            textField.resignFirstResponder()
            return true
        }
    

}
