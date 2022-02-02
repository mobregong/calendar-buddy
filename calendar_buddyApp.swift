//
//  calendar_buddyApp.swift
//  calendar-buddy
//
//  Created by Maria Obregon Garcia on 1/26/22.
//

import SwiftUI
import UIKit
import Firebase

@main
struct calendar_buddyApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}

class FirebaseManager: NSObject {
    let auth: Auth
    static let shared = FirebaseManager()
    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        super.init()
    }
}

////@UIApplicationMain
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//  var window: UIWindow?
//
//  func application(_ application: UIApplication,
//    didFinishLaunchingWithOptions launchOptions:
//                   [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//    FirebaseApp.configure()
//
//    return true
//  }
//}
