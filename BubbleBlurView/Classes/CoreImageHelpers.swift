//
//  CoreImageHelpers.swift
//  Bubbles Floating Test App
//
//  Created by William Taylor on 11/4/19.
//  Copyright © 2019 William Taylor. All rights reserved.
//

import CoreImage

struct CoreImage {
    
    static func image(_ cgImage: CGImage) -> CoreImageManipulation {
        return CoreImageManipulation(image: CIImage(cgImage: cgImage))
    }
    
}

struct CoreImageManipulation {
    
    var image: CIImage
    
    func blur(withRadius radius: CGFloat) -> CoreImageManipulation {
        let blurFilter = CIFilter(name: "CIGaussianBlur")!
        blurFilter.setValue(image, forKey: kCIInputImageKey)
        blurFilter.setValue(radius, forKey: kCIInputRadiusKey)
        
        let output = blurFilter.outputImage!
        return CoreImageManipulation(image: output)
    }
    
    func changeExposure(toValue exposureValue: Double) -> CoreImageManipulation {
        let exposureFilter = CIFilter(name: "CIExposureAdjust")!
        exposureFilter.setValue(image, forKey: kCIInputImageKey)
        exposureFilter.setValue(exposureValue, forKey: kCIInputEVKey)
        
        let output = exposureFilter.outputImage!
        return CoreImageManipulation(image: output)
    }
    
    func changeBrightness(toValue brightnessValue: Double) -> CoreImageManipulation {
        let colorFilter = CIFilter(name: "CIColorControls")!
        colorFilter.setValue(image, forKey: kCIInputImageKey)
        colorFilter.setValue(brightnessValue, forKey: kCIInputBrightnessKey)
        
        let output = colorFilter.outputImage!
        return CoreImageManipulation(image: output)
    }
    
    func cropped(to rect: CGRect) -> CoreImageManipulation {
        return CoreImageManipulation(image: image.cropped(to: rect))
    }
    
    var cgImage: CGImage {
        get {
            return convertCIImageToCGImage(inputImage: image)!
        }
    }
    
    private func convertCIImageToCGImage(inputImage: CIImage) -> CGImage? {
        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(inputImage, from: inputImage.extent) {
            return cgImage
        }
        return nil
    }
    
}
