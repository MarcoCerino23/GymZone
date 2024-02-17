//
//  BarView.swift
//  GymZone
//
//  Created by Marco Cerino on 22/03/23.
//

import SwiftUI

struct BarView: View {
  var datum: Double
  var colors: [Color]

  var gradient: LinearGradient {
    LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom)
  }

  var body: some View {
    Rectangle()
      .fill(gradient)
      .opacity(datum == 0.0 ? 0.0 : 1.0)
  }
}
struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        BarView(datum: 5.5, colors: [.red,.yellow,.black])
    }
}
