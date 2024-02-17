//
//  GraficoSwift.swift
//  GymZone
//
//  Created by Marco Cerino on 26/03/23.
//

import SwiftUI
import Charts

struct GraficoSwift: View {
    let dateFormatter = ISO8601DateFormatter()
    var body: some View {
        VStack{
            Chart(calors){ element in //si fa il for each direttamente nell' inizializzatore
                BarMark(
                    x:.value("Calorie", element.cal),
                    y:.value("Giorni", dateFormatter.date(from: element.weekDay)!,unit: .day)
                )
                
            }
            
        }.frame(height: 250,alignment: .center)
            .padding()
        
    }
}

struct GraficoSwift_Previews: PreviewProvider {
    static var previews: some View {
        GraficoSwift()
    }
}
