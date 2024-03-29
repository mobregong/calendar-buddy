//
//  ReminderPrefsView.swift
//  calendar-buddy
//
//  Created by Maria Obregon Garcia on 2/8/22.
//

import SwiftUI
import UserNotifications

struct RemindersView: View {
    
    @State var every = ""
    @State var freq = ""
    
    var body: some View {
//        NavigationView {
            VStack {
                Text("Reminders")
                    .font(.system(size:28, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                Button("Request Permission") {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All set!")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Button("Schedule Notification in 5 seconds") {
                    let content = UNMutableNotificationContent()
                    content.title = "Feed the cat"
                    content.subtitle = "It looks hungry"
                    content.sound = UNNotificationSound.default

                    // show this notification five seconds from now
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                    // choose a random identifier
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                    // add our notification request
                    UNUserNotificationCenter.current().add(request)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                
//                Button("Schedule Notification for a certain date") {
//                    let content = UNMutableNotificationContent()
//                    content.title = "Feed the cat"
//                    content.subtitle = "It looks hungry"
//                    content.sound = UNNotificationSound.default
//
//                    // specify data
//                    var dateInfo = DateComponents()
//                    dateInfo.day = 15
//                    dateInfo.month = 02
//                    dateInfo.year = 2022
//                    dateInfo.hour = 01
//                    dateInfo.minute = 26
//
//                    // show this notification at specific date above
//                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
//
//                    // choose a random identifier
//                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//                    // add our notification request
//                    UNUserNotificationCenter.current().add(request)
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.top)
                
                Button("Schedule basic notification for all events") {
                    setBasicNotifications()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                .padding(.bottom)
                
                Group{
                    Text("How often?")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size:24, weight: .semibold))
                    TextField("Notifcation every _ amount of minutes", text: $every)
                        .autocapitalization(.none)
                        .padding(12)
                        .background(Color(.init(white: 0, alpha: 0.05)))
                    Text("How many times?")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size:24, weight: .semibold))
                    TextField("Number of notifications before event", text: $freq)
                        .autocapitalization(.none)
                        .padding(12)
                        .background(Color(.init(white: 0, alpha: 0.05)))
                }
                
                Button {
                    setNotifications()
                } label: {
                    HStack {
                        Spacer()
                        Text("Set notifications")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .font(.system(size: 14, weight: .semibold))
                        Spacer()
                    }
                    .background(Color.blue)
                    .padding(.top)
                }
                
                Spacer()
            }
            .padding()
            
//            .navigationTitle("Reminders")
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .background(Color(.init(white: 0, alpha: 0.05)))
//        }
//        .navigationBarTitle("Calendar Buddy", displayMode: .inline)
//        .navigationViewStyle(StackNavigationViewStyle())
    }
    private func setBasicNotifications() {
//        Should refresh events
//        handleGoogleCal ()
        
        print("should set notifications")
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).collection("user_info").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
//                        print("\(document.data())")
//                        self.todayResponse += ("\(document.data())")
//                        print(type(of: self.todayResponse))
                    
                    let name = document.documentID
                    let data = document.data()
                    let day = (data["day"] as! NSString).doubleValue
                    let month = (data["month"] as! NSString).doubleValue
                    let year = (data["year"] as! NSString).doubleValue
                    let hour = (data["hour"] as! NSString).doubleValue
                    let minute = (data["minute"] as! NSString).doubleValue
//                    let location = data["location"]
//                    let description = data["description"]
//

                    let content = UNMutableNotificationContent()
                    content.title = name
//                    content.subtitle = (description as? String ?? "Empty" )
                    content.sound = UNNotificationSound.default
//
//                    // specify data
                    var dateInfo = DateComponents()
                    dateInfo.day = Int(day)
                    dateInfo.month = Int(month)
                    dateInfo.year = Int(year)
                    dateInfo.hour = Int(hour)
                    dateInfo.minute = Int(minute)
//
//                    // show this notification five seconds from now
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
//
//                    // choose a random identifier
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//                    // add our notification request
                    UNUserNotificationCenter.current().add(request)
                }
            }
        }
    }
    
    private func setNotifications() {
        saveNotifications()
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).collection("user_info").document("events").collection("reminders").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let name = (data["event_name"] as! NSString)
                    let day = (data["day"] as! NSString).doubleValue
                    let month = (data["month"] as! NSString).doubleValue
                    let year = (data["year"] as! NSString).doubleValue
                    let hour = (data["hour"] as! NSString).doubleValue
                    let minute = (data["minute"] as! NSString).doubleValue
//                    let location = data["location"]
                    let description = data["description"]


                    let content = UNMutableNotificationContent()
                    content.title = name as String
                    content.subtitle = (description as? String ?? "Empty" )
                    content.sound = UNNotificationSound.default
//
//                    // specify data
                    var dateInfo = DateComponents()
                    dateInfo.day = Int(day)
                    dateInfo.month = Int(month)
                    dateInfo.year = Int(year)
                    dateInfo.hour = Int(hour)
                    dateInfo.minute = Int(minute)
//
//                    // show this notification five seconds from now
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
//
//                    // choose a random identifier
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    print(request)
//
//                    // add our notification request
                    UNUserNotificationCenter.current().add(request)
                }
            }
        }
    }
    
    private func saveNotifications() {
        print("should set notifications")
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
// //     API call
//        Prepare json data which will be our request body (uid and url)
        let json = ["uid": uid, "every": self.every, "freq": self.freq]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
//        post request
        let url = URL(string: "http://127.0.0.1:5000/firestore/reminders/preferences")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            guard let data = data, error == nil else {
                //        do not currently have working error message
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
    }
}

struct RemindersView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersView()
    }
}
