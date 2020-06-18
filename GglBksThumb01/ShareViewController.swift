//
//  ShareViewController.swift
//  GglBksThumb01
//
//  Created by 中塚富士雄 on 2020/06/18.
//  Copyright © 2020 中塚富士雄. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    
    var resultImage = UIImage()
    var commentString = String()
    
    var screenShotImage = UIImage()
    
    @IBOutlet weak var resultImageVIew: UIImageView!
 
    @IBOutlet weak var commentTextView: UITextView!
    
      
      override func viewDidLoad() {
          super.viewDidLoad()
      
        resultImageVIew.image = resultImage
        
        commentTextView.text = ""
        
      }

//    @IBAction func commentTextField(_ sender: Any) {
     func commenttextFieldShouldReturn(commentTextField: UITextField) -> Bool {
        commentTextView.text = commentTextField.text
        return true
        
        
//    }
    }

    @IBAction func share(_ sender: Any) {
       
   //スクリーンショットを撮る
     takeScreenShot()
        
     let scsho = [screenShotImage] as [Any]

    //アクティビティビューに乗せてシェアする
     let activityVC = UIActivityViewController(activityItems: scsho, applicationActivities: nil )
        
     present(activityVC, animated: true, completion: nil)
       
    }
    
        func takeScreenShot() {
        
        let  width = CGFloat(UIScreen.main.bounds.size.width)
        let height = CGFloat(UIScreen.main.bounds.size.height/1.3)
        let size = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
    }
    @IBAction func back(_ sender: Any) {
    
    dismiss(animated: true, completion: nil)
    
    }
  
}
