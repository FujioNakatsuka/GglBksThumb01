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
 
    //Boketeでは  @IBOutlet weak var commentTextView: UITextView!が入りますが、今回はコメントはShareVCで入力します
    
    var count = 0
    
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
        
        getImages(keyword: "Franz + Marc")
        
        
    }
//    検索ワードの値を元に画像を引っ張ってくる
//(~はhttp)~s://www.googleapis.com/books/v1/volumes?~~~&q=Marc+Franz
 //⭐️次の説明で正しいでしょうか？ 配列は辞書型"items"で、その下にid,selfLink,title,authors,publisher,publishedDate,imageLinks{"thumbnail":"~://books.google.com/books/content?id=pfMRAQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"などがある。
    
    
    func getImages(keyword:String){
        
        //API Key AIzaSyD7kgXX7s8FgC7RxNrRlvPSGqySdKIh8vQ
    let url = "https://www.googleapis.com/books/v1/volumes?AIzaSyD7kgXX7s8FgC7RxNrRlvPSGqySdKIh8vQ&q=\(keyword)"
        
   //Alamofireでhttpリクエスト、値が返るのでJSON解析してImageView.imageに貼る
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{(responce) in
            switch responce.result{
                
            case .success:
                let json:JSON = JSON(responce.data as Any)
                var imageString = json["items"][self.count]["volumeInfo"]["imageLinks"]["thumbnail"]
                
                //⭐️上記は見よう見真似で書きましたが、この書き方で良いでしょうか？itemsの下の第２階層はid,selfLink,volumeInfoなどがあり、volumeInfoの下の第3階層にtitle,authors,imageLinks、そしてimageLinksの下の第4階層にthumbnailがあって、本の表紙のurl（例えば"〜（〜はhttp）://books.google.com/books/content?id=pfMRAQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"）ただしpfMRAQAAQBAJはBoogleBooksが各書籍に割り当てたidです
                
                if imageString == nil{
                              
                              imageString = json["items"][0]["thumnail"].string
                
                self.thumnailImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                //⭐️Cannot convert value of type 'JSON' to expected argument typeと怒られています！　そして'imageString'には、なぜselfが付くのか？クロージャーの中だからとは？？？？そして何よりもJSON自体を理解できていない。。。
                }else{
                    
                    self.thumnailImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                    
                }
                
           self.thumnailImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                    
            case .failure(let error):
                
                print(error)
                
            }
                
         }
            
      }
    
    @IBAction func nextBook(_ sender: Any) {
        
        count = count + 1
        
        if SearchTextField.text == ""{
            
           getImages(keyword: "Franz + Marc")
            
        }
        else{
            
            getImages(keyword: SearchTextField.text!)
            
        }
    }
    
    @IBAction func searchAction(_ sender: Any) {
        
        self.count = 0
        
        
        if SearchTextField.text == ""{
            
           getImages(keyword: "Franz + Marc")
            
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
    
    
    



