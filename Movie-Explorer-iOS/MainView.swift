//
//  ContentView.swift
//  USC Films
//
//  Created by 烁  陈 on 2021/4/17.
//

import SwiftUI

struct MainView: View {
    
    @State private var selection = 2
        
    var body: some View {
        TabView(selection:$selection){
            searchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(1)
            homeViewMain()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(2)
            watchListView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("WatchList")
                }
                .tag(3)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
