//
//  ContentView.swift
//  Socks5
//

import SwiftUI
import HevSocks5Server

struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.black // 设置 TabBar 背景色
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray // 未选中按钮颜色
        UITabBar.appearance().tintColor = UIColor.white // 选中按钮颜色
        }
    var body: some View {
        NavigationView{
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                MyView()
                    .tabItem {
                        Label("My Library", systemImage: "person")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
