//
//  Extensions.swift
//  AnnualPlan
//
//  Created by 이용석 on 2021/10/24.
//

import SwiftUI

final class SharedClass: ObservableObject {
    @Published var currentMonth: Int = 0
    
    func add() {
        self.currentMonth += 1
    }
    
    func sub() {
        self.currentMonth -= 1
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: currentMonth, to: Date()) else { return Date() }
        return currentMonth
    }

    func extractDate() ->[DayValue] {
        // 현재 달 얻기
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        // days: [DateValue]
        var days = currentMonth.getAllDate().compactMap { date -> DayValue in
            let day = calendar.component(.day, from: date)
            return DayValue(day: day, index: -1, date: (date + 84600)) // 86400초 = 1일
        }
        
        //offset day index
        let firstWeekDay = calendar.component(.weekday, from: days.first?.date ?? Date().toLocalTime())
        for i in 0..<firstWeekDay - 1 {
            days.insert(DayValue(day: -1, index: i, date: Date().toLocalTime()), at: 0)
        }
//        for _ in 0..<firstWeekDay - 1 {
//            days.insert(DayValue(day: -1, date: Date().toLocalTime()), at: 0)
//        }
    
        return days
    }
}


extension Date {
    
    func toString( dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
    
    func toStringKST( dateFormat format: String ) -> String {
        return self.toString(dateFormat: format)
    }
    
    func toStringUTC( dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    func getAllDate() -> [Date] {
        let calendar = Calendar.current
        // 시작일 얻음
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        //let firstDay = Calendar.current.component(.weekday, from: startDate)
        //range.removeLast()
        //데이트 얻음
        //debugPrint(startDate)
        return range.compactMap{ day -> Date in
            //debugPrint(day)
            let newDate = calendar.date(bySetting: .day, value: day, of: startDate)!
            return newDate
            //return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
