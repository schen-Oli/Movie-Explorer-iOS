//
//  Toast.swift
//  USC Films
//
//  Created by 烁  陈 on 2021/4/20.
//

import Foundation

class Toast : ObservableObject {
    @Published var showToast = false
    @Published var text = ""
}
