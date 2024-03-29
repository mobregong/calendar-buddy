//
//  EventsMainView.swift
//  calendar-buddy
//
//  Created by Maria Obregon Garcia on 2/2/22.
//

import SwiftUI

struct EventsView: View {
    
//    enum Event: String, CaseIterable, Identifiable {
//        case next, today, week
//        var id: Self { self }
//    }
//    @State private var EventMode: Event = .next
    @State var isTodayMode = true
    @State var count = 0
    @State var todayResponse = ""
    @State var todayTimes = ""

    
    
    var body: some View {
//        NavigationView {
            ScrollView {
                VStack(spacing: 16){
                    Text("Events")
                        .font(.system(size:28, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Picker(selection: $isTodayMode, label: Text("Picker here")){
                        Text("Next")
                            .tag(false)
                        Text("Today").tag(true)
//                        Text("Week").tag(false)
                    }
                        .pickerStyle(SegmentedPickerStyle())
                        
                    if isTodayMode {
                        Button {
                           fetchToday()
                        } label: {
                            Text("Load events")
                                .foregroundColor(.white)
                                .padding(12)
                                .font(.system(size:14, weight: .semibold))
                        }.background(Color.blue)
                        
                        Text(self.todayResponse)
                        Text(self.todayTimes)
                        
                    } else {
                        Button {
                           fetchNext()
                        } label: {
                            Text("Load events")
                                .foregroundColor(.white)
                                .padding(12)
                                .font(.system(size:14, weight: .semibold))
                        }.background(Color.blue)
                    }
                }
                    .padding()
            }
//                .navigationBarTitle("Calendar Buddy")
//                .navigationTitle("Events")
//                .background(Color(.init(white: 0, alpha: 0.05)))
//        }
//        .navigationBarTitle("Calendar Buddy", displayMode: .inline)
//        .navigationViewStyle(StackNavigationViewStyle())
    }
    private func fetchNext () {
        print("fetch next")
    }
    
    
    
    private func fetchToday () {
        setToday()
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).collection("user_info").document("events").collection("events_today").getDocuments(){ (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
//                        print("\(document.data())")
//                        self.todayResponse += ("\(document.data())")
//                        print(type(of: self.todayResponse))
                        
                        let data = document.data()
                        let name = data["event_name"]
                        let time = data["event_time"]
//                        let description = data["description"]
//                        let location = data["location"]
                        
                        self.count += 1
                        self.todayResponse.append(" \(name as! String)")
//                        print(self.todayResponse)
//                        print("Description: \(description)")
                        self.todayTimes.append(" \(time as! String)")
//                        print(self.todayResponse)
//                        print("Description: \(description)")
                    }
                    print(self.count)
                }
            }
    }
    private func setToday () {
        print("set today")
        //        Get current user id
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
// //     API call
//        Prepare json data which will be our request body (uid and url)
        let json = ["uid": uid]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
//        post request
        let url = URL(string: "http://127.0.0.1:5000/firestore/events/today")!
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
//    func jsonToString(json: AnyObject){
//        do {
//            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
//            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
//            print(convertedString ?? "defaultvalue")
//        } catch let myJSONError {
//            print(myJSONError)
//        }
//    }
}

struct EventsMainView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}

