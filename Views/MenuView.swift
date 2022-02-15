//
//  MenuView.swift
//  calendar-buddy
//
//  Created by Maria Obregon Garcia on 2/8/22.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            NavigationLink(destination: CalendarsView()) {
                Text("Calendars")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 100)
//            NavigationLink(destination: EventsView()) {
//                Text("Events")
//                    .foregroundColor(.gray)
//                    .font(.headline)
//            }
            .padding(.top, 30)
            NavigationLink(destination: RemindersView()) {
                Text("Reminders")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 30)
            NavigationLink(destination: SettingsView()) {
                Text("Settings")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 30)
            Spacer()
        }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 32/255, green: 32/255, blue: 32/255))
            .edgesIgnoringSafeArea(.all)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
