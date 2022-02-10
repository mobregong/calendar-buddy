//
//  SettingsView.swift
//  calendar-buddy
//
//  Created by Maria Obregon Garcia on 2/8/22.
//

import SwiftUI

struct SettingsView: View {
    
    @State var shouldShowLogOutOptions = false
    @ObservedObject private var um = UserModel()

    private var customNavBar: some View {

        HStack(spacing: 16) {

            VStack(alignment: .leading, spacing: 4) {
                Text("Settings")
                    .font(.system(size: 24, weight: .bold))
            }

            Spacer()
        }
    }

    var body: some View {
        NavigationView {

            VStack {
                customNavBar
                HStack {
                    Text("Log out (click on gear)")
                        .foregroundColor(.black)
                    Spacer()
                    
//                    Button {
//                        shouldShowLogOutOptions.toggle()
//                    } label: {
//                        Image(systemName: "gear")
//                            .font(.system(size: 24, weight: .bold))
//                            .foregroundColor(Color(.label))
//                    }
//                    .padding()
//                    .actionSheet(isPresented: $shouldShowLogOutOptions) {
//                        .init(title: Text("Settings"), message: Text("Are you sure?"), buttons: [
//                            .destructive(Text("Sign Out"), action: {
//                                print("handle sign out")
//                                um.handleSignOut()
//                            }),
//                                .cancel()
//                        ])
//                    }
//                    .fullScreenCover(isPresented: $um.isUserCurrentlyLoggedOut, onDismiss: nil) {
//                        LoginView(didCompleteLoginProcess: {
//                            self.um.isUserCurrentlyLoggedOut = false
//                        })
//                    }
                }
//                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                
                
            }
//            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
//            .navigationBarHidden(true)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
