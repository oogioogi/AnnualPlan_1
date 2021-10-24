//
//  dayView.swift
//  AnnualPlan
//
//  Created by 이용석 on 2021/10/24.
//

import SwiftUI

struct dayView: View {
    @EnvironmentObject var taskClass: TaskClass
    @EnvironmentObject var shared: SharedClass
    @Binding var currentDate: Date
    var value: DayValue
    
    var body: some View {
        VStack {
            if value.day != -1 {
                if let task = taskClass.tasks.first(where: { taskDetail in
                    return shared.isSameDay(date1: taskDetail.taskDate, date2: value.date)
                }) {
                    Text("\(value.day)")
                        .font(.title3).bold()
                        //.foregroundColor(colorSelect(task: task, value: value)) -- 미완성
                        .foregroundColor(shared.isSameDay(date1: task.taskDate, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    Text("\(value.index)").font(.caption2).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Circle()
                        .fill(shared.isSameDay(date1: task.taskDate, date2: currentDate) ? .white : Color.pink)
                        .frame(width: 8, height: 8)
                }else {
                    Text("\(value.day)")
                        .font(.title3).bold()
                        //.foregroundColor(colorSelect(value: value)) -- 미완성
                        .foregroundColor(shared.isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    Text("\(value.index)").font(.caption2).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
            }else {
                Text("\(value.day)")
                    .font(.title3).bold()
                    //.foregroundColor(colorSelect(value: value)) -- 미완성
                    .foregroundColor(shared.isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                    .frame(maxWidth: .infinity)
                Text("\(value.index)").font(.caption2).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Spacer()
            }
        }
        .padding(.vertical, 9)
        .frame(height: 60, alignment: .top)
    }
// -- 미완성 :: 토일 색갈 구분
//    func colorSelect(task: TaskDetail, value: DayValue) -> Color {
//        if (value.day % 7) == 0 {
//            return Color.blue
//        } else if value.day == 1 || value.day == 8 || value.day == 15 || value.day == 22 || value.day == 29 || value.day == 36 {
//            return Color.red
//        }
//        if shared.isSameDay(date1: task.taskDate, date2: currentDate) {
//            return Color.white
//        }else {
//            return Color.primary
//        }
//    }
//
//    func colorSelect(value: DayValue) -> Color {
//        if (value.day % 7) == 0 {
//            return Color.blue
//        } else if value.day == 1 || value.day == 8 || value.day == 15 || value.day == 22 || value.day == 29 || value.day == 36 {
//            return Color.red
//        }
//        if shared.isSameDay(date1: value.date, date2: currentDate) {
//            return Color.white
//        }else {
//            return Color.primary
//        }
//    }
}

struct dayView_Previews: PreviewProvider {
    @StateObject static var taskClass = TaskClass()
    @StateObject static var shared = SharedClass()
    @State static var currentDate = Date().toLocalTime()
    static var previews: some View {
        Home()
            .environmentObject(taskClass)
            .environmentObject(shared)
//        dayView(currentDate: .constant(Date()), value: DayValue(day: 15, date: Date().toLocalTime()))
//            .environmentObject(taskClass)
//            .environmentObject(shared)
    }
}

