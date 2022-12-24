//
//  ContentView.swift
//  Movie-Explorer-iOS
//
//  Created by Oli Chen on 12/24/22.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 2
        
    var body: some View {
        TabView(selection:$selection){
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(1)
            HomeViewMain()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
