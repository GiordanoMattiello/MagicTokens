//
//  UIImage+Extension.swift
//  MagicTokens
//
//  Created by Giordano Mattiello on 14/11/25.
//

import UIKit

extension UIImage {
    func pixelData() -> [UInt8]? {
        guard let cgImage = self.cgImage else { return nil }
        let size = CGSize(width: cgImage.width, height: cgImage.height)
        var pixels = [UInt8](repeating: 0, count: Int(size.width * size.height * 4))

        let context = CGContext(
            data: &pixels,
            width: Int(size.width),
            height: Int(size.height),
            bitsPerComponent: 8,
            bytesPerRow: Int(size.width) * 4,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )

        context?.draw(cgImage, in: CGRect(origin: .zero, size: size))
        return pixels
    }
}
