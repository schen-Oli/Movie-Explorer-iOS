//
//  searchBar.swift
//  USC Films
//
//  Created by 烁  陈 on 2021/4/21.
//

import SwiftUI
import Kingfisher

struct searchBar: View {
    
    @ObservedObject var searchData : SearchMedia
    @State var showCancelButton = false
    
    var body: some View {
        HStack {
            VStack(spacing: 0) {
                HStack(spacing: 6){
                    Image(systemName: "magnifyingglass")
                        .font(.body)
                        .foregroundColor(.gray
                        )
                        .padding(.horizontal, 5)
                    TextField("Search Movies, TVs...", text: $searchData.query, onEditingChanged: { isEditing in
                        withAnimation{
                            showCancelButton = true
                        }
                    })
                  
                    
                    if(searchData.query != ""){
                        Button(
                            action:{
                                searchData.query = ""
                                searchData.searchResults.removeAll()
                                searchData.hasRes = true
                            }){
                        Image(systemName: "multiply.circle.fill")
                            .padding(.horizontal, 5)
                            .font(.body)
                            .foregroundColor(.gray)
                        }
                    }
                   
                }
                .padding(.vertical, 10)
            }
            .frame(height:40)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 5)
            
            if showCancelButton {
                Button(action:{
                    UIApplication.shared.endEditing(true)
                    withAnimation{
                        self.showCancelButton = false
                    }
                    self.searchData.query = ""
                    searchData.hasRes = true
                    self.searchData.searchResults.removeAll()
                }){
                    Text("Cancel")
                        .font(Font.system(size:18, weight: .light))
                        .padding(.trailing, 5)
                }.transition(.move(edge: .trailing))
            }
        }.padding(.horizontal, 5)
        
        if searchData.hasRes{
        if !searchData.searchResults.isEmpty{
            ScrollView(.vertical){
                VStack(alignment: .leading, spacing: 12){
                    ForEach(searchData.searchResults){ res in     
                        VStack{
                            NavigationLink(destination: LazyView(mediaDetail(card: CardData(title: res.title, mediaID: res.mediaID, pic: res.poster, type: res.type, date: res.date)))){
                            oneSearchResView(result: res)
                            }
                        }
                    }
                }
            }
        }
        }else{
            VStack{
                Text("No Results")
                    .padding(.horizontal)
                    .padding(.vertical, 30)
                    .font(.title2)
                    .foregroundColor(.secondary)
                Spacer()
            }
        }
    }
}

struct oneSearchResView: View{
    
    var result : resultMovie
    
    init(result: resultMovie){
        self.result = result
    }
    var body: some View {
      
        ZStack{
            HStack {
                Spacer()
                KFImage(URL(string: result.pic)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .cornerRadius(20)
                Spacer()
            }

            VStack {
                HStack {
                    Text(result.type + "(" + result.date + ")")
                        .foregroundColor(Color.white)

                    Spacer()
                    Image(systemName: "star.fill")
                        .foregroundColor(.red)
                    Text(result.rate)
                        .foregroundColor(Color.white)
                }
                Spacer()
                HStack{
                    Text(result.title)
                        .foregroundColor(Color.white)
                    Spacer()
                }
            }.padding(.horizontal, 25)
            .padding(.vertical, 20)
            .font(Font.system(size:20, weight: .bold)
            .lowercaseSmallCaps())
           
            
        }
        .frame(height: 180)
        .padding(.horizontal, 5)
        .padding(.vertical, 15)
    }
}


extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}


struct searchBar_Previews: PreviewProvider {
    
    static var previews: some View {
        searchBar(searchData: SearchMedia())
        oneSearchResView(
            result: resultMovie(
                title: "This is for test",
                type: "Movie",
                mediaID: 1250,
                pic: "https://image.tmdb.org/t/p/w500/mqnaqKWReftxED6LPGLTDmMjWCY.jpg",
                date: "2015",
                rate: "5.3",
                poster: ""))
    }
}
