//
//  Youtube.swift
//  GymZone
//
//  Created by Marco Cerino on 22/03/23.
//

//import SwiftUI
//import Charts
//
//struct Youtube: View {
//    let dateFormatter = ISO8601DateFormatter()
//    
//    //MARK: View Properties

//    @State var currentTab: String = "7 days"
//    
//    var body: some View {
//        NavigationStack{
//            VStack{
//                VStack(alignment: .leading, spacing: 12){
//                    HStack{
//                        Text("Views")
//                            .fontWeight(.semibold)
//                        Picker("",selection: $currentTab){
//                            Text("7 Days")
//                                .tag("7 days")
//                            Text("Week")
//                                .tag("Week")
//                            Text("Month")
//                                .tag("Month")
//                        }
//                        .pickerStyle(.segmented)
//                        .padding(.leading,80)
//                    }
//                    AnimatedChart()
//                }
//                .padding()
//                .background(){
//                    RoundedRectangle(cornerRadius: 10,style: .continuous)
//                        .fill(.white.shadow(.drop(radius: 2)))
//                }
//                
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
//            .padding()
//            .navigationTitle("Swift Charts")
//        }
//    }
//    
//    @ViewBuilder
//    func AnimatedChart()->some View{
//        Chart{
//            ForEach(calors){item in
//                BarMark(
//                    //aggiungere la data di calors
//                    x: .value("Day",dateFormatter.date(from:item.weekDay)! , unit: .day),
//                    y: .value("Cal", item.animate ? item.cal : 0)
//                )
//            }
//        }
//        // MARK: Personalizzare l' asse delle y
//        //vedere il max tra le calorie
//        .chartYScale(domain: 0...(1800+1000))
//        .frame(height: 250)
//        .onAppear(){
//            for (index,_) in calors.enumerated(){
//                
//                    withAnimation(.interactiveSpring(response: 0.8,dampingFraction: 0.8,blendDuration: 0.8).delay(Double(index) * 0.5)){
//                        calors[index].animate = true
//                    }
//                
//                
//                        
//                    }
//            
//        }
//    }
//}
//
//struct Youtube_Previews: PreviewProvider {
//    static var previews: some View {
//        Youtube()
//    }
//}
