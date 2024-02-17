//
//  ActivityView.swift
//  GymZone
//
//  Created by Marco Cerino on 22/03/23.
//

import SwiftUI

struct ActivityView: View {
  @State private var moveValues: [Double] = ActivityView.mockData(24, in: 0...300)
  @State private var exerciseValues: [Double] = ActivityView.mockData(24, in: 0...60)
  @State private var standValues: [Double] = ActivityView.mockData(24, in: 0...1)

  var body: some View {
    VStack(alignment: .leading) {
      Text("Move").bold()
        .foregroundColor(.red)

      BarChartView(data: moveValues, colors: [.red, .orange])

      Text("Exercise").bold()
        .foregroundColor(.green)

      
    }
    .padding()
  }

  static func mockData(_ count: Int, in range: ClosedRange<Double>) -> [Double] {
    (0..<count).map { _ in .random(in: range) }
  }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
