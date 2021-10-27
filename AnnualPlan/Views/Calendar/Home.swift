//
//  Home.swift
//  AnnualPlan
//
//  Created by 이용석 on 2021/10/24.
//  @State var currentDate: String = Date().toString(dateFormat: "yyyy_MM_dd")

import SwiftUI

struct Home: View {
    @EnvironmentObject var taskClass: TaskClass
    @State var currentDate: Date = Date().toLocalTime()
    @EnvironmentObject var shared: SharedClass
    @State var isAlert: Bool = false
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                VStack {
                    CalendarPicker(currentDate: $currentDate, isAlert: $isAlert)
                    Spacer()
                    TaskDetailView() // 태스크 상세뷰
                    Spacer()
                    currentDateFunc(date: currentDate).edgesIgnoringSafeArea(.bottom)
                }.blur(radius: isAlert ? 3.0 : 0) // blur 기능
                //Text("long click")
                if self.isAlert {
                    // ** 1. 개선 필요 :: 선택 영역 이외의 곳에서 롱터치 하면 얼럿 창이 안뜨게 한다
                    AlertAddTaskView(isAlert: $isAlert, currentDate: $currentDate)
                    
                }
            }
        }
    }
    
    // Task Detail View
    @ViewBuilder
    func TaskDetailView() -> some View {
        VStack {
            Text("Task View")
                .font(.title2).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            if let taskDetail = taskClass.tasks.first(where: { detail  in
                shared.isSameDay(date1: detail.taskDate, date2: currentDate)
            })
            {
                ForEach(taskDetail.task) { task in
                    VStack(alignment: .leading, spacing: 10) {
                        // for custom Time
                        Text(task.time.addingTimeInterval(TimeInterval(CGFloat.random(in: 0...5000))), style: .time)
                            .font(.title2).bold()
                        Text(task.title)
                            .font(.title3).bold()
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        Color.purple
                            .opacity(0.5)
                            .cornerRadius(10)
                    )
                }
            }else {
                Text("No Task Found")
            }
        }
        .padding()
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
