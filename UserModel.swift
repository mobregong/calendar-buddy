//
//  UserModel.swift
//  calendar-buddy
//
//  Created by Maria Obregon Garcia on 2/9/22.
//

import SwiftUI

struct CalUser {
    let uid, email: String
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
    }
}

class UserModel: ObservableObject {

    @Published var errorMessage = ""
    @Published var calUser: CalUser?
    
    init() {
        
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
        }
        
        fetchCurrentUser()
    }

    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                print("Failed to fetch current user", error)
                return
            }
            
            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found"
                return
            }
//            let uid = data["uid"] as? String ?? ""
//            let email = data["email"] as? String ?? ""
////            let profileImageUrl = data["profileImageUrl"] as? String ?? ""
////            self.chatUser = ChatUser(uid: uid, email: email, profileImageUrl: profileImageUrl)
//            self.calUser = CalUser(uid: uid, email: email)
            
            self.calUser = .init(data: data)
        }
    }
    
    @Published var isUserCurrentlyLoggedOut = false
    
    func handleSignOut() {
        isUserCurrentlyLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
    }
    
}
