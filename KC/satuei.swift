//
//  satuei.swift
//  KC
//
//  Created by miuraken on 2022/11/10.
//

import SwiftUI

struct Imagepicker : UIViewControllerRepresentable {
    
    @Binding var show:Bool
    @Binding var image:Data
    var sourceType:UIImagePickerController.SourceType
 
    func makeCoordinator() -> Imagepicker.Coodinator {
        
        return Imagepicker.Coordinator(parent: self)
    }
      
    func makeUIViewController(context: UIViewControllerRepresentableContext<Imagepicker>) -> UIImagePickerController {
        
        let controller = UIImagePickerController()
        controller.sourceType = sourceType
        controller.delegate = context.coordinator
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<Imagepicker>) {
    }
    
    class Coodinator: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        
        var parent : Imagepicker
        
        init(parent : Imagepicker){
            self.parent = parent
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.show.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let image = info[.originalImage] as! UIImage
            let data = image.pngData()
            self.parent.image = data!
            self.parent.show.toggle()
        }
    }
}

class ImageSaver: NSObject{
    @Binding var showAlert: Bool
    
    init(_ showAlert: Binding<Bool>) {
        _showAlert = showAlert
    }
    
    func writeToPhotoAlbum(image: Data){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(didFinishSavingImage), nil)
    }
    
    @objc func didFinishSavingImage(_ image: Data, didFinishSavingWithError error: Error?,contextInfo: UnsafeRawPointer){
        
        if error != nil {
            print("保存に失敗しました")
        }else{
            showAlert = true
        }
    }
}

struct CameraView: View {
    
    @State var imageData : Data = .init(capacity:0)
    @State var source:UIImagePickerController.SourceType = .photoLibrary
    
    @State var isActionSheet = false
    @State var isImagePicker = false
    
    @State var showAlert = false
    
    var body: some View {
            NavigationStack{
                VStack(){
                        ZStack{
                            NavigationLink(
                                destination: Imagepicker(show: $isImagePicker, image: $imageData, sourceType: source),
                                isActive:$isImagePicker,
                                label: {
                                    Text("")
                                })
                            VStack{
                                if imageData.count != 0{
                                    Image(uiImage: UIImage(data: self.imageData)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 300, height: 500)
                                        .rotationEffect(.degrees(90))
                                        .padding()
                                }
                                Text("")
                                    .padding(.vertical, 20.0)
                                HStack(){
                                    Button(action: {
                                            self.source = .photoLibrary
                                            self.isImagePicker.toggle()
                                    }, label: {
                                        Text("写真選択")
                                            .padding(.trailing, 10.0)
                                    })
                                    
                                    Button(action: {
                                            self.source = .camera
                                            self.isImagePicker.toggle()
                                    }, label: {
                                        Text("撮影")
                                            .padding(.leading, 10.0)
                                    })
                                }
                                Button(action: {
                                    ImageSaver($showAlert).writeToPhotoAlbum(image: Data!)}){
                                    Text("保存")
                                }.alert(isPresented: $showAlert){
                                    Alert(title: Text("画像を保存しました"),message: Text(""),dismissButton: .default(Text("OK"),action:{
                                        showAlert = false
                                    }))
                                }
                            }
                        }
                }
            }
        .ignoresSafeArea(.all, edges: .top)
        
    }
}
