//
//  SecondView.swift
//  KC
//
//  Created by miuraken on 2022/10/31.
//

import SwiftUI

struct SecondView: View {
    var body: some View {
        HStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        } .navigationBarHidden(true)
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
