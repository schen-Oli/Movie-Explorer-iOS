//
//  Recommend.swift
//  Movie-Explorer-iOS
//
//  Created by Oli Chen on 12/24/22.
//

import SwiftUI
import Kingfisher

struct Recommend: View {
    var recs: [recCard]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(recs){ rec in
                    let tmpCard = CardData(title: rec.title, mediaID: rec.mediaID, pic: rec.pic, type: rec.type, date: "")
                    NavigationLink(destination: LazyView(MediaDetail(card: tmpCard))){
                        oneRec(rec:rec)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                }
            }
        }
    }
}

struct oneRec: View{
    var rec: recCard
    
    var body: some View {
        VStack(alignment: .center) {
            if(rec.pic == ""){
                Image("moviePlaceHolder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }else{
            KFImage(URL(string: rec.pic)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
            }
        }.frame(width: 100, height: 170, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
         .cornerRadius(15)
    }
}


struct Recommend_Previews: PreviewProvider {
    static var previews: some View {
        Recommend(recs:[
            recCard(type: "movie", mediaID: 791373, pic: "", title: "test"),
            recCard(type: "movie", mediaID: 792373, pic: "https://image.tmdb.org/t/p/w500/tnAuB8q5vv7Ax9UAEje5Xi4BXik.jpg", title: "test"),
            recCard(type: "movie", mediaID: 792373, pic: "", title: "test"),
            recCard(type: "movie", mediaID: 794373, pic: "https://image.tmdb.org/t/p/w500/tnAuB8q5vv7Ax9UAEje5Xi4BXik.jpg", title: "test"),
            recCard(type: "movie", mediaID: 792373, pic: "https://image.tmdb.org/t/p/w500/tnAuB8q5vv7Ax9UAEje5Xi4BXik.jpg", title: "test")
        ])
    
    oneRec(rec: recCard(type: "movie", mediaID: 791373, pic: "https://image.tmdb.org/t/p/w500/tnAuB8q5vv7Ax9UAEje5Xi4BXik.jpg", title: "test"))
    }
}
