//
//  SecondView.swift
//  KC
//
//  Created by miuraken on 2022/10/31.
//

import SwiftUI

struct SecondView: View {
    
    var body: some View{
        NavigationStack{
            VStack{
                Text("KC").fontWeight(.bold).padding(.bottom)
                NavigationLink(destination: cameramove()){
                    Text("KC作成").fontWeight(.bold)
                }
                
                NavigationLink(destination: KCitiran()){
                    Text("写真一覧").fontWeight(.bold)
                }
                
                NavigationLink(destination: sozai()){
                    Text("素材一覧").fontWeight(.bold)
                }
            }.navigationBarHidden(true)
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
