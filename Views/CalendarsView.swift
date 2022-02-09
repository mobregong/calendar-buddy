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
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Picker(selection: $isConnectMode, label: Text("Picker here")) {
                        Text("Connect")
                            .tag(true)
                        Text("Settings")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Text("New Calendar")
                        .font(.system(size:28, weight: .semibold))
//                            .font(.system(Font.TextStyle))
//                            .padding(.trailing, 100)
//                            style="text-align:left"
//                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        TextField("Calendar link", text: $calendarLink)
                            .autocapitalization(.none)
                            .padding(12)
                            .background(Color(.init(white: 0, alpha: 0.05)))
                        Button {
                            handleAction ()
                        } label: {
                            Text("⏎")
                                .foregroundColor(.white)
                                .padding(12)
                                .font(.system(size:14, weight: .semibold))
                        }.background(Color.blue)
                    }
                }.padding()
            }
            .navigationTitle("Calendars")
//            .background(Color(.init(white: 0, alpha: 0.05)))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    private func handleAction () {
        print("Should register new calendar link")
    }
}

struct CalendarsView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarsView()
    }
}
