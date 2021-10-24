//
//  AnnualPlanApp.swift
//  AnnualPlan
//
//  Created by 이용석 on 2021/10/24.
//

import SwiftUI

@main
struct AnnualPlanApp: App {
    
    @StateObject var taskClass = TaskClass()
    @StateObject var shared = SharedClass()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(taskClass)
                .environmentObject(shared)
        }
    }
}
