//
//  MapView.swift
//  Landmarks
//
//  Created by Tema.Tian on 2020/5/15.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI
import  MapKit

struct MapView: UIViewRepresentable {

  var locationCoordinate: CLLocationCoordinate2D
  
  func makeUIView(context: Self.Context) -> MKMapView {
    MKMapView(frame: .zero)
  }
  
  func updateUIView(_ view: MKMapView, context: Context) {
    
    let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
    let region = MKCoordinateRegion(center: locationCoordinate, span: span)
    view.setRegion(region, animated: true)
  }

}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(locationCoordinate: CLLocationCoordinate2D(
          latitude: 34.011286, longitude: -116.166868))
    }
}
