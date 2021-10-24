//
//  CalendarPicker.swift
//  AnnualPlan
//
//  Created by 이용석 on 2021/10/24.
//

import SwiftUI

struct CalendarPicker: View {
    @EnvironmentObject var taskClass: TaskClass
    @EnvironmentObject var shared: SharedClass
    @Binding var currentDate: Date

    var body: some View {
    
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(extractDate()[0])
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(extractDate()[1])
                        .font(.title).bold()
                }
                Spacer()
                Button(action: {
                    shared.sub()
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                })
                Button(action: {
                    shared.add()
                }, label: {
                    Image(systemName: "chevron.right")
                        .font(.title)
                })
            }.padding(.horizontal)  // top title
    
            calendarHeader() // 요일
            // 날짜
            let colums = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: colums, spacing: 15) {
                ForEach(shared.extractDate()) {  value in
                    dayView(currentDate: $currentDate, value: value)
                        .background(
                            Capsule()
                                .fill(Color.pink)
                                .padding(.horizontal, 8)
                                .opacity(shared.isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                        )
                        .onTapGesture {
                            currentDate = value.date
                            debugPrint(value.date)
                        }
                }
                
            }
        }
        .onChange(of: shared.currentMonth, perform: { _ in
            currentDate = shared.getCurrentMonth()
        })
        .onAppear(perform: {
            currentDate = shared.getCurrentMonth()
        })
    }
    
    func extractDate() -> [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "YYYY MMMM"
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    
}

// - calendarHeader() - 칼랜더 헤더 일~토 요일 날짜 출력
@ViewBuilder
func calendarHeader() -> some View {
    //요일 날짜
    let days: [String] = ["일","월","화","수","목","금","토"]
    
    //요일 날짜
    HStack(spacing: 0) {
        ForEach(days, id: \.self) { day in
            Text("\(day)")
                .font(.callout)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
        }
    }
}

struct CalendarPicker_Previews: PreviewProvider {
    @StateObject static var taskClass = TaskClass()
    @StateObject static var shared = SharedClass()
    static var previews: some View {
        Home()
            .environmentObject(taskClass)
            .environmentObject(shared)
    }
}
