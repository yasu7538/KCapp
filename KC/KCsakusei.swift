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
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController{
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
}

struct KCsakusei: View {
    
    @State private var image = UIImage()
    @State private var isShowPhotoLibrary = false
    
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                Image(uiImage: self.image)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 0,maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                Button(action: {
                    self.isShowPhotoLibrary = true
                }, label: {
                    Text("フォトライブラリ")
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
                })
            }.navigationBarHidden(true)
                .sheet(isPresented: $isShowPhotoLibrary, content: {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                })
        }
        
    }
}

struct KCsakusei_Previews: PreviewProvider {
    static var previews: some View {
        KCsakusei()
    }
}
