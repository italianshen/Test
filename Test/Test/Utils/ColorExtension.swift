//
//  ColorExtension.swift
//  Oceans
//
//  Created by admin on 2019/3/11.
//  Copyright © 2019 Phoenixtv. All rights reserved.
//

import UIKit
public extension UIColor{
    
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.rgb(red, green: green, blue: blue, alpha: 1)
    }
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat,alpha: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static func colorWithHex(_ hex: UInt) -> UIColor {
        let r: CGFloat = CGFloat((hex & 0xff0000) >> 16)
        let g: CGFloat = CGFloat((hex & 0x00ff00) >> 8)
        let b: CGFloat = CGFloat(hex & 0x0000ff)
        
        return rgb(r, green: g, blue: b)
    }
    
    static func colorWithHex(_ hex: UInt, _ alpha:CGFloat) -> UIColor {
        let r: CGFloat = CGFloat((hex & 0xff0000) >> 16)
        let g: CGFloat = CGFloat((hex & 0x00ff00) >> 8)
        let b: CGFloat = CGFloat(hex & 0x0000ff)
        
        return rgb(r, green: g, blue: b, alpha: alpha)
    }
    
    /// 字符串转颜色
    ///
    /// - Parameter colorStr: 字符串,如#FFFFFF 或者 如#1a000000
    /// - Returns: 返回颜色
    class func CSSHex(_ colorStr: String) -> UIColor {
        
        var cStr : String = colorStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if cStr.hasPrefix("#") {
            let index = cStr.index(after: cStr.startIndex)
            //cStr = cStr.substring(from: index)
            cStr = String(cStr[index...])
        }
   
        if cStr.count == 6 {
            return color(cStr: cStr)
        }else if cStr.count == 8 {
            return colorWithAlpha(cStr: cStr)
        }else {
            return UIColor.white
        }
    }
    
    /// 6位字符串转颜色
    ///
    /// - Parameter cStr: 6位字符串转没有涉及透明度的颜色
    /// - Returns: 返回颜色
    private class func color(cStr: String) -> UIColor {
        var color = UIColor.white
        
        let rRange = cStr.startIndex ..< cStr.index(cStr.startIndex, offsetBy: 2)
        //let rStr = cStr.substring(with: rRange)
        let rStr = String(cStr[rRange])
        
        let gRange = cStr.index(cStr.startIndex, offsetBy: 2) ..< cStr.index(cStr.startIndex, offsetBy: 4)
        //let gStr = cStr.substring(with: gRange)
        let gStr = String(cStr[gRange])
        
        let bIndex = cStr.index(cStr.endIndex, offsetBy: -2)
        //let bStr = cStr.substring(from: bIndex)
        let bStr = String(cStr[bIndex...])
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rStr).scanHexInt32(&r)
        Scanner(string: gStr).scanHexInt32(&g)
        Scanner(string: bStr).scanHexInt32(&b)
        
        color = UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
        
        return color
    }
    
    /// 8位字符串转颜色
    ///
    /// - Parameter cStr: 8位字符串转涉及透明度的颜色
    /// - Returns: 返回颜色
    private class func colorWithAlpha(cStr: String) -> UIColor {
        var color = UIColor.white
        
        let aRange = cStr.startIndex ..< cStr.index(cStr.startIndex, offsetBy: 2)
        let aStr = String(cStr[aRange])
        
        let rRange = cStr.index(cStr.startIndex, offsetBy: 2) ..< cStr.index(cStr.startIndex, offsetBy: 4)
        let rStr = String(cStr[rRange])
        
        let gRange = cStr.index(cStr.startIndex, offsetBy: 4) ..< cStr.index(cStr.startIndex, offsetBy: 6)
        let gStr = String(cStr[gRange])
        
        let bIndex = cStr.index(cStr.endIndex, offsetBy: -2)
        let bStr = String(cStr[bIndex...])
        
        var a:CUnsignedInt = 0, r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: aStr).scanHexInt32(&a)
        Scanner(string: rStr).scanHexInt32(&r)
        Scanner(string: gStr).scanHexInt32(&g)
        Scanner(string: bStr).scanHexInt32(&b)
        
        color = UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
        
        return color
    }
}
