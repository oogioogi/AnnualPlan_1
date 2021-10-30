//
//  AlertAddTaskView.swift
//  AnnualPlan
//
//  Created by 이용석 on 2021/10/25.
//

import SwiftUI

struct AlertAddTaskView: View {
    @EnvironmentObject var taskClass: TaskClass
    @EnvironmentObject var shared: SharedClass
    @Binding var isAlert: Bool
    @Binding var currentDate: Date
    
    var vacation: [String] = ["연차", "월차"]
    var body: some View {
        
        VStack {
            topTiileView() // top View
            middleView()   // middle View
            bottomView()   // bottom View
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.5)
        .padding()
        .background(Color.yellow)
        .cornerRadius(20)
        .shadow(color: .gray, radius: 3, x: 3, y: 3)
    }
    
@ViewBuilder
    // top View
    func topTiileView() -> some View {
        ZStack(alignment: .center) {
            GeometryReader { geometry in
                Text(currentDate.toString(dateFormat: "YYYY/MM/dd"))
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                Button(action: {
                    self.isAlert.toggle()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.purple)
                        .font(.title2)
                }).offset(x: geometry.size.width, y: -(geometry.size.height * 0.5))
            }

        }
        .frame(height: 25)
        .padding(.horizontal)
    }
    // middle View
//    func middleView() -> some View {
//        VStack{
//            if let taskDetail = taskClass.tasks.first(where: { detail in
//                shared.isSameDay(date1: detail.taskDate, date2: currentDate)
//            }) {
//                ForEach(taskDetail.task) { task in
//                    VStack(alignment: .center, spacing: 10) {
//                        Text(task.title)
//                            .font(.caption).bold()
//                    }
//                    .padding(.vertical, 10)
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    .background(
//                        Color.purple
//                            .opacity(0.5)
//                            .cornerRadius(10)
//                    )
//                    .onTapGesture {
//                        debugPrint("clicked tap")
//                    }
//                }
//            }else {
//                Text("Task Not Found")
//                    .padding(.vertical, 10)
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    .background(
//                        Color.purple
//                            .opacity(0.5)
//                            .cornerRadius(10)
//                    )
//            }
//        }.padding()
//    }
    // middle View
    func middleView() -> some View {
        List {
            if let taskDetail = taskClass.tasks.first(where: { detail in
                shared.isSameDay(date1: detail.taskDate, date2: currentDate)
            }) {
                ForEach(taskDetail.task) { task in
                    Text(task.title)
                        .font(.caption).bold()
                }.onDelete(perform: delete)
            }else {
                Text("Task Not Found")
                    .font(.caption).bold()
            }
        }
        .listStyle(SidebarListStyle())
        .frame(height: UIScreen.main.bounds.height * 0.15)
        .cornerRadius(15.0)
        
    }
    //
    /*
     CarouselListStyle
     DefaultListStyle
     EllipticalListStyle
     GroupedListStyle
     InsetGroupedListStyle
     InsetListStyle
     PlainListStyle
     SidebarListStyle
     */
    // 리스트 왼쪽으로 밀어서 삭제 함
    func delete(at offset: IndexSet) {
        let removeTaskIndex = taskClass.tasks.firstIndex { tasked in
            tasked.taskDate == currentDate
        }
        if removeTaskIndex != nil {
            debugPrint(removeTaskIndex?.description as Any) // debug
            debugPrint(offset.first as Any) // debug
            let taskCount = taskClass.tasks[removeTaskIndex!].task.count
            if taskCount > 1 {
                //taskClass.tasks[removeTaskIndex!].task.remove(at: taskCount - 1)
                taskClass.tasks[removeTaskIndex!].task.remove(at: offset.first!)
            }else {
                taskClass.tasks.remove(at: removeTaskIndex!)
            }
            
        }
    }
    // bottom View
    func bottomView() -> some View {
        HStack(spacing: 30) {
            // task appending
            Button(action: {
                if let appendTaskIndex = taskClass.tasks.firstIndex(where: { tasked in
                    tasked.taskDate == currentDate
                }) {
                    debugPrint(appendTaskIndex)
                    debugPrint(currentDate)
                    taskClass.tasks[appendTaskIndex].task.append(Task(title: "New Annul"))
                   
                }else {
                    debugPrint(currentDate)
                    taskClass.tasks.append(TaskDetail(task: [Task(title: "Annul")], taskDate: currentDate))
                }
                //동일 날짜는 Task만을 추가 한다
            }, label: {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundColor(.primary)
            })
            
            // task delete
            Button(action: {
                let removeTaskIndex = taskClass.tasks.firstIndex { tasked in
                    tasked.taskDate == currentDate
                }

                if removeTaskIndex != nil {
                    debugPrint(removeTaskIndex?.description as Any)
                    let taskCount = taskClass.tasks[removeTaskIndex!].task.count
                    if taskCount > 1 {
                        taskClass.tasks[removeTaskIndex!].task.remove(at: taskCount - 1)
                    }else {
                        taskClass.tasks.remove(at: removeTaskIndex!)
                    }
                    
                }
            }, label: {
                Image(systemName: "minus.circle.fill")
                    .font(.title)
                    .foregroundColor(.primary)
            })
        }
    }
}

struct AlertAddTaskView_Previews: PreviewProvider {
    @StateObject static var taskClass = TaskClass()
    @StateObject static var shared = SharedClass()
    
    static var previews: some View {
        AlertAddTaskView(isAlert: .constant(true), currentDate: .constant(Date()))
            .environmentObject(taskClass)
            .environmentObject(shared)
    }
}
