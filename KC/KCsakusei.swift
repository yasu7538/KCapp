//
//  KCsakusei.swift
//  KC
//
//  Created by miuraken on 2022/11/10.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct KCsakusei: View {
    
    @State private var image: UIImage?
    @State var showingImagePicker = false
    
    
    var body: some View {
        NavigationStack{
            VStack{
                if let uiImage = image{
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }else{
                    Image("noimage")
                        .resizable()
                        .frame(width: 200,height: 200)
                        .clipShape(Circle())
                }
                Spacer().frame(height: 32)
                Button(action: {
                    showingImagePicker = true
                }){
                    Text("フォトライブラリから写真を選択")
                    //横幅いっぱい
                        .frame(maxWidth: 750)
                    //高さ50ポイントを指定
                        .frame(height: 50)
                    //文字列センタリング指定
                        .multilineTextAlignment(.center)
                    //背景を青色に指定
                        .background(Color.blue)
                    //文字色を青色に指定
                        .foregroundColor(Color.white)
                }
            }.navigationBarHidden(true)
        }
        
    }
}

struct KCsakusei_Previews: PreviewProvider {
    static var previews: some View {
        KCsakusei()
    }
}
