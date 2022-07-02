//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Salima O. on 01/07/2022.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
