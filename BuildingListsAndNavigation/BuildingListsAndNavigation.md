### List

    List(landmarkData) { landmark in
      NavigationLink(destination:   LandmarkDetail(landmark: landmark)) {
        LandmarkRow(landmark: landmark)
      }
    }
    
### NavigationView

	NavigationView {
	        List(landmarkData) { landmark in
	          NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
	            LandmarkRow(landmark: landmark)
	          }
	        }
	       .navigationBarTitle("Landmarks")
	 } 
	 
	 
###### 二级页面

    .navigationBarTitle(Text(landmark.name), displayMode: .inline)
	    
	 
### LandmarkList_Previews	 
	
	ForEach(["iPhone 11", "iPhone 8"], id: \.self) { deviceName in
	        LandmarkList()
	          .previewDevice(PreviewDevice(rawValue: deviceName))
	          .previewDisplayName(deviceName)
	 }