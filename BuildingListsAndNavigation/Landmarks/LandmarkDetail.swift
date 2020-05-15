//
//  ContentView.swift
//  Landmarks
//
//  Created by Tema.Tian on 2020/5/15.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI

struct LandmarkDetail: View {
  
  var landmark: Landmark
  
  var body: some View {
    VStack {
      MapView(locationCoordinate: landmark.locationCoordinate)
        .frame(height: 300)
        .edgesIgnoringSafeArea(.top)
      
      CircleImage(image: landmark.image)
        .offset(y: -130)
        .padding(.bottom, -130)
      
      VStack(alignment: .leading) {
        Text(landmark.name)
          .font(.title)
        HStack(alignment: .top) {
          Text(landmark.park)
            .font(.subheadline)
          Spacer()
          Text(landmark.state)
            .font(.subheadline)
        }
      }
      .padding()
      Spacer()
    }
    .navigationBarTitle(Text(landmark.name), displayMode: .inline)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    LandmarkDetail(landmark: landmarkData[0])
  }
}


