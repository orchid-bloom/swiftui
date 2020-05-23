//
//  SearchView.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/20.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI

struct SearchView: View {
  
  private let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
  
  var body: some View {
    
    GeometryReader { geometry0 in
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(0 ..< 50) { index in
            GeometryReader { geometry in
              Rectangle()
                .fill(self.colors[index % self.colors.count])
                .frame(height: 150)
                .rotation3DEffect(
                  self.rotation(forRectWith: geometry, geometry0: geometry0),
                  axis: (x: 0, y: 1, z: 0)
              )
            }
            .frame(width: 150)
          }
        }
        .padding(.horizontal, (geometry0.size.width - 150) / 2)
      }
    }
    .edgesIgnoringSafeArea(.all)
    
    
  }
  
  func rotation(forRectWith geometry: GeometryProxy, geometry0: GeometryProxy) -> Angle {
    let screenMidX = Double(geometry.frame(in: .global).midX)
    let containerHalfWidth = Double(geometry0.size.width / 2)
    
    return .radians(
      -1 * ((screenMidX - containerHalfWidth) / 10 / 180) * Double.pi
    )
  }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
