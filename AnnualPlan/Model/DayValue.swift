//
//  DateValue.swift
//  AnnualPlan
//
//  Created by 이용석 on 2021/10/24.
//

import SwiftUI

struct DayValue: Identifiable {
    var id: String = UUID().uuidString
    var day: Int
    var index: Int // 요일 인덱스
    var date: Date
}

struct MonthValue: Identifiable {
    var id: String = UUID().uuidString
    var months: [DayValue]
}

struct YearValue: Identifiable {
    var id: String = UUID().uuidString
    var years: [MonthValue]
}
