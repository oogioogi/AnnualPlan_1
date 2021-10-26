//
//  AlertAddTaskView.swift
//  AnnualPlan
//
//  Created by 이용석 on 2021/10/25.
//

import SwiftUI

struct AlertAddTaskView: View {
    @Binding var isAlert: Bool
    @Binding var currentDate: Date
    
    var vacation: [String] = ["연차", "월차"]
    var body: some View {
        VStack{
            HStack(spacing: 20) {
                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    .font(.title)
                    .foregroundColor(.primary)
                Text(currentDate.toString(dateFormat: "YYYY년 MM월 dd일"))
            }.padding(.horizontal)
            VStack{
                Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                    Text(vacation[0])
                }
                Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                    Text(vacation[1])
                }
            }
            
            Button(action: {
                self.isAlert = false
            }, label: {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.primary)
            })
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray)
        .cornerRadius(20)
    }
}

struct AlertAddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AlertAddTaskView(isAlert: .constant(true), currentDate: .constant(Date()))
    }
}
