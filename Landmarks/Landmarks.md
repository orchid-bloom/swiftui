### ContentView

	struct ContentView: View {
	  var body: some View {
	    VStack {
	      MapView()
	        .frame(height: 300)
	        .edgesIgnoringSafeArea(.top)
	      
	      CircleImage()
	        .offset(y: -130)
	        .padding(.bottom, -130)
	      
	      VStack(alignment: .leading) {
	        Text("Turtle Rock")
	          .font(.title)
	        HStack {
	          Text("Joshua Tree National Park")
	            .font(.subheadline)
	          Spacer()
	          Text("California")
	            .font(.subheadline)
	        }
	      }
	      .padding()
	      Spacer()
	    }
	  }
	}
	
### CircleImage	

      Image("turtlerock")
      .clipShape(Circle())
      .overlay(Circle().stroke(Color.white, lineWidth: 4))
      .shadow(radius: 10)

+ clipShape(Circle()) ，将图像裁剪成圆形。  
+ Circle 可以当做一个蒙版的形状，也可以通过 stroke 或 fill 绘制视图。
+ gray stroke 的 circle ，然后将其作为 overlay 添加到图片上，形成图片的边框
+  shadow(radius: 10)  添加一个半径为 10 点的阴影
+  spacer  将内容推到屏幕顶端
+ .edgesIgnoringSafeArea(.top) 内容扩展到屏幕的上边缘    