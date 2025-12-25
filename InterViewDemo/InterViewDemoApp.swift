//
//  InterViewDemoApp.swift
//  InterViewDemo
//
//  Created by Nitin Tandon on 25/12/25.
//

import SwiftUI

@main
struct InterViewDemoApp: App {
    let appDependency = AppDependency()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModelUserList: appDependency.makeVM())
        }
    }
}
