//
//  ReadMeApp.swift
//  ReadMe
//
//  Created by Ruhullah Rahimov on 11.09.21.
//

import SwiftUI

@main
struct ReadMeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Library())
        }
    }
}
