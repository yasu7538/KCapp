//
//  Syasin.swift
//  KC
//
//  Created by miuraken on 2022/12/01.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    //UIImageController（写真撮影）が表示されているかを管理
    @Binding var isShowSheet:Bool
    
    //撮影した写真を格納する変数
    @Binding var captureImage: UIImage?
    
    //Codinatorでコントローラのdelegateを管理
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        //ImagePickerView型の定数を用意
        let parent: ImagePickerView
        
        //イニシャライザ
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        //撮影が終わった時に呼ばれるdelegateメソッド,必ず必要
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            //撮影した写真をcaptureImageに保存
            if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.captureImage = originalImage
            }
            //sheetを閉じる
            parent.isShowSheet.toggle()
        }
        
        //キャンセルボタンが選択された時に呼ばれるdelegateメソッド、必ず必要
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            //sheetを閉じる
            parent.isShowSheet.toggle()
        }
    }//coordinatorここまで
    
    //Coordinatorを生成、SwiftUIによって自動的に呼び出し
    func makeCoordinator() -> Coordinator {
        //Coordinatorクラスのインスタンスを生成
        Coordinator(self)
    }
    
    //Viewを生成するときに実行
    func makeUIViewController(context: Context)->UIImagePickerController{
        //UIImagePickerControllerのインスタンスを生成
        let myImagePickerControler = UIImagePickerController()
        
        //sorceTypeにcameraを設定
        myImagePickerControler.sourceType = .camera
        
        //delgate設定
        myImagePickerControler.delegate = context.coordinator
        
        //UIImagePickerControllerを返す
        return myImagePickerControler
    }
    
    //Viewが更新された時に実行
    func updateUIViewController(_ uiViewController: UIImagePickerController,context: Context){
        //処理なし
    }//updateUIViewControllerここまで
    
    
    
}//ImagePickerViewここまで

class ImageSaver: NSObject{
    @Binding var showAlert: Bool
    
    init(_ showAlert: Binding<Bool>) {
        _showAlert = showAlert
    }
    func writeToPhotoAlbum(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(didFinishSavingImage), nil)
    }
    
    @objc func didFinishSavingImage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        if error != nil {
            print("保存に失敗しました")
        }else{
            showAlert = true
        }
    }
    
}

struct cameramove: View{
    //撮影した写真を保持する状態変数
    @State var captureImage: UIImage? = nil
    //撮影画面(sheet)の開閉状態を管理
    @State var isShowSheet = false
    
    @State var showAlert = false
    
    @State var viewOn = false
    
    var body: some View{
        NavigationStack{
            VStack{
                //スペース追加
                Spacer()
                
                //撮影した写真がある時
                if let captureImage{
                    //撮影写真を表示
                    Image(uiImage: captureImage)
                    //リサイズ
                        .resizable()
                    //アスペクト比（縦横比）を維持して画面に収める
                        .scaledToFit()
                }
                //スペース追加
                Spacer()
                Button(action: {
                    ImageSaver($showAlert).writeToPhotoAlbum(image: captureImage!)
                }){
                    Text("画像を保存する")
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
                }.alert(isPresented: $showAlert){
                    Alert(title: Text("画像を保存しました"),message: Text(""),dismissButton: .default(Text("OK"),action:{
                        showAlert = false
                    }))
                }
                
                //カメラ起動するボタン
                Button{
                    //ボタンタップした時のアクション
                    //カメラが利用可能かチェック
                    if UIImagePickerController.isSourceTypeAvailable(.camera){
                        print("カメラは利用できます")
                        //カメラが使えるなら、isShowSheetをTrue
                        isShowSheet.toggle()
                    }else{
                        print("カメラは利用できません")
                    }
                }label: {
                    //テキスト表示
                    Text("カメラを起動する")
                    
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
                }//カメラを起動するボタンここまで
                NavigationLink(destination: KCsakusei()){
                    Text("KC編集へ")
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
                //上下左右に余白を追加
                .padding()
                //sheetを表示
                //isPresentedで指定した状態変数がtrueのとき実行
                .sheet(isPresented: $isShowSheet){
                    //UIImagePickerController(写真撮影）を表示
                    ImagePickerView(isShowSheet: $isShowSheet, captureImage: $captureImage)
                }//カメラを起動するボタンのsheetはここまで
            }.navigationBarHidden(true)//VStackここまで
        }
    }//bodyここまで
}//cameramoveここまで

