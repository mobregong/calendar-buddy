//
//  EventsMainView.swift
//  calendar-buddy
//
//  Created by Maria Obregon Garcia on 2/2/22.
//

import SwiftUI

struct EventsView: View {
    
    enum Event: String, CaseIterable, Identifiable {
        case next, today, models
        var id: Self { self }
    }
    @State private var EventMode: Event = .next
    
    var body: some View {
//        NavigationView {
            ScrollView {
                VStack(spacing: 16){
                    Picker("Mode", selection: $EventMode){
                        Text("Next").tag(Event.next)
                        Text("Today").tag(Event.today)
                        Text("Models").tag(Event.models)
                    }.pickerStyle(SegmentedPickerStyle())
                }
//            }.navigationTitle("Calendar-buddy")
//            .background(Color(.init(white: 0, alpha: 0.05)).ignoresSafeArea())
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct EventsMainView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}

