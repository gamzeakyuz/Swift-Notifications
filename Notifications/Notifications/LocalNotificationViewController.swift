//
//  LocalNotificationViewController.swift
//  Notifications
//
//  Created by Gamze Akyüz on 8.02.2024.
//

import UIKit
import UserNotifications

class LocalNotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
        
    var model = [myReminders]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
    }
    @IBAction func didTapAdd() {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "add") as? AddViewController else {
            return
        }
        
        vc.title = "New Reminders"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { title, body, date in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
                let new = myReminders(title: title, date: date, identifier: "id_\(title)")
                self.model.append(new)
                self.tableView.reloadData()
                
                
                let content = UNMutableNotificationContent()
                content.title = title
                content.sound = .default
                content.body = body
                
                let targetDate = date
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
                
                let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) { error in
                    if error != nil {
                        print("Something went wrong")
                    }
                }
                
                
            }
        }
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func didTapTest() {

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, error in
            if success {
                self.scheduleTest()
            }
            else if error != nil {
                 print("Error")
            }
        })
    }
    
    func scheduleTest(){
        
        let content = UNMutableNotificationContent()
        content.title = "Hello World"
        content.sound = .default
        content.body = "My long body.My long body.My long body.My long body.My long body"
        
        let targetDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
        
        let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                print("Something went wrong")
            }
        }
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model[indexPath.row].title
        let date = model[indexPath.row].date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, YYYY at hh:mm a"
        cell.detailTextLabel?.text = formatter.string(from: date)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

struct myReminders {
    var title: String
    var date: Date
    var identifier: String
}
