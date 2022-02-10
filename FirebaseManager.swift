//
//  FirebaseManager.swift
//  calendar-buddy
//
//  Created by Maria Obregon Garcia on 2/9/22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class FirebaseManager: NSObject {

    let auth: Auth
    let storage: Storage
    let firestore: Firestore

    static let shared = FirebaseManager()

    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()

        super.init()
    }
}
