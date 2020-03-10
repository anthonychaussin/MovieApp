//
//  UIImageViewExtension.swift
//  BandeAnnonce
//
//  Created by  on 05/03/2020.
//  Copyright © 2020 Anthony chaussin. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil { return }
            DispatchQueue.main.async(execute: { () -> Void in self.image = UIImage(data: data!) })
        }).resume()
    }
    @IBInspectable var cornerRadius: CGFloat {

     get{
          return layer.cornerRadius
      }
      set {
          layer.cornerRadius = newValue
          layer.masksToBounds = newValue > 0
          layer.masksToBounds = true
      }
    }

    @IBInspectable var borderWidth: CGFloat {
      get {
          return layer.borderWidth
      }
      set {
          layer.borderWidth = newValue
      }
    }

    @IBInspectable var borderColor: UIColor? {
      get {
          return UIColor(cgColor: layer.borderColor!)
      }
      set {
        layer.borderColor = newValue?.cgColor
      }
    }
}
