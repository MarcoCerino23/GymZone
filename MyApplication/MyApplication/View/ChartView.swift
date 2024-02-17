//
//  ChartView.swift
//  GymZone
//
//  Created by Marco Cerino on 01/05/23.
//

import SwiftUI
import Charts
import SwiftUICharts

//Vista che mostra l'andamento del peso dell'utente nel tempo

struct ChartView: View {
    @EnvironmentObject var profile : Profilo
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView{
            ZStack {
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()
                
                VStack{
                    HStack{
                        Text("Andamento del peso nel tempo")
                            .font(.title2)
                            .bold()
                            .padding(.leading, 20)
                        
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    VStack{
                        //Utilizzo di Charts per i grafici
                        Chart(Array(profile.caratteristicheProfilo.peso.keys.sorted()), id: \.self) { index in
                            LineMark(x: .value("Data", index,unit:.day),
                                     y: .value("Peso", Double(profile.caratteristicheProfilo.peso[index] ?? "") ?? 0.0))
                            .foregroundStyle(Color.green.gradient)
                        }
                        .chartPlotStyle{plotContent in
                            plotContent
                                .border(Color(UIColor.systemGray4), width: 1)
                                .background(Color.white)
                        }
                        .frame(height: 300)
                        .padding()
                        .chartYScale(domain:20...130)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
                    .shadow(radius: 10)
                    
                    Spacer()
                }
                .navigationBarTitle("Grafico peso", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action: {dismiss()}, label:{
                    Image(systemName:"arrow.backward")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.green)
                        .padding(.leading, 20)
                    
                    Text("Indietro")
                        .foregroundColor(.green)
                        .font(.headline)
                        .padding(.leading, 5)
                }))
            }
        }
    }
}
