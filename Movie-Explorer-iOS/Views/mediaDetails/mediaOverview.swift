//
//  mediaOverview.swift
//  USC Films
//
//  Created by 烁  陈 on 2021/4/20.
//

import SwiftUI

struct mediaOverview: View {
    
    @State private var expanded : Bool = false
    @State private var truncated : Bool = false
    
    var text : String
    
    init(overview:String){
        self.text = overview
    }
    
    private func isTrunc(_ geometry: GeometryProxy){
        let total = self.text.boundingRect(
            with: CGSize(
                width: geometry.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: UIFont.systemFont(ofSize: 16)],
            context: nil)
        
        if total.size.height > geometry.size.height {
            self.truncated = true
        }
    }
    
    var body: some View {
        VStack {
            HStack{Text(text)
                .lineLimit(expanded ? nil : 3)
                .font(.system(size: 16))
                .background(GeometryReader {
                    geo in
                    Color.clear.onAppear(){
                        self.isTrunc(geo)
                    }
                })
                
                Spacer()
            }
            
            
            if self.truncated {
                HStack {
                    Spacer()
                    Button(action:{
                        expanded = !expanded
                    }){
                        Text(self.expanded ? "Show less..." : "Show more...")
                            .bold()
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
            }
            
        }
        
    }
}

struct mediaOverview_Previews: PreviewProvider {
    static var previews: some View {
        mediaOverview(overview: "test text")
    }
}
