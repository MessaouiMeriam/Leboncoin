//
//  AppStyle.swift
//  leboncoin
//
//  Created by Messaoui Meriam on 20/09/2022.
//

import Foundation
import UIKit

struct AppStyle {
    struct Color {
        static let mainOrange = UIColor(hexColor: "#fb5713")
        static let black = UIColor.black
        static let gray = UIColor.gray
        static let red = UIColor.red
        static let white = UIColor.white
        static let lightGray = UIColor(hexColor: "#dddddd")
        static let lightOrange = UIColor(hexColor: "#F6E5DD")
        
    }
    enum Font {
        case openSansMedium(size: CGFloat)
        case openSansRegular(size: CGFloat)
        case openSansBold(size: CGFloat)
        case openSansSemiBold(size: CGFloat)
        case relewayExtraBol(size: CGFloat)

        var font: UIFont {
            switch self {
            case .openSansMedium(let size):
                return UIFont(name: "OpenSans-Medium", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
            case .openSansRegular(let size):
                return UIFont(name: "OpenSans-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
            case .openSansBold(let size):
               return UIFont(name: "OpenSans-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
            case .openSansSemiBold(let size):
               return UIFont(name: "OpenSans-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
            case .relewayExtraBol(let size):
                return UIFont(name: "Raleway-ExtraBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
            }

        }
    }
}


