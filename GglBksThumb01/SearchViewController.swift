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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var publishersLabel: UILabel!
    @IBOutlet weak var publishedDate: UILabel!

    //Boketeでは  @IBOutlet weak var commentTextView: UITextView!が入りますが、今回はコメントはShareVCで入力します
    
    var count = 0
    var i = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        PHPhotoLibrary.requestAuthorization{
            (status) in
            
            
            //Caution for Fix:Switch covers known cases, but 'PHAuthorizationStatus' may have additional unknown values, possibly added in future versions.Handle unknown values using "@unknown default"
            switch(status){
                case .authorized: break
                case .denied: break
                case .notDetermined: break
                case .restricted: break
                
           }
       }
  
        //部分一致による検索で、Field内の空白は不可。日本語を検索できないのはなぜ？検索エンジン自体の設定か？Leonardo Da Vinciで試すと実に面白しい
        //FranzMarcで検索できるのは例外か？
        SearchTextField.text = "FranzMarc"
        getImages(keyword: "FranzMarc")
        
        
    }
//    検索ワードの値を元に画像を引っ張ってくる

    func getImages(keyword:String){
        
        //API Key AIzaSyD7kgXX7s8FgC7RxNrRlvPSGqySdKIh8vQ
    let url = "https://www.googleapis.com/books/v1/volumes?AIzaSyD7kgXX7s8FgC7RxNrRlvPSGqySdKIh8vQ&q=\(keyword)&maxResults=30"
        
   //Alamofireでhttpリクエスト、値が返るのでJSON解析してImageView.imageに貼る
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{(responce) in
            switch responce.result{
                
            case .success:
                let json:JSON = JSON(responce.data as Any)
//                print(json.debugDescription)
                
//                var imageString = から変更。理由は？
                var imageString =
                json["items"][self.count]["volumeInfo"]["imageLinks"]["thumbnail"].string
         //　　　　　　　　　thumbnailがない時のためのif文だったが、、、どう書く？
         //ないものはねだりません。代わりにJokerを入れま〜〜〜す😁
                
       if imageString?.isEmpty ?? true{
        imageString = "http://books.google.com/books/content?id=-vg0DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
        }

                let title =
                json["items"][self.count]["volumeInfo"]["title"].string

//著者名は複数存在する場合があるので最初の著者名を取得。[0]がない場合、著者名は表示されない。なぜ？
                let authors =
                json["items"][self.count]["volumeInfo"]["authors"][0].string

//                共著者名を並べたいのでfor文で切り分けを行う方法がまだわかっていない
//                i = json["items"][self.count]["volumeInfo"]["authors"].count
//                for q in 0...i{
//                    self.authorsLabel = json["items"][self.count]["volumeinfo"]["autohrs"][q].string!
//                    self.authors = self.authors + "," +self.authors
//                    if self.authorsLabel.isEmty == true{
//                        return
//                    }
//                }
                
                let publisher =
                json["items"][self.count]["volumeInfo"]["publisher"].string

                let publishedDate =
                json["items"][self.count]["volumeInfo"]["publishedDate"].string

                self.titleLabel.text = title
                self.authorsLabel.text = authors
                self.publishersLabel.text = publisher
                self.publishedDate.text = publishedDate
                self.thumnailImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                
            
            case .failure(let error):
                
                print(error)
                
            }
                
         }
            
      }
    
    @IBAction func nextBook(_ sender: Any) {
        
        count = count + 1
        
        if SearchTextField.text == ""{
            
           getImages(keyword: "FranzMarc")
            
        }
        else{
            
            getImages(keyword: SearchTextField.text!)
            
        }
    }
    
    @IBAction func searchAction(_ sender: Any) {
        
        self.count = 0
        
        
        if SearchTextField.text == ""{
            
           getImages(keyword: "FranzMarc")
            
        }
        else{
            
            getImages(keyword: SearchTextField.text!)
            
        }
        
    }
    
    @IBAction func next(_ sender: Any) {
        
        performSegue(withIdentifier: "next", sender: nil)
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let shareVC = segue.destination as? ShareViewController
        
        shareVC?.resultImage = thumnailImageView.image!
    //Bokete ではshareVC?.commentString = commentTextView.textが入りますが今回はメモ書きはShareViewに配置するmemoLabelにメモ書きを入れるので、SearchVCでは不要になります。
    }
    
}
    
    
    



