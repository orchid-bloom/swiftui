//
//  MomentView.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/20.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI
import VideoPlayer

struct MomentView: View {

  @ObservedObject var viewModel = MomentViewModel()
  @Environment(\.statusBarStyle) var statusBarStyle

  var body: some View {
    ZStack {
      VStack {
        Color(.black)
          .frame(height: 300)
        Spacer()
      }
      List {
        Group {
          Header(member: viewModel.me)
            .anchorPreference(key: NavigationKey.self, value: .bottom, transform: { [$0] })
            .listRowInsets(.zero)
          VStack {
            ForEach(viewModel.moments) { m in
              MomentCell(moment: m)
              if m.id != self.viewModel.moments.last?.id {
                Separator().padding(EdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 0))
              }
            }
          }.padding([.leading, .trailing], -5)
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
        .accentColor(Color(white: colorScheme == .light ? 1 - progress: 1))
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

private struct MomentCell: View {

  let moment: Moment

  var body: some View {
    HStack(alignment: .top) {
      Avatar(icon: moment.author.icon)
      VStack(alignment: .leading, spacing: 10) {
        Text(moment.author.name)
          .font(.system(size: 18, weight: .semibold))

        if moment.text != nil {
          TextContent(text: moment.text ?? "").fixedSize(horizontal: false, vertical: true)
        }

        if moment.images != nil {
          if moment.images!.count == 1 {
            SingleImage(media: moment.images![0])
          } else {
            ImageGrid(images: moment.images!)
          }
        }
        
        if moment.video != nil {
          SingleVideo(media: moment.video!)
        }

        HStack {
          Time(time: moment.time)
          Spacer()
          Image("moment_comment")
        }

        if moment.likes != nil || moment.comments != nil {
          VStack(alignment: .leading, spacing: 0) {
            
            if moment.likes != nil {
              Likes(likes: moment.likes ?? [])
            }
            
            if moment.likes != nil && moment.comments != nil {
              Separator(color: Color("moment_comment_separator"))
            }
            
            if moment.comments != nil {
              Comments(comments: moment.comments ?? [])
            }
          }.background(Color.secondary.opacity(0.1))
        }

      }
        .padding([.leading, .trailing], 12)
    }
  }
}

private struct Avatar: View {

  let icon: String

  var body: some View {
    Image(icon)
      .resizable()
      .renderingMode(.original)
      .frame(width: 42, height: 42)
      .cornerRadius(4)
  }
}

private struct TextContent: View {

  let text: String

  var body: some View {
    Text(text)
      .font(.system(size: 15))
      .frame(maxWidth: .infinity, alignment: .leading)
  }
}

private struct ImageGrid: View {
  let images: [Media]

  var rows: Int { images.count / cols }
  var cols: Int { images.count == 4 ? 2 : min(images.count, 3) }
  var lastRowCols: Int { images.count % cols }

  var body: some View {
    VStack(alignment: .leading, spacing: 6) {
      ForEach(0 ..< rows, id: \.self) { row in
        self.rowBody(row: row, isLast: false)
      }
      if lastRowCols > 0 {
        self.rowBody(row: rows, isLast: true)
      }
    }
  }

  func rowBody(row: Int, isLast: Bool) -> some View {
    HStack(spacing: 6) {
      ForEach(0 ..< (isLast ? self.lastRowCols : self.cols), id: \.self) { col in
        Image(self.images[row * self.cols + col].url)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(minWidth: 60, maxWidth: 80, minHeight: 60, maxHeight: 80)
          .aspectRatio(1, contentMode: .fill)
          .clipped()
      }
    }
  }
}

private struct SingleImage: View {

  let media: Media
  var w: Double = 180
  var h: Double = 180
  
  init(media: Media) {
    self.media = media
    
    guard let width = media.width, let height = media.height  else {
      return
    }
    if width > height {
      w = 180
      h = 180 * height / width
    } else {
      h = 180
      w = 180 * width / height
    }
  }
  
  var body: some View {
    // 按照最大区域 180x180 等比缩放
    Image(media.url)
      .resizable()
      .frame(width: CGFloat(w), height: CGFloat(h))
  }
}

private struct SingleVideo: View {
  
  let media: Media

  @State private var play = false
  @State private var isPlaying = false

  var body: some View {
    ZStack {
      VideoPlayer(url: URL.init(string: media.url)!, play: $play)
        .onStateChanged { (state) in
          switch state {
          case .playing: self.isPlaying = true
          default: self.isPlaying = false
        }
      }
      .onAppear {
        self.play = true
      }
      .onDisappear {
        self.play = false
      }
      
      if (!isPlaying) {
        Image(media.cover!)
        .resizable()
      }
    }.aspectRatio(CGSize(width: media.width!, height: media.height!), contentMode: .fit)
    .frame(maxWidth: 225, maxHeight: 225)
  }
}

private struct Time: View {

  let time: String

  var body: some View {
    Text(time)
      .foregroundColor(.secondary)
      .font(.system(size: 14))
  }
}

private struct Likes: View {

  let likes: [String]

  var body: some View {
    ZStack(alignment: .topLeading) {
      makeLikesText()
        .fixedSize(horizontal: false, vertical: true)
      Image("moment_like")
        .resizable()
        .frame(width: 12, height: 12)
        .offset(y: 5)
    }.padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 14))
  }

  func makeLikesText() -> Text {
    var text = Text("    ")
    for (index, item) in likes.enumerated() {
      if index > 0 { text = text + Text(", ") }
      text = text + Text(item)
        .foregroundColor(Color("link"))
        .font(.system(size: 14, weight: .medium))
    }
    return text
  }
}

private struct Comments: View {

  let comments: [Comment]

  var body: some View {
    VStack(alignment: .leading) {
      ForEach(comments) {comment in
        self.makeCommentText(comment: comment).fixedSize(horizontal: false, vertical: true)
          .padding(.bottom, 4)
      }
    }.padding(EdgeInsets(top: 0, leading: 4, bottom: 16, trailing: 12))
  }
  
  func makeCommentText(comment: Comment) -> Text {
     Text(comment.name)
      .font(.system(size: 14, weight: .medium))
      .foregroundColor(Color("link")) +
      Text("：\(comment.content)")
      .font(.system(size: 14))
  }
}





