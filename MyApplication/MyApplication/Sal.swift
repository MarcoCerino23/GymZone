//
//  Sal.swift
//  GymZone
//
//  Created by Marco Cerino on 20/03/23.
//
//
//  Download.swift
//  SaaSDashboard
//
//  Created by Shameem Reza on 15/3/22.
//

import SwiftUI

// MARK: SALES MODEL

struct Sale: Identifiable {
    var id = UUID().uuidString
    var sales: CGFloat
    var weekDay: String
}

var sales: [Sale] = [
    Sale(sales: 500, weekDay: "Sun"),
    Sale(sales: 240, weekDay: "Mon"),
    Sale(sales: 350, weekDay: "Tue"),
    Sale(sales: 430, weekDay: "Wed"),
    Sale(sales: 690, weekDay: "Thu"),
    Sale(sales: 540, weekDay: "Fri"),
    Sale(sales: 920, weekDay: "Sat"),
]
/*struct Calor: Identifiable{
    var id = UUID().uuidString
    var cal: Double
    var weekDay: String
    //var animate: Bool = false
}*/
var calors: [Calor] = [
    Calor(cal: 1900, weekDay: "2016-04-14T10:44:00+0000"),
    Calor(cal: 1100, weekDay: "2016-04-15T10:44:00+0000"),
    Calor(cal: 1200, weekDay: "2016-04-16T10:44:00+0000"),
    Calor(cal: 1300, weekDay: "2016-04-17T10:44:00+0000"),
    Calor(cal: 2000, weekDay: "2016-04-18T10:44:00+0000"),
    Calor(cal: 1700, weekDay: "2016-04-19T10:44:00+0000"),
    Calor(cal: 2200, weekDay: "2016-04-20T10:44:00+0000"),
]
var calors2: [Calor] = [
    Calor(cal: 1400, weekDay: "2023-04-10T10:44:00+0000"),
    Calor(cal: 1200, weekDay: "2023-04-11T10:44:00+0000"),
    Calor(cal: 1600, weekDay: "2023-04-12T10:44:00+0000"),
    Calor(cal: 1700, weekDay: "2023-04-13T10:44:00+0000"),
    Calor(cal: 2200, weekDay: "2023-04-14T10:44:00+0000"),
    Calor(cal: 1700, weekDay: "2023-04-15T10:44:00+0000"),
    Calor(cal: 1200, weekDay: "2023-04-16T10:44:00+0000"),
]

enum City{
    case cupertino
    case sf
}
