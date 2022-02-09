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
//            HStack {
//                Image(systemName: "person")
//                    .foregroundColor(.gray)
//                    .imageScale(.large)
//                Text("Events")
//                    .foregroundColor(.gray)
//                    .font(.headline)
//            }
//            .padding(.top, 100)
//            HStack {
//                Image(systemName: "envelope")
//                    .foregroundColor(.gray)
//                    .imageScale(.large)
//                Text("Messages")
//                    .foregroundColor(.gray)
//                    .font(.headline)
//            }
//                .padding(.top, 30)
//            HStack {
//                Image(systemName: "gear")
//                    .foregroundColor(.gray)
//                    .imageScale(.large)
//                Text("Settings")
//                    .foregroundColor(.gray)
//                    .font(.headline)
//            }
//            .padding(.top, 30)
//            Spacer()
            
            NavigationLink(destination: CalendarsView()) {
                Text("Calendars")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 100)
            NavigationLink(destination: EventsView()) {
                Text("Events")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 30)
            NavigationLink(destination: CategoriesView()) {
                Text("Categories")
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
