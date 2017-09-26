//
//   ImageLoader.swift
//  Rus_dialog
//
//  Created by Игорь Дмитриев on 26.07.17.
//  Copyright © 2017 Игорь Дмитриев. All rights reserved.
//

import Foundation
import UIKit

class UIImageViewAsync: UIImageView
{

    public init()
    {
        super.init(frame: CGRect())
    }

    override init(frame:CGRect)
    {
        super.init(frame:frame)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    func getDataFromUrl(url:String, completion: @escaping ((_ data: NSData?) -> Void)) {
        URLSession.shared.dataTask(with: (NSURL(string: url)! as URL) as URL) { (data, response, error) in
            completion(NSData(data: data!))
        }.resume()
    }

    func downloadImage(url:String){
        getDataFromUrl(url: url) { data in
            DispatchQueue.main.async() {
                self.contentMode = UIViewContentMode.scaleAspectFill
                self.image = UIImage(data: data! as Data)
            }
        }
    }
}
