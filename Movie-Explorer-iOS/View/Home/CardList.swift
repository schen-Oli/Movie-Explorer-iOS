//
//  CardList.swift
//  Movie-Explorer-iOS
//
//  Created by Oli Chen on 12/24/22.
//

import SwiftUI
import Kingfisher
import Combine

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

struct CardList: View {
    private var cards : [CardData]
    @ObservedObject var toast : Toast
    
    init(cards:[CardData], toast:Toast){
        self.cards = cards
        self.toast = toast
    }
    
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(cards){ card in
                    NavigationLink(destination: LazyView(mediaDetail(card:card))){
                        oneCard(card:card, toast:self.toast)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.vertical, 10)
                    .padding(.trailing, 15)
                }
            }
        }
    }
}

struct oneCard: View{
    private var card : CardData
    
    @ObservedObject var stored : isStored
    @ObservedObject var toast : Toast
    
    init(card:CardData, toast:Toast){
        self.card = card
        self.stored = isStored(card: card)
        self.toast = toast
    }
    var body: some View{
        VStack(alignment: .center, spacing: 0.0){
            
            RemoteImage(url: card.pic)
                .frame(width: 100, height: 150)
                .aspectRatio(contentMode: .fit)
                .clipped()
                .cornerRadius(15)
            
            
            
            Text(card.title)
                .font(Font.system(size: 14, weight: .semibold))
                .lineSpacing(3)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .padding(.top, 5.0)
            
            
            Text("(" + card.date + ")")
                .font(Font.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)
                .padding(.top, 5.0)
            
            Spacer()
        }
        .frame(width: 100, height:250)
        .background(Color.white)
        .cornerRadius(15)
        .contentShape(RoundedRectangle(cornerRadius: 15))
        .contextMenu{
            if stored.mediaStored{
                Button(action:{
                    stored.deleteDic()
                    toast.showToast = true
                    toast.text = card.title + " was removed from Watchlist"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        
                        toast.showToast = false
                        
                    }
                }){
                    HStack{
                        Text("Remove from watchList")
                        Image(systemName: "bookmark.fill")
                    }
                }
            }else{
                Button(action:{
                    stored.addDic()
                    toast.showToast = true
                    toast.text = card.title + " was added to Watchlist"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        
                        toast.showToast = false
                        
                    }
                }){
                    HStack{
                        Text("Add to watchList")
                        Image(systemName: "bookmark")
                    }
                }
            }
            Button(action:{
                guard let url = URL(string: "https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fwww.themoviedb.org%2F" + card.type + "%2F" + String(card.mediaID)) else { return }
                UIApplication.shared.open(url)
            }){
                HStack{
                    Text("Shared on Facebook")
                    Image(/*@START_MENU_TOKEN@*/"facebook"/*@END_MENU_TOKEN@*/)
                }
            }
            Button(action:{
                guard let url = URL(string: "https://twitter.com/intent/tweet?text=Check%20out%20this%20this%20link:%0Ahttps%3A%2F%2Fwww.themoviedb.org%2F" + card.type + "%2F" + String(card.mediaID) + "%20%23CSCI571USCFilms") else { return }
                UIApplication.shared.open(url)
            }){
                HStack{
                    Text("Share on Twitter")
                    Image("twitter")
                }
            }
        }
        .onAppear{
            self.stored.storageCheck()
        }
    }
    
    
}
struct CardList_Previews: PreviewProvider {
    static var previews: some View {
        let toast = Toast()
        
        CardList(cards: [
                    CardData(title:"And you?", mediaID: -1, pic: "", type:"movie", date:"2021"),
                    CardData(title:"OMG", mediaID: -1, pic: "https://image.tmdb.org/t/p/w500/bQLrHIRNEkE3PdIWQrZHynQZazu.jpg", type:"movie", date:"2021"),
                    CardData(title:"HOW R U", mediaID: -1, pic: "https://image.tmdb.org/t/p/w500/bQLrHIRNEkE3PdIWQrZHynQZazu.jpg", type:"movie", date:"2021"), CardData(title:"HAVE A GOOD DAY", mediaID: -1, pic: "https://image.tmdb.org/t/p/w500/bQLrHIRNEkE3PdIWQrZHynQZazu.jpg", type:"movie", date:"2021"),
                    CardData(title:"OH?", mediaID: -1, pic: "https://image.tmdb.org/t/p/w500/bQLrHIRNEkE3PdIWQrZHynQZazu.jpg", type:"movie", date:"2021"),
                    CardData(title:"Hail no", mediaID: -1, pic: "https://image.tmdb.org/t/p/w500/bQLrHIRNEkE3PdIWQrZHynQZazu.jpg", type:"movie", date:"2021")],
                 toast:toast)
        
        oneCard(card:CardData(title:"1234567", mediaID: -1, pic: "https://image.tmdb.org/t/p/w500/bQLrHIRNEkE3PdIWQrZHynQZazu.jpg", type:"movie", date:"2021"), toast: toast)
    }
}
