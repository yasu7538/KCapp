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

struct CameraView: View {
    
    @State var imageData : Data = .init(capacity:0)
    @State var source:UIImagePickerController.SourceType = .photoLibrary
    
    @State var isActionSheet = false
    @State var isImagePicker = false
    
    var body: some View {
            NavigationStack{
                VStack(spacing:0){
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
                                        .frame(height: 250)
                                        .cornerRadius(15)
                                        .padding()
                                }
                                HStack(spacing:30){
                                    Button(action: {
                                            self.source = .photoLibrary
                                            self.isImagePicker.toggle()
                                    }, label: {
                                        Text("Upload")
                                    })
                                    Button(action: {
                                            self.source = .camera
                                            self.isImagePicker.toggle()
                                    }, label: {
                                        Text("Take Photo")
                                    })
                                }
                            }
                        }
                }
                .navigationBarTitle("Home", displayMode: .inline)
            }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.primary.opacity(0.06).ignoresSafeArea(.all, edges: .all))
    }
}
