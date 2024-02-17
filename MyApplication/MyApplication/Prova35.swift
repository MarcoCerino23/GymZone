//
//  Prova35.swift
//  GymZone
//
//  Created by Marco Cerino on 19/04/23.
//

import SwiftUI
import HealthKit

struct HealthDataView: View {
    
    @State var heartRates: [Double] = []
    
    let healthStore = HKHealthStore()
    
    var body: some View {
        VStack {
            Text("Frequenza cardiaca")
            if !heartRates.isEmpty {
                LineChartView(dataPoints: heartRates, title: "Frequenza cardiaca")
            } else {
                Text("Nessun dato di frequenza cardiaca disponibile")
            }
        }
        .onAppear {
            let typesToRead: Set = [HKObjectType.quantityType(forIdentifier: .heartRate)!]
            healthStore.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
                if success {
                    fetchHeartRateData()
                } else {
                    print("Autorizzazione negata")
                }
            }
        }
    }
    
    func fetchHeartRateData() {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let query = HKSampleQuery(sampleType: heartRateType, predicate: nil, limit: 30, sortDescriptors: nil) { (query, results, error) in
            if let results = results as? [HKQuantitySample] {
                for result in results {
                    let heartRateUnit = HKUnit(from: "count/min")
                    let heartRate = result.quantity.doubleValue(for: heartRateUnit)
                    heartRates.append(heartRate)
                }
            }
        }
        healthStore.execute(query)
    }
}

struct HealthDataView_Previews: PreviewProvider {
    static var previews: some View {
        HealthDataView()
    }
}

struct LineChartView: View {
    
    let dataPoints: [Double]
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
            LineChart(dataPoints: dataPoints)
                .frame(width: 300, height: 200)
        }
    }
}

struct LineChart: Shape {
    
    var dataPoints: [Double]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard !dataPoints.isEmpty else { return path }
        let minValue = CGFloat(dataPoints.min()!)
        let maxValue = CGFloat(dataPoints.max()!)
        let range = maxValue - minValue
        let scaleY = rect.height / range
        let stepX = rect.width / CGFloat(dataPoints.count - 1)
        path.move(to: CGPoint(x: 0, y: (CGFloat(dataPoints[0]) - minValue) * scaleY))
        for i in 1..<dataPoints.count {
            let point = CGPoint(x: stepX * CGFloat(i), y: (CGFloat(dataPoints[i]) - minValue) * scaleY)
            path.addLine(to: point)
        }
        return path
    }
}
