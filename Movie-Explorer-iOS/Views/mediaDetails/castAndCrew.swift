//
//  castAndCrew.swift
//  USC Films
//
//  Created by 烁  陈 on 2021/4/21.
//

import SwiftUI
import Kingfisher

struct castAndCrew: View {
    
    var castList : [castInfo]
    
    init(castList: [castInfo]){
        self.castList = castList
    }
    
    var body: some View {
        
        ScrollView(.horizontal) {
            HStack {
                ForEach(castList){ cast in
                    oneCast(cast: cast)
                }
            }
        }.padding()
    }
}



struct oneCast: View{
    
    var cast : castInfo
    init(cast: castInfo){
        self.cast = cast
    }
    
    var body: some View {

        VStack(alignment: .center) {
            if(cast.pic == ""){
                Image("castPlaceHolder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100, alignment: .center)
                    .cornerRadius(50)
            }else{
            KFImage(URL(string: cast.pic)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(50)
            }
            
            Text(cast.name).padding(.vertical, 10)
                .frame(width: 90)
                .font(.subheadline)
            
            Spacer()
        }.frame(width: 100, height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct castAndCrew_Previews: PreviewProvider {
    
    static var previews: some View {
        castAndCrew(castList: [castInfo(name: "Oli", pic: ""), castInfo(name: "Chen", pic: "https://image.tmdb.org/t/p/w500/7TkEhCL3ZK8IlFNqm5Ow8nZPkso.jpg"), castInfo(name: "Oli Chen", pic: "https://image.tmdb.org/t/p/w500/7TkEhCL3ZK8IlFNqm5Ow8nZPkso.jpg"), castInfo(name: "Oli Chen", pic: "https://image.tmdb.org/t/p/w500/7TkEhCL3ZK8IlFNqm5Ow8nZPkso.jpg"), castInfo(name: "Oli Chen", pic: "https://image.tmdb.org/t/p/w500/7TkEhCL3ZK8IlFNqm5Ow8nZPkso.jpg"), castInfo(name: "Oli Chen", pic: "https://image.tmdb.org/t/p/w500/7TkEhCL3ZK8IlFNqm5Ow8nZPkso.jpg")])
        
        oneCast(cast: castInfo(name: "Oli Chen", pic: "https://image.tmdb.org/t/p/w500/7TkEhCL3ZK8IlFNqm5Ow8nZPkso.jpg"))
    }
}
