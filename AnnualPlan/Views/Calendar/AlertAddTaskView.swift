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
        VStack{
            HStack(spacing: 20) {
                Text(currentDate.toString(dateFormat: "YYYY/MM/dd"))
                    .font(.title2)
                    .bold()
            }.padding(.horizontal)
            
            VStack{
                if let taskDetail = taskClass.tasks.first(where: { detail in
                    shared.isSameDay(date1: detail.taskDate, date2: currentDate)
                }) {
                    ForEach(taskDetail.task) { task in
                        VStack(alignment: .center, spacing: 10) {
                            Text(task.title)
                                .font(.caption).bold()
                        }
                        .padding(.vertical, 10)
                        //.padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(
                            Color.purple
                                .opacity(0.5)
                                .cornerRadius(10)
                        )
                    }
                }else {
                    Text("Task Not Found")
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(
                            Color.purple
                                .opacity(0.5)
                                .cornerRadius(10)
                        )
                }
                
                
//                Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
//                    Text(vacation[0]).bold()
//                }
//                Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
//                    Text(vacation[1]).bold()
//                }
            }.padding()
            
            HStack(spacing: 30) {
                Button(action: {
                    self.isAlert.toggle()
                }, label: {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.primary)
                })
                Button(action: {
                    self.isAlert.toggle()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.primary)
                })
            }
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.5)
        .padding()
        .background(Color.gray)
        .cornerRadius(20)
        .shadow(color: .black, radius: 5, x: 5, y: 5)
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
