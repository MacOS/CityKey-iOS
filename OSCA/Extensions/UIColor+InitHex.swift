//
//  UIColor_Extension.swift
//  SmartCity
//
//  Created by Michael on 04.10.18.
//  Copyright © 2018 Michael. All rights reserved.
//

import UIKit

/**
 *
 * Extension that supports now hex values for UIColor
 *
 */
extension UIColor {

    convenience init(hexString: String, alpha: CGFloat? = 1.0) {
        let scanner = Scanner(string: hexString.replacingOccurrences(of: "#", with: ""))
        scanner.scanLocation = 0

        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: alpha!
        )
    }

    var hexString: String {
        let colorRef = cgColor.components
        let r = colorRef?[0] ?? 0
        let g = colorRef?[1] ?? 0
        let b = ((colorRef?.count ?? 0) > 2 ? colorRef?[2] : g) ?? 0
        let a = cgColor.alpha

        var color = String(
            format: "%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255))
        )

        if a < 1 {
            color += String(format: "%02lX", lroundf(Float(a)))
        }

        return color
    }

    var hexDecimalString: String {
            guard let components = cgColor.components, components.count >= 3 else {
                return "#FFFFFF" // Return white color as default
            }

            let r = Float(components[0])
            let g = Float(components[1])
            let b = Float(components[2])

            return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }

    func rgbStringFromColor(color: UIColor) -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return "rgba(\(Int(red * 255)), \(Int(green * 255)), \(Int(blue * 255)), \(alpha))"
    }

}
