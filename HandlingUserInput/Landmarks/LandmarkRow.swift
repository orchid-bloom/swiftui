//
//  LandmarkRow.swift
//  Landmarks
//
//  Created by Tema.Tian on 2020/5/15.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI

struct LandmarkRow: View {
  var landmark: Landmark
  
  var body: some View {
    HStack {
      landmark.image
        .resizable()
        .frame(width: 50, height: 50)
      Text(landmark.name)
      Spacer()
      if landmark.isFavorite {
        Image(systemName: "star.fill")
          .imageScale(.medium)
          .foregroundColor(.yellow)
      }
    }
  }
}

struct LandmarkRow_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      LandmarkRow(landmark: landmarkData[0])
      LandmarkRow(landmark: landmarkData[1])
      LandmarkRow(landmark: landmarkData[2])
    }
    .previewLayout(.fixed(width: 300, height: 70))
  }
}
