//
//  UIImage+Extension.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 11/11/25.
//

import UIKit

extension UIImage {
    func withRoundedCorners(radius: CGFloat) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath
        
        context?.addPath(path)
        context?.clip()
        
        draw(in: rect)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
