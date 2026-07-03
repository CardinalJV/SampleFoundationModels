//
//  SampleFoundationModelsApp.swift
//  SampleFoundationModels
//
//  Created by Viranaiken Jessy on 04/12/25.
//

import SwiftUI

@main
struct SampleFoundationModelsApp: App {
    
    @State private var smartController = SmartController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environment(self.smartController)
    }
}
