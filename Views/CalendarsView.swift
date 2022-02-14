//
//  CalendarsView.swift
//  calendar-buddy
//
//  Created by Maria Obregon Garcia on 2/2/22.
//

import SwiftUI

struct CalendarsView: View {
    
    @State var isConnectMode = true
    @State var calendarLink = ""
    @State var calendarName = ""
    @State var calendarConnectMessage = ""
    
//    @Published var selectedCalendars: Set<EKCalendar>?

    
//    private var cc = CalendarChooser(calendars: self.$eventsRepository.selectedCalendars, eventStore: self.eventsRepository.eventStore)
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Picker(selection: $isConnectMode, label: Text("Picker here")) {
                        Text("Connect")
                            .tag(true)
                        Text("Connected")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())

                    if isConnectMode {
                        Text("Apple Calendar")
                            .font(.system(size:24, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            TextField("Calendar name", text: $calendarName)
                                .autocapitalization(.none)
                                .padding(12)
                                .background(Color(.init(white: 0, alpha: 0.05)))
                            Button {
                                handleAppleCal ()
                            } label: {
                                Text("⏎")
                                    .foregroundColor(.white)
                                    .padding(12)
                                    .font(.system(size:14, weight: .semibold))
                            }.background(Color.blue)
                        }
                        
                        Text("Google Calendar")
                            .font(.system(size:24, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            TextField("Calendar link", text: $calendarLink)
                                .autocapitalization(.none)
                                .padding(12)
                                .background(Color(.init(white: 0, alpha: 0.05)))
                            Button {
                                handleGoogleCal ()
                            } label: {
                                Text("⏎")
                                    .foregroundColor(.white)
                                    .padding(12)
                                    .font(.system(size:14, weight: .semibold))
                            }.background(Color.blue)
                        }
                    } else {
                        Text("Currently connected to:")
                            .font(.system(size:24, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack {
                            Text("Calendar name")
                                .font(.system(size:20, weight: .light))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Button {
                                handleRefresh ()
                            } label: {
                                Text("Refresh")
                                    .foregroundColor(.white)
                                    .padding(12)
                                    .font(.system(size:14, weight: .semibold))
                            }.background(Color.blue)
                        }
                    }
                }.padding()
            }
            .navigationTitle("Calendars")
//            .background(Color(.init(white: 0, alpha: 0.05)))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    private func handleAppleCal () {
        print("Should register new Apple calendar")
    }
    private func handleGoogleCal () {
        print("Should register new Google calendar link")

//        Get current user id
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
// //     API call
//        Prepare json data which will be our request body (uid and url)
        let json = ["uid": uid,"url": self.calendarLink]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
//        post request
        let url = URL(string: "http://127.0.0.1:5000/firestore/events")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
//        do not currently have an error message
    }
        
    private func handleRefresh () {
        print("Should refresh calendar connection")
    }
}

struct CalendarsView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarsView()
    }
}
