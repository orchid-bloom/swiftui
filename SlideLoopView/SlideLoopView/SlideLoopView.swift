//
//  SlideLoopView.swift
//  SlideLoopView
//
//  Created by OrchidBloom on 2020/9/23.
//

import SwiftUI
import UIKit

struct SlideLoopView<Content>: View where Content: View {
    
    @State private var offset = CGFloat.zero
    @State private var dragging = false
    @ObservedObject var viewModel: SlideLoopViewModel
    private let content: () -> Content
    
    init(viewModel: SlideLoopViewModel, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        self.content()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                    }
                }
                .content.offset(x: self.offset(in: geometry), y: 0)
                .frame(width: geometry.size.width, alignment: .leading)
                .gesture(
                    DragGesture().onChanged { value in
                        self.dragging = true
                        self.offset = -CGFloat(self.viewModel.currentIndex) * geometry.size.width + value.translation.width
                        self.viewModel.cancel()
                    }
                    .onEnded { value in
                        let predictedEndOffset = -CGFloat(self.viewModel.currentIndex) * geometry.size.width + value.predictedEndTranslation.width
                        let predictedIndex = Int(round(predictedEndOffset / -geometry.size.width))
                        self.viewModel.currentIndex = self.clampedIndex(from: predictedIndex)
                        withAnimation(.easeInOut(duration: 0.3)) {
                            self.dragging = false
                        }
                        self.viewModel.resume()
                        self.viewModel.refreshPage()
                    }
                )
            }
            .clipped()
        }.onReceive(self.viewModel.timer) { _ in
            let currentPage = self.viewModel.currentIndex + 1
            if currentPage < viewModel.numberOfPages {
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.viewModel.currentIndex = currentPage
                }
            } else if currentPage == viewModel.numberOfPages {
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.viewModel.currentIndex = currentPage
                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(350)) {
                    self.viewModel.currentIndex = 1
                }
            }
        }.onDisappear {
            self.viewModel.cancel()
        }.onAppear {
            self.viewModel.resume()
        }
    }
    
    private func offset(in geometry: GeometryProxy) -> CGFloat {
        if self.dragging {
            return max(min(self.offset, 0), -CGFloat(self.viewModel.numberOfPages) * geometry.size.width)
        } else {
            return -CGFloat(self.viewModel.currentIndex) * geometry.size.width
        }
    }
    
    private func clampedIndex(from predictedIndex: Int) -> Int {
        let newIndex = min(max(predictedIndex, self.viewModel.currentIndex - 1), self.viewModel.currentIndex + 1)
        guard newIndex >= 0 else { return 0 }
        guard newIndex <= viewModel.numberOfPages else { return viewModel.numberOfPages }
        return newIndex
    }
}

class SlideLoopViewModel: NSObject, ObservableObject {
    
    @Published var currentPage: Int = 0    // 当前分页
    @Published var currentIndex: Int = 1 { // 当前真实分页, 计算使用外面调用使用currentPage
        didSet {
            if currentIndex < 1 {
                currentPage =  self.images.count - 3
            } else if currentIndex == self.images.count - 1 {
                currentPage = 0
            } else {
                currentPage = currentIndex - 1
            }
            print("currentIndex: \(currentPage)")
        }
    }
    @Published var images = ["Intro_6", "Intro_1", "Intro_2", "Intro_3", "Intro_4", "Intro_5", "Intro_6", "Intro_1"]
    var numberOfPages: Int = 0 // 总共有多少分页，从零开始
    var timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    override init() {
        super.init()
        
        numberOfPages = images.count - 1
    }
    
    func resume() {
        timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    }
    
    func cancel() {
        timer.upstream.connect().cancel()
    }
    
    func refreshPage() {
        let currentPage = self.currentIndex + 1
        if currentPage == self.images.count {
            self.currentIndex = 1
        } else if self.currentIndex == 0 {
            self.currentIndex = self.images.count - 2
        }
    }
}
