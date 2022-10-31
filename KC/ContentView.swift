//
//  ContentView.swift
//  KC
//
//  Created by miuraken on 2022/10/31.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            NavigationView {
                NavigationLink("次の画面",destination:SecondView())
                    
            }.navigationBarBackButtonHidden(true)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
