//
//  SearchViewController.swift
//  GglBksThumb01
//
//  Created by 中塚富士雄 on 2020/06/18.
//  Copyright © 2020 中塚富士雄. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos

class SearchViewController: UIViewController {
    @IBOutlet weak var thumnailImageView: UIImageView!
    
    @IBOutlet weak var SearchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        PHPhotoLibrary.requestAuthorization{
            (status) in
            
            switch(status){
                case .authorized: break
                case .denied: break
                case .notDetermined: break
                case .restricted: break
                
           }
       }
    }
//    検索ワードの値を元に画像を引っ張ってくる
//(~はhttp)~s://www.googleapis.com/books/v1/volumes?~~~&q=Marc+Franz
 // 配列は辞書型"items"で、その下にid,selfLink,title,authors,publisher,publishedDate,imageLinks{"thmbnail":"~://books.google.com/books/content?id=pfMRAQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"などがある。
    func getImages(keyword:String){
        
        //API Key AIzaSyD7kgXX7s8FgC7RxNrRlvPSGqySdKIh8vQ
    let url = "https://www.googleapis.com/books/v1/volumes?AIzaSyD7kgXX7s8FgC7RxNrRlvPSGqySdKIh8vQ&q=\(keyword)"
        
   //Alamofireでhttpリクエスト、値が返るのでJSON解析してImageView.imageに貼る
        
    }
    
    
    
}

