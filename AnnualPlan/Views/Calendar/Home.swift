//
//  Home.swift
//  AnnualPlan
//
//  Created by 이용석 on 2021/10/24.
//  @State var currentDate: String = Date().toString(dateFormat: "yyyy_MM_dd")

import SwiftUI

struct Home: View {
   
    @State var currentDate: Date = Date().toLocalTime()
    @EnvironmentObject var shared: SharedClass
    
    var body: some View {
        VStack {
            CalendarPicker(currentDate: $currentDate)
            Spacer()
            currentDateFunc(date: currentDate).edgesIgnoringSafeArea(.bottom)
        }
    }

}

@ViewBuilder
func currentDateFunc(date: Date) -> some View {
    Text(date.description)
        .frame(maxWidth: .infinity, maxHeight: 40)
        .font(.title2)
}

struct Home_Previews: PreviewProvider {
    @StateObject static var taskClass = TaskClass()
    @StateObject static var shared = SharedClass()
    static var previews: some View {
        Home()
            .environmentObject(taskClass)
            .environmentObject(shared)
    }
}
