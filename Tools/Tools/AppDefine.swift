//
//  AppDefine.swift
//  Tools
//
//  Created by HX on 2020/12/14.
//

import Foundation
import UIKit

// iPhone 5/5S/5C/SE         4.0英寸    320 x 568
// iPhone 6/6S/7/8/SE        4.7英寸    375 x 667
// iPhone 6/6S/7/8 Plus      5.5英寸    414 x 736
// iPhone X/XS/11Pro         5.8英寸    375 x 812
// iPhone XR/11              6.1英寸    414 x 896
// iPhone XS Max/11Pro Max   6.5英寸    414 x 896
// iPhone 12 mini            5.4英寸    375 x 812
// iPhone 12/12 Pro          6.1英寸    390 x 844
// iPhone 12 Pro Max         6.7英寸    428 x 926

//判断是否为iPhone
let kDeviceIsiPhone = (UI_USER_INTERFACE_IDIOM() == .phone)
//判断是否为iPad
let kDeviceIsiPad = (UI_USER_INTERFACE_IDIOM() == .pad)

//APP版本号
let kAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
//当前系统版本号
let kVersion = (UIDevice.current.systemVersion as NSString).floatValue
//检测用户版本号
let kiOS14Later = (kVersion >= 14.0)
let kiOS13Later = (kVersion >= 13.0)
let kiOS12Later = (kVersion >= 12.0)
let kiOS11Later = (kVersion >= 11.0)
let kiOS10Later = (kVersion >= 10.0)
let kiOS9Later = (kVersion >= 9.0)

let kScreenSize = UIScreen.main.responds(to: #selector(getter: UIScreen.nativeBounds)) ? CGSize(width: UIScreen.main.nativeBounds.size.width / UIScreen.main.nativeScale, height: UIScreen.main.nativeBounds.size.height / UIScreen.main.nativeScale) : UIScreen.main.bounds.size
let kScreenWidth = kScreenSize.width
let kScreenHeight = kScreenSize.height
let kScreenBounds = UIScreen.main.bounds

let kSCREEN_MAX_LENGTH = max(kScreenWidth, kScreenHeight)
let kSCREEN_MIN_LENGTH = min(kScreenWidth, kScreenHeight)

//机型判断
let kUI_IPHONE = (UIDevice.current.userInterfaceIdiom == .phone)
let kIPHONE4_0 = (kUI_IPHONE && kSCREEN_MAX_LENGTH == 568.0)
let kIPHONE4_7 = (kUI_IPHONE && kSCREEN_MAX_LENGTH == 667.0)
let kIPHONE5_5 = (kUI_IPHONE && kSCREEN_MAX_LENGTH == 736.0)
let kIPHONEX = (kUI_IPHONE && kSCREEN_MAX_LENGTH >= 812.0)// 刘海屏

let kStatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
let kNaviBarHeight: CGFloat = 44.0
let kTopHeight: CGFloat = kStatusBarHeight + kNaviBarHeight
let KTabBarHeight: CGFloat = 49.0
let KBottomHeight: CGFloat = kIPHONEX ? 83.0 : 49.0

//适配
func kScaleWidth(_ width: CGFloat) -> CGFloat {
    return width*kScreenWidth / 375
}
func kScaleHeigth(_ height: CGFloat) -> CGFloat {
    return height*kScreenHeight / 667
}

// 缩写
let kApplication = UIApplication.shared
let kAPPKeyWindow = kApplication.keyWindow
let kAppDelegate = kApplication.delegate
let kAppNotificationCenter = NotificationCenter.default
let kAppRootViewController = kAppDelegate?.window??.rootViewController

// 发送通知
func kNOTIFY_POST(name: String, object: Any) {
    return NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: object)
}
// 注册通知
func kNOTIFY_ADD(observer: Any, selector: Selector, name: String) {
    return NotificationCenter.default.addObserver(observer, selector: selector, name: Notification.Name(rawValue: name), object: nil)
}
// 移除通知
func kNOTIFY_REMOVE(observer: Any, name: String) {
    return NotificationCenter.default.removeObserver(observer, name: Notification.Name(rawValue: name), object: nil)
}

//字体
func kFontSize(_ a: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize:kScaleWidth(a))
}

//颜色
func kRGBAColor(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat,_ a: CGFloat) -> UIColor {
    return UIColor.init(red: r, green: g, blue: b, alpha: a)
}
func kRGBColor(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat) -> UIColor {
    return UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
}
func kHexColorA(_ HexString: String,_ a: CGFloat) ->UIColor {
    return UIColor.colorWith(hexString: HexString, alpha: a)
}
func kHexColor(_ HexString: String) ->UIColor {
    return UIColor.colorWith(hexString: HexString)
}
func kAutoColor(_ colorArr: Array<Any>) -> UIColor {
    if #available(iOS 13.0, *) {
        if UITraitCollection.current.userInterfaceStyle == .light {
            return colorArr.first as! UIColor
        }else{
            return colorArr.last as! UIColor
        }
    } else {
        return colorArr.first as! UIColor
    }
}

// 图片
func kImgNamed(_ imgName:String) -> UIImage {
    return UIImage.init(named: imgName)!
}

// 字符串是否为空
func kStringIsEmpty(_ str: String!) -> Bool {
    if str.isEmpty {
        return true
    }
    if str == nil {
        return true
    }
    if str.count < 1 {
        return true
    }
    if str == "(null)" {
        return true
    }
    if str == "null" {
        return true
    }
    return false
}
// 字符串判空 如果为空返回@“”
func kStringNullToEmpty(_ str: String) -> String {
    let resutl = kStringIsEmpty(str) ? "" : str
    return resutl
}
func kStringNullToReplaceStr(_ str: String,_ replaceStr: String) -> String {
    let resutl = kStringIsEmpty(str) ? replaceStr : str
    return resutl
}


// 数组是否为空
func kArrayIsEmpty(_ array: [String]) -> Bool {
    let str: String! = array.joined(separator: "")
    if str == nil {
        return true
    }
    if str == "(null)" {
        return true
    }
    if array.count == 0 {
        return true
    }
    if array.isEmpty {
        return true
    }
    return false
}

// 字典是否为空
func kDictIsEmpty(_ dict: NSDictionary) -> Bool {
    let str: String! = "\(dict)"
    if str == nil {
        return true
    }
    if str == "(null)" {
        return true
    }
    if dict .isKind(of: NSNull.self) {
        return true
    }
    if dict.allKeys.count == 0 {
        return true
    }
    return false
}

// LOG
func print<T>(message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line) {
    #if DEBUG
    //获取当前时间
    let now = Date()
    // 创建一个日期格式器
    let dformatter = DateFormatter()
    dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    // 要把路径最后的字符串截取出来
    let lastName = ((fileName as NSString).pathComponents.last!)
    print("\(dformatter.string(from: now)) [\(lastName)][第\(lineNumber)行] \n\t\t \(message)")
    #endif
}
