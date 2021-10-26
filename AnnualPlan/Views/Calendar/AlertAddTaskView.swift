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
                Text(currentDate.toString(dateFormat: "YYYY/MM/dd"))
                    .font(.title2)
                    .bold()
            }.padding(.horizontal)
            
            VStack{
                Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                    Text(vacation[0]).bold()
                }
                Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                    Text(vacation[1]).bold()
                }
            }.padding()
            
            HStack(spacing: 30) {
                Button(action: {
                    self.isAlert.toggle()
                }, label: {
                    Image(systemName: "hand.thumbsup.fill")
                        .font(.title)
                        .foregroundColor(.primary)
                })
                Button(action: {
                    self.isAlert.toggle()
                }, label: {
                    Image(systemName: "hand.thumbsdown.fill")
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
    static var previews: some View {
        AlertAddTaskView(isAlert: .constant(true), currentDate: .constant(Date()))
    }
}
