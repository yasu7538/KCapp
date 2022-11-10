//
//  ContentView.swift
//  KC
//
//  Created by miuraken on 2022/10/31.
//

import SwiftUI

struct ContentView: View {
    
    @State private var show:Bool=false
    
    var body: some View {
        VStack {
            Text("クソコラは三浦研究室の伝統とされている").fontWeight(.bold)
            Text("本アプリではクソコラ作成を体験することができる").fontWeight(.bold)
            Text("クソコラを以降KCと呼ぶこととする").fontWeight(.bold).padding(.bottom, 10.0)
            Button(action: {self.show.toggle()}){
                Text("KC作成へ").fontWeight(.bold)
            }.sheet(isPresented: self.$show){
                SecondView()
            }
                    
            }.navigationBarBackButtonHidden(true)
            
        }
        
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
