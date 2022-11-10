//
//  SecondView.swift
//  KC
//
//  Created by miuraken on 2022/10/31.
//

import SwiftUI

struct SecondView: View {
    
    @State private var show:Bool=false
    
    var body: some View {
        VStack{
            Text("KC").fontWeight(.bold)
            Button(action: {self.show.toggle()}){
                Text("KC作成").fontWeight(.bold).padding(.top, 10.0)
            }.sheet(isPresented: self.$show){
                satuei()
            }
            Button(action: {self.show.toggle()}){
                Text("KC一覧").fontWeight(.bold)
            }.sheet(isPresented: self.$show){
                KCitiran()
            }
            Button(action: {self.show.toggle()}){
                Text("素材一覧").fontWeight(.bold)
            }.sheet(isPresented: self.$show){
                sozai()
            }
        } .navigationBarHidden(true)
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
