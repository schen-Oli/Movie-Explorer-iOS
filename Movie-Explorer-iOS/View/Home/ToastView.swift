//
//  ToastView.swift
//  Movie-Explorer-iOS
//
//  Created by Oli Chen on 12/24/22.
//

import SwiftUI

struct ToastView<Presenting>: View where Presenting: View{
    @ObservedObject var toast: Toast
    
    let presenting: () -> Presenting
    
    var body: some View {
        GeometryReader { geo in
            
            ZStack(alignment: .center){
                self.presenting()
                
                VStack{
                    Spacer()
                    VStack{
                        Text(toast.text)
                            .bold()
                    }
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                    .frame(width: geo.size.width * 0.8,
                           height: geo.size.height * 0.1)
                    .background(Color(UIColor.lightGray))
                    .foregroundColor(Color.white)
                    .cornerRadius(geo.size.height * 0.05)
                    .opacity(self.toast.showToast ? 1 : 0)
                }
                .padding(.bottom, 22.0)
            }
        }
    }
}

extension View {
    func toastFunc(toast:Toast) -> some View{
        ToastView(toast:toast, presenting: {self})
    }
}

