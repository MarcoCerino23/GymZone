//
//  GraficoSwift2.swift
//  GymZone
//
//  Created by Marco Cerino on 26/03/23.
//

import SwiftUI
import Charts


struct GraficoSwift2: View{
    @State var city: City = .cupertino
    var data: [Calor]{
        switch city{
        case .cupertino:
            return calors
        case .sf:
            return calors2
        }
        
    }
    
    var body: some View {
        let dateFormatter = ISO8601DateFormatter()
        VStack{
            Picker("City",selection: $city.animation(.easeInOut)){
                Text("Prediction").tag(City.cupertino)
                Text("Real").tag(City.sf)
            }.pickerStyle(.segmented)
            
            Chart(data){ element in //si fa il for each direttamente nell' inizializzatore
                BarMark(
                    x:.value("Giorni", dateFormatter.date(from: element.weekDay)!,unit:.day),
                    y:.value("Calorie", element.cal)
                )
                
            }
            
        }.frame(height: 250,alignment: .center)
            .padding()
    }
}

struct GraficoSwift2_Previews: PreviewProvider {
    static var previews: some View {
        GraficoSwift2()
    }
}
