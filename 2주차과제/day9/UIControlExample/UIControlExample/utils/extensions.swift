//
//  extensions.swift
//  UIControlExample
//
//  Created by 1v1 on 2021/01/18.
//

import UIKit

extension UIColor{
    convenience init?(hexRGBA:String?){
        guard let rgba = hexRGBA, let val = Int(rgba.replacingOccurrences(of: "#", with: ""), radix: 16) else {
            return nil
        }
        
        self.init(red:CGFloat((val >> 24) & 0xff)/255.0, green:CGFloat((val >> 16) & 0xff)/255.0, blue:CGFloat((val >> 8) & 0xff)/255.0, alpha: CGFloat((val) & 0xff)/255.0)
    }
    convenience init?(hexRGB:String?){
        guard let rgb = hexRGB else {
            return nil
        }
        self.init(hexRGBA: rgb+"ff")
    }
}
