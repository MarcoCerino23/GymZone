//
//  Grafico.swift
//  GymZone
//
//  Created by Marco Cerino on 22/03/23.
//

import SwiftUI
import SwiftUICharts
import Charts
import CoreML

struct GraficoView: View {
    //    let dateArray: [Date] = GetXAxisLabels(min: Date.now, max: Date.now, numYears: 3)
    
    let days: [String] = ["Lun", "Mar", "Mer", "Gio", "Ven"]
    var body: some View {
        VStack {
            LineView(data: [1400, 1274, 1506, 2308, 1000],title: "Chart", legend: "FullScreen", style: ChartStyle(backgroundColor: .white, accentColor: .blue, gradientColor: GradientColor(start: .red, end: .blue), textColor: .blue, legendTextColor: .red, dropShadowColor: .brown), valueSpecifier: "%.0f")
            
                
//                .chartXAxisLabel(position: .automatic, alignment: .center, spacing: 25) {
//                    Text("")
            
//                        .chartXAxis {
//                            AxisMarks (values: [Date.now,Date.distantFuture]) { value in
//                                AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5))
//                                    .foregroundStyle(Color.green)
//                                AxisTick(centered: true, length: 10 , stroke: StrokeStyle(lineWidth: 0.5))
//                                    .foregroundStyle(Color.gray)
//                            }
//                        }
//                        .chartXAxis {
//                            AxisMarks(position: .bottom, values: .stride(by: .day, count: 3)) { _ in
//                                            AxisGridLine()
//                                            AxisValueLabel(format: .dateTime.hour(), anchor: .top)
//                                        }
//                                    }
                    //.padding()
                    //
                    //            BarChartView(data: ChartData(values: [
                    //                ("Mon",1300),
                    //                ("Tue",1200),
                    //                ("Wed",1500),
                    //                ("Thu",1600),
                    //                ("Fri",1800),
                    //                ("Sat",2000),
                    //                ("Sun",1400)
                    //            ]),
                    //                         title: "Bar Chart",legend: "OKOKOK", form: ChartForm.extraLarge)
                    //            .frame(width: 50,height:90 ,alignment: .bottom)
                    
                    //            LineChartView(data: [1400,1700,1900,2000,2350], title: "Chart", style: ChartStyle(backgroundColor: .white, accentColor: .blue, gradientColor: GradientColor(start: .red, end: .blue), textColor: .black, legendTextColor: .red, dropShadowColor: .brown))
                    //                .padding()
                    
                //}
            
        }.padding()
        
    }}

struct GraficoView_Previews: PreviewProvider {
    static var previews: some View {
        GraficoView()
    }
}
