//
//  watchListView.swift
//  Movie-Explorer-iOS
//
//  Created by Oli Chen on 2021/4/19.
//

import SwiftUI
import Kingfisher

struct watchListView: View {
    @StateObject var watchList = watchListModel()
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 3)
    
    var body: some View {
        
        NavigationView{
            if(!self.watchList.isEmpty){
            ScrollView(.vertical){
                LazyVGrid(columns: columns, spacing: 5, content: {
                    ForEach(watchList.fullWatchList){ media in
                        NavigationLink(destination: LazyView(MediaDetail(card: media))){
                            oneMovieInWL(card: media)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .onDrag({
                            watchList.currentDrag = media
                            return NSItemProvider(
                                contentsOf: URL(string: "\(media.id)")!
                            )!
                        })
                        .onDrop(of: [.url], delegate: DropViewDelegate(card: media, watchList: self.watchList))
                        .contextMenu {
                            Button(action:{
                                watchList.deleteCard(delCard: media)
                            }){
                                HStack{
                                    Text("Remove from watchList")
                                    Image(systemName: "bookmark.fill")
                                }
                            }
                        }
                
                    }
                })
                .navigationTitle("WatchList")
                .padding(20)
            }}else{
                VStack{
                    HStack{
                        Spacer()
                        Text("WatchList is empty")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear{
            watchList.reLoad()
        }
    }
}

struct oneMovieInWL: View {
    
    var card : CardData
    
    init(card: CardData){
        self.card = card
    }
    
    var body: some View{
        if(card.pic != ""){
            KFImage(URL(string: card.pic)!)
                .resizable()
                .frame(width: 120, height: 180)
                .aspectRatio(contentMode: .fill)
        }else{
            Image("moviePlaceHolder")
                .resizable()
                .frame(width: 120, height: 180)
                .aspectRatio(contentMode: .fill)
        }
    }
    
}

struct watchListView_Previews: PreviewProvider {
    static var previews: some View {
        watchListView()
        oneMovieInWL(
            card: CardData(
                title:"This is for test",
                mediaID: -1,
                pic: "",
                type:"movie",
                date:"2021"
            ))
    }
}
