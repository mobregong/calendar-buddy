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
