//
//  Gif.swift
//  SwiftGif
//
//  Created by Arne Bahlo on 07.06.14.
//  Copyright (c) 2014 Arne Bahlo. All rights reserved.
//  Available at https://github.com/swiftgif/SwiftGif/blob/master/SwiftGifCommon/UIImage%2BGif.swift
//  Modified by Issac Thomas on 06/12/2021 for Tape App

import UIKit
import ImageIO

extension UIImageView {
    


    public func loadGif(name: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(name: name)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }

    @available(iOS 14.5, *)
    public func loadGif(asset: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(asset: asset)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }

}

extension UIImage {

    struct Holder {
        static var gifSpeed:Double = 1000.0
        static var source: CGImageSource? = nil
        static var frame: [UIImage]? = nil
    }
 
    var _source:CGImageSource {
        get {
            return Holder.source!
        }
        set(newValue) {
            Holder.source = newValue
        }
    }

    
    var _gifSpeed:Double {
        get {
            return Holder.gifSpeed
        }
        set(newValue) {
            Holder.gifSpeed = newValue
           
        }
    }
    
    var _frame:[UIImage] {
        get {
            return Holder.frame!
        }
        set(newValue) {
            Holder.frame = newValue
           
        }
    }
  
    
    public func gifSpeed(Speed: Double) -> UIImage?{
        let GifSpeed: Double = (Speed + 0.25) * 1.75 * 1000.0
        _gifSpeed = GifSpeed
        let Source = Holder.source
        
        return UIImage.animatedImageWithSource(source: Source)

       
        
        
        
    }
    public class func gif(data: Data) -> UIImage? {
        // Create source from data
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("SwiftGif: Source for the image does not exist")
            return nil
            
        }
        Holder.source = source
        //return nil
        return UIImage.animatedImageWithSource(source: source)
        
    }
    

 
    
    public class func gif(url: String) -> UIImage? {
        // Validate URL
        guard let bundleURL = URL(string: url) else {
            print("SwiftGif: This image named \"\(url)\" does not exist")
            return nil
        }

        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(url)\" into NSData")
            return nil
        }

        return gif(data: imageData)
    }

    public class func gif(name: String) -> UIImage? {
        // Check for existance of gif
        guard let bundleURL = Bundle.main
          .url(forResource: name, withExtension: "gif") else {
            print("SwiftGif: This image named \"\(name)\" does not exist")
            return nil
        }

        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }

        return gif(data: imageData)
    }

    @available(iOS 9.0, *)
    public class func gif(asset: String) -> UIImage? {
        // Create source from assets catalog
        guard let dataAsset = NSDataAsset(name: asset) else {
            print("SwiftGif: Cannot turn image named \"\(asset)\" into NSDataAsset")
            return nil
        }

        return gif(data: dataAsset.data)
    }

    internal class func delayForImageAtIndex(_ index: Int, source: CGImageSource?) -> Double {
        var delay = 0.1
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source!, index, nil)
        
        
        
        // Get dictionaries
        
        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
        defer {
            gifPropertiesPointer.deallocate()
        }
        let unsafePointer = Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()
        
        if CFDictionaryGetValueIfPresent(cfProperties, unsafePointer, gifPropertiesPointer) == false {
            return delay
        }

        let gifProperties: CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)

        // Get delay time
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }

        if let delayObject = delayObject as? Double, delayObject > 0 {
            delay = delayObject
        } else {
            delay = 0.1 // Make sure they're not too fast
        }

        return delay
    }

    internal class func gcdForPair(_ lhs: Int?, _ rhs: Int?) -> Int {
        var lhs = lhs
        var rhs = rhs
        // Check if one of them is nil
        if rhs == nil || lhs == nil {
            if rhs != nil {
                return rhs!
            } else if lhs != nil {
                return lhs!
            } else {
                return 0
            }
        }

        // Swap for modulo
        if lhs! < rhs! {
            let ctp = lhs
            lhs = rhs
            rhs = ctp
        }

        // Get greatest common divisor
        var rest: Int
        while true {
            rest = lhs! % rhs!

            if rest == 0 {
                return rhs! // Found it
            } else {
                lhs = rhs
                rhs = rest
            }
        }
    }

    internal class func gcdForArray(_ array: [Int]) -> Int {
        if array.isEmpty {
            return 1
        }

        var gcd = array[0]

        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }

        return gcd
    }

    public class func animatedImageWithSource(source: CGImageSource?) -> UIImage? {
        var images = [CGImage]()
        var delays = [Int]()
        var count =  1
        if source != nil{
            count = CGImageSourceGetCount(source!)
        }
        
        
        // Fill arrays
        for index in 0..<count {
            // Add image
            if source != nil{
                if let image = CGImageSourceCreateImageAtIndex(source!, index, nil) {
                    images.append(image)
                }
                // At it's delay in cs
                let delaySeconds = UIImage.delayForImageAtIndex(Int(index),
                    source: source)
                delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
            }
           

           
        }

        
        // Calculate full duration
        let duration: Int = {
            var sum = 0

            for val: Int in delays {
                sum += val
            }
            
            return sum
            }()
        var durationinit = 400
        
        if source != nil{
            durationinit = duration
        }
        // Get frames
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        
    
        var frame: UIImage
        var frameCount: Int
      
        for index in 0..<count {
            frame = UIImage(cgImage: images[Int(index)])
            frameCount = Int(delays[Int(index)] / gcd)

            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        
        if source != nil {
            Holder.frame = frames
        }
        let _frames = Holder.frame!
        let speed = Holder.gifSpeed
        let animDuration:Double = Double(durationinit)/Double(speed)
        print(animDuration)
        //print(speed)
        ///Speed of Gif
        let animation = UIImage.animatedImage(with: frames, duration: animDuration)
        
        return animation
    }

}
