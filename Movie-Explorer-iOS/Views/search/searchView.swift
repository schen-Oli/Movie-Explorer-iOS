//
//  searchView.swift
//  USC Films
//
//  Created by 烁  陈 on 2021/4/19.
//

import SwiftUI

struct searchView: View {
    @StateObject var searchData = SearchMedia()
    var body: some View {
        NavigationView {
            VStack {
                searchBar(searchData: searchData)
                    .navigationTitle("Search")
                    .navigationBarTitleDisplayMode(.large)
                Spacer()
            }
            .onChange(of: searchData.query){ res in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    if res == searchData.query{
                       // print("search \(res)")
                        if searchData.query.count >= 3{
                            searchData.searchResults.removeAll()
                            searchData.find()
                        }else{
                            searchData.searchResults.removeAll()
                            searchData.hasRes = true
                        }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct searchView_Previews: PreviewProvider {
    static var previews: some View {
        searchView()
    }
}
