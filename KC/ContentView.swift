//
//  ContentView.swift
//  KC
//
//  Created by miuraken on 2022/10/31.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            VStack {
                Text("クソコラ").font(.title).fontWeight(.bold).padding(.bottom)
                Text("クソコラとは、複数の画像を適当に切り貼りして作成した「コラージュ」のうち、\n特に「クソみたいな」と形容したくなる類のコラ画像を指す俗な言い方のことである。")
                    .padding([.leading, .bottom, .trailing], 10.0)
                Text("そして、クソコラは三浦研究室の伝統とされている").fontWeight(.bold)
                Text("本アプリではクソコラ作成を体験することができる").fontWeight(.bold)
                Text("あなたの想像力でクソコラを創造しよう！").fontWeight(.bold)
                Text("また、クソコラを以降KCと記述する").fontWeight(.bold).padding(.bottom, 10.0)
                
                NavigationLink(destination: SecondView(), label:{Text("KC作成へ").fontWeight(.bold)} )
            }.navigationBarBackButtonHidden(true)
        }
        }
        
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
