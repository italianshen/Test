//
//  IFAlertController.swift
//
//
//  Created by Danny on 2018/6/19.
//  Copyright © 2018年 Danny. All rights reserved.
//

import Foundation

// MARK: ------               block               ---------
typealias funcVoidVoidBlock = () -> () //或者 () -> Void

typealias funcIntVoidBlock = (Int) -> () //或者 () -> Void

typealias funcStringVoidBlock = (String) -> ()


func IFAlertShow(_ title:String = "温馨提示",message:String,trueTitle:String = "确定",action:funcVoidVoidBlock?) {
    
    let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let trueAction = UIAlertAction(title: trueTitle, style: .cancel) { (_) in
        if action != nil{
            action!()
        }
    }
    alertVC.addAction(trueAction)
    topViewController().present(alertVC, animated: true, completion: nil)
}

//MARK: 一个按钮的弹窗
func IFAlertShowLeft(_ title:String,message:String,trueTitle:String = "确定",action:funcVoidVoidBlock?) {
    
    let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let trueAction = UIAlertAction(title: trueTitle, style: .cancel) { (_) in
        if action != nil{
            action!()
        }
    }
    let view = alertVC.view.subviews[0].subviews[0].subviews[0].subviews[0].subviews[0]
    //分别拿到title 和 message 可以分别设置他们的对齐属性
    //    let titleLabel = view.subviews[0] as? UILabel ?? UILabel()
    let messageLabel = view.subviews[1] as? UILabel ?? UILabel()
    messageLabel.textAlignment = .left
    alertVC.addAction(trueAction)
    topViewController().present(alertVC, animated: true, completion: nil)
}


//MARK: IFAlertShow有交互的弹窗
func IFAlertTwoItemShow(_ title:String = "温馨提示",message:String,trueTitle:String = "确定",cancleTitle:String = "取消",action:funcVoidVoidBlock?,cancle:funcVoidVoidBlock? = nil) {
    
    let alertVC = UIAlertController(title:title, message: message, preferredStyle: .alert)
    
    
    let trueAction = UIAlertAction.init(title: trueTitle, style: .default) { (a) in
        if action != nil{
            action!()
        }
    }
    
    let cancleAction = UIAlertAction.init(title: cancleTitle, style: .default) { (a) in
        if cancle != nil{
            cancle!()
        }
    }
    alertVC.addAction(cancleAction)
    alertVC.addAction(trueAction)
    topViewController().present(alertVC, animated: true, completion: nil)
}

//MARK: IFAlertShow有交互的弹窗
func IFAlertTwoItemNoMessageShow(_ title:String,trueTitle:String = "确定",cancleTitle:String = "取消",action:funcVoidVoidBlock?,cancle:funcVoidVoidBlock? = nil) {
    
    let alertVC = UIAlertController(title:title, message: nil, preferredStyle: .alert)
    
    let trueAction = UIAlertAction.init(title: trueTitle, style: .default) { (a) in
        if action != nil{
            action!()
        }
    }
    
    let cancleAction = UIAlertAction.init(title: cancleTitle, style: .cancel) { (a) in
        if cancle != nil{
            cancle!()
        }
    }
    alertVC.addAction(cancleAction)
    alertVC.addAction(trueAction)
    topViewController().present(alertVC, animated: true, completion: nil)
}


// MARK: 弹出请求用户授予app权限
func alertAuthorView(_ detail: String, ignoreAction: funcVoidVoidBlock?,setAction: funcVoidVoidBlock? = nil) {
    
    let alert = UIAlertController(title:"温馨提示", message: detail, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "取消", style: .default) { (_) in
        if ignoreAction != nil {
            ignoreAction!()
        }
    }
    let setAction = UIAlertAction(title:"设置", style: .default, handler: { (_) in
        if let url = URL(string: UIApplication.openSettingsURLString) {
            applicationOpenURL(url)
            if setAction != nil {
                setAction!()
            }
        }
    })
    alert.addAction(cancelAction)
    alert.addAction(setAction)
    topViewController().present(alert, animated: true, completion: nil)
}

let Application = UIApplication.shared
//let rootWindow:UIWindow! = (Application.delegate?.window)!

// MARK: UIApplication
func applicationKeyWindow() -> UIWindow {
    return Application.keyWindow ?? UIWindow()
}

func applicationRootViewController() -> UIViewController {
    return applicationKeyWindow().rootViewController ?? UIViewController()
}

func rootWindow() -> UIWindow {
    return (Application.delegate?.window)! ?? UIWindow()
}


func applicationOpenURL(_ url: URL) {
    if Application.canOpenURL(url) {
        if #available(iOS 10.0, *) {
            Application.open(url, options: [:], completionHandler: nil)
        } else {
            Application.openURL(url)
        }
    } else {
        
    }
}


//获取当前显示视图
func topViewController() -> UIViewController {
    return topViewControllerWithRootViewController(applicationRootViewController())
}

private func topViewControllerWithRootViewController(_ rootViewController:UIViewController) -> UIViewController {
    if rootViewController.isKind(of: UINavigationController.self) {
        return  topViewControllerWithRootViewController((rootViewController as! UINavigationController).visibleViewController!)
    }else if rootViewController.isKind(of: UITabBarController.self){
        return topViewControllerWithRootViewController((rootViewController as! UITabBarController).selectedViewController!)
    }else{
        return rootViewController
    }
}
