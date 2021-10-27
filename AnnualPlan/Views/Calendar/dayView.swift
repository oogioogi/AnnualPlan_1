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
                        .foregroundColor(shared.isSameDay(date1: task.taskDate, date2: currentDate) ? .white : colorSelect(yoilIndex: value.index))
                        .frame(maxWidth: .infinity)
                    //Text("\(value.index)").font(.caption2).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/) // 인덱스 추가분
                    Spacer()
                    Circle()
                        .fill(shared.isSameDay(date1: task.taskDate, date2: currentDate) ? .white : Color.pink)
                        .frame(width: 8, height: 8)
                }else {
                    Text("\(value.day)")
                        .font(.title3).bold()
                        .foregroundColor(shared.isSameDay(date1: value.date, date2: currentDate) ? .white : colorSelect(yoilIndex: value.index))
                        .frame(maxWidth: .infinity)
                    //Text("\(value.index)").font(.caption2).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
            }
        }
        .padding(.vertical, 9)
        .frame(height: 60, alignment: .top)
    }
//  요일 인덱스에 따라 토/일 색갈 지정
    func colorSelect(yoilIndex: Int) -> Color {
        switch yoilIndex {
        case 1:
            return Color.red
        case 7:
            return Color.blue
        default:
            return Color.primary
        }
    }
}

struct dayView_Previews: PreviewProvider {
    @StateObject static var taskClass = TaskClass()
    @StateObject static var shared = SharedClass()
    @State static var currentDate = Date().toLocalTime()
    static var previews: some View {
        Home()
            .environmentObject(taskClass)
            .environmentObject(shared)
    }
}

