//
//  Task.swift
//  AnnualPlan
//
//  Created by 이용석 on 2021/10/24.
//

import SwiftUI

struct Task: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var time: Date = Date().toLocalTime()
}

struct TaskDetail: Identifiable {
    var id: String = UUID().uuidString
    var task: [Task]
    var taskDate: Date
}

// sample task testing
func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    return date ?? Date()
}

class TaskClass: ObservableObject {
    
    @Published var tasks: [TaskDetail] = [
        TaskDetail(task: [
            Task(title: "연차"),
            Task(title: "병원")
        ], taskDate: getSampleDate(offset: 1)),
        TaskDetail(task: [
            Task(title: "월차"),
            Task(title: "관공서")
        ], taskDate: getSampleDate(offset: 2)),
        TaskDetail(task: [
            Task(title: "반차"),
            Task(title: "병문안")
        ], taskDate: getSampleDate(offset: 3))
    ]
}


