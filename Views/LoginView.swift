//
//  ContentView.swift
//  calendar-buddy
//
//  Created by Maria Obregon Garcia on 1/26/22.
//

import SwiftUI
import Firebase

//class FirebaseManager: NSObject {
//    let auth: Auth
//    static let shared = FirebaseManager()
//    override init() {
//        FirebaseApp.configure()
//        self.auth = Auth.auth()
//        super.init()
//    }
//}

struct LoginView: View {
    
    let didCompleteLoginProcess: () -> ()
    
    @State private var isLoginMode = false
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack(spacing: 16){
                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
                        Text("Log in")
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
                    Text(self.loginStatusMessage)
                        .foregroundColor(.blue)
                }
                .padding()
            }
//            .navigationTitle(isLoginMode ? "Log in" : "Create account")
            .navigationTitle("Calendar-buddy")
            .background(Color(.init(white: 0, alpha: 0.05)).ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    private func handleAction() {
        if isLoginMode {
            loginUser()
//            print("Should log into Firebase with existing credentials")
        } else {
            createNewAccount()
//            print("Register a new account inside of Firebase Auth")
        }
    }
    
    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to login user:", err)
                self.loginStatusMessage = "Failed to login user: \(err)"
                return
            }

            print("Successfully logged in as user: \(result?.user.uid ?? "")")

            self.loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
            
            self.didCompleteLoginProcess()
        }
    }
    
    @State var loginStatusMessage = ""
    
    private func createNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) {result, err in
            if let err = err {
                print("Failed to create user", err)
                self.loginStatusMessage = "Failed to create user: \(err)"
                return
            }
            print("Successfully created user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Succesfully created user: \(result?.user.uid ?? "")"
            self.storeUserInformation()
        }
    }
    
    private func storeUserInformation() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userData = ["email": self.email, "uid": uid]
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    self.loginStatusMessage = "\(err)"
                    return
                }
                print("Success")
                
                self.didCompleteLoginProcess()
            }
//        FirebaseManager.shared.firestore.collection("users").document(uid).collection("user_info")
//            .document("events").setData(["did this work":"yes"]) { err in
//                if let err = err {
//                    print(err)
//                    self.loginStatusMessage = "\(err)"
//                    return
//                }
//                print("Success")
//
//                self.didCompleteLoginProcess()
//            }
    }
    
}

struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        LoginView(didCompleteLoginProcess: {
            
        })
    }
}
