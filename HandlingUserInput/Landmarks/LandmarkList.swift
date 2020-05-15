//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Tema.Tian on 2020/5/15.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI

struct LandmarkList: View {
  
  @EnvironmentObject var userData: UserData

  var body: some View {
    NavigationView {
      
      List {
        
        Toggle(isOn: $userData.showFavoritesOnly) {
          Text("Favorites only")
        }
        
        ForEach(userData.landmarks) { (landmark) in
          if !self.userData.showFavoritesOnly || landmark.isFavorite {
            NavigationLink(destination: LandmarkDetail(landmark: landmark).environmentObject(self.userData)) {
              LandmarkRow(landmark: landmark)
            }
          }
        }
      }
      .navigationBarTitle("Landmarks")
    }
  }
}

struct LandmarkList_Previews: PreviewProvider {
  static var previews: some View {
    LandmarkList()
      .environmentObject(UserData())
  }
}

