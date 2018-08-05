//
//  QRCodeVC.swift
//  projectManager_ShopOwner
//
//  Created by 黃恩祐 on 2018/7/8.
//  Copyright © 2018年 ENYUHUANG. All rights reserved.
//

import UIKit

class QRCodeVC: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    var QRcode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getSelfInfoRequest { (selfName) in
            self.title = selfName
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let QRCode = self.QRcode else { return }
        self.imgView.image = self.generateQRCode(from: QRCode)
    }

    // String -> QRcode
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
}
