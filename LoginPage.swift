//
//  ContentView.swift
//  calendar-buddy
//
//  Created by Maria Obregon Garcia on 1/26/22.
//

import SwiftUI

struct LoginPage: View {
    
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack(spacing: 16){
                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
                        Text("Login")
                            .tag(true)
                        Text("Create account")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
 
                        SecureField("Password", text: $password)
                    }
                    .padding(12)
                    .background(Color.white)
                    
                    Button {
//                        executes this code
                        handleAction()
                    } label: {
                        HStack {
                            Spacer()
                            Text(isLoginMode ? "Log in" : "Create account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                    }
                }
                .padding()
            }
            .navigationTitle(isLoginMode ? "Log in" : "Create account")
            .background(Color(.init(white: 0, alpha: 0.05)).ignoresSafeArea())
        }
    }
    private func handleAction() {
        if isLoginMode {
            print("Should log into Firebase with existing credentials")
        } else {
            print("Register a new account inside of Firebase Auth")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
