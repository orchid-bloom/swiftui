//
//  MomentView.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/20.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI

struct MomentView: View {
  
  @ObservedObject var viewModel = MomentViewModel()
  @Environment(\.statusBarStyle) var statusBarStyle
  
  var body: some View {
    ZStack{
      VStack{
        Color(.black)
          .frame(height: 300)
        Spacer()
      }
      List {
        Group {
          Header(member: viewModel.me)
            .anchorPreference(key: NavigationKey.self, value: .bottom, transform: {[ $0 ]})
            .listRowInsets(.zero)
          ForEach(viewModel.moments) { m in
            Text(m.author.name)
          }
          ForEach(viewModel.moments) { m in
            ForEach(m.comments ?? []) { comment in
              Text(comment.content)
              Text(comment.content)
              Text(comment.content)
              Text(comment.content)
              Text(comment.content)
              Text(comment.content)
            }
          }
        }
      }
      .overlayPreferenceValue(NavigationKey.self) { value in
        GeometryReader { proxy in
          VStack {
            self.navigation(proxy: proxy, value: value)
            Spacer()
          }
        }
      }
    }
    .navigationBarHidden(true)
    .edgesIgnoringSafeArea(.top)
    .navigationBarTitle(Text("朋友圈"), displayMode: .inline)
    .onDisappear {
      self.statusBarStyle.current = .default
    }
  }
  
  func navigation(proxy: GeometryProxy, value: [Anchor<CGPoint>]) -> some View {
    let height = proxy.safeAreaInsets.top + 44
    let progress: CGFloat
    
    if let anchor = value.first {
      // proxy[anchor] 作用是得到 anchor 在 proxy 中的相对位置
      // -proxy[anchor].y 为 0 时代表 Header 底部正好在界面顶部的位置
      // 为了与导航栏高度配合，+ height + 20，过渡位置更缓和
      // 最后 / 44 即在 44px 距离内完成隐藏到显示
      progress = max(0, min(1, (-proxy[anchor].y + height + 20) / 44))
    } else {
      // 这种情况是 Header 完全不在界面中，一般也就是滑出屏幕外了
      progress = 1
    }
    
    // 同时更新状态栏样式
    statusBarStyle.current = progress > 0.3 ? .default : .lightContent
    
    return Navigation(progress: Double(progress))
      .frame(height: height)
  }
}

struct MomentView_Previews: PreviewProvider {
  static var previews: some View {
    Navigation(progress: 0.3)
  }
}

private struct NavigationKey: PreferenceKey {
  
  static var defaultValue: [Anchor<CGPoint>] = []
  
  static func reduce(value: inout [Anchor<CGPoint>], nextValue: () -> [Anchor<CGPoint>]) {
    value.append(contentsOf: nextValue())
  }
}


private struct Navigation: View {
  let progress: Double
  
  var body: some View {
    ZStack(alignment: .bottom) {
      Rectangle()
        .foregroundColor(
          Color("light_gray")
            .opacity(progress)
      )
      
      HStack {
        Button(action: {
          self.presentationMode.wrappedValue.dismiss()
        }) {
          Image("back")
          .frame(width: 44, height: 44)
            .padding(.leading, -15)
        }
        .padding()
        
        Spacer()
        
        Button(action: { print("camera") }) {
          Image(systemName: progress > 0.4 ? "camera" : "camera.fill")
        }
        .padding()
      }
      .accentColor(Color(white: colorScheme == .light ? 1 - progress : 1))
      .frame(height: 44)
      
      Text("朋友圈")
        .font(.system(size: 16, weight: .semibold))
        .opacity(progress)
        .frame(height: 44, alignment: .center)
    }
    .frame(maxWidth: .infinity)
  }
  
  @Environment(\.colorScheme) var colorScheme
  @Environment(\.presentationMode) var presentationMode
}


private struct Header: View {
  
  let member: Member
  
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      VStack(spacing: 0) {
        Image(member.background ?? "")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(height: 300)
          .clipped()
        Rectangle()
          .foregroundColor(.clear)
          .frame(height: 20)
      }
      HStack(spacing: 20) {
        Text(member.name)
          .foregroundColor(.white)
          .font(.system(size: 20, weight: .medium))
          .shadow(radius: 2)
          .alignmentGuide(VerticalAlignment.center) { (d) -> CGFloat in
            return 20
        }
        
        Image(member.icon)
        .resizable()
        .cornerRadius(6)
        .frame(width: 70, height: 70)
          .padding(.trailing, 12)
      }
    }
  }
}



