//
//  LinkSwift.swift
//  GymZone
//
//  Created by Marco Cerino on 22/03/23.
//

import SwiftUI

struct BarChartView: View {
  var data: [Double]
  var colors: [Color]

  var highestData: Double {
    let max = data.max() ?? 1.0
    if max == 0 { return 1.0 }
    return max
  }

  var body: some View {
    GeometryReader { geometry in
      HStack(alignment: .bottom, spacing: 4.0) {
        ForEach(data.indices, id: \.self) { index in
          let width = (geometry.size.width / CGFloat(data.count)) - 4.0
          let height = geometry.size.height * data[index] / highestData

          BarView(datum: data[index], colors: colors)
            .frame(width: width, height: height, alignment: .bottom)
        }
      }
    }
  }
}

struct LinkSwift_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(data: [1500,1400,1200], colors: [.red,.yellow,.black])
    }
}
