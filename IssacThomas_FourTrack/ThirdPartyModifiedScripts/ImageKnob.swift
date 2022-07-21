//
//  ImageKnob.swift
//  UniversalKnob
//
//  Created by Matthew Fecher on 10/19/17.
//  Copyright © 2017 Matthew Fecher. All rights reserved.
//  Available at https://github.com/analogcode/3D-Knobs
//  Modified by Issac Thomas on 20/11/2021

import UIKit

@IBDesignable
public class ImageKnob: Knob {
    
    @IBInspectable open var totalFrames: Int = 0 {
        didSet {
            createImageArray() //Declare the total number of frames in createArray
        }
    }

    @IBInspectable open var imageName: String = "knob01_" {
        didSet {
            createImageArray() //Declare name in createArray
        }
    }
    
  
    
    
    var imageView = UIImageView() //The knob image
    var imageArray = [UIImage]() //The knob image array

    var currentFrame: Int {
      return Int(Double(knobValue) * Double(totalFrames)) //Current knob
    }

    public override func layoutSubviews() {
      super.layoutSubviews()
      imageView.frame = CGRect( //Core Graphics Frame defines size of image frame
        x: 0,
        y: 0,
        width: self.bounds.width, // Width of the image box
        height: self.bounds.height) //Height of the image box
    }

    public override func draw(_ rect: CGRect) {
      super.draw(rect) //Creates a rectangle with the dimentions of the image
      if imageArray.indices.contains(currentFrame) {
        imageView.image = imageArray[currentFrame] //If current frame name is within the image folder, select that image
        
      }
  }
  
    // Init / Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
      createImageArray()
      addSubview(imageView) //Of type UIImageView
    }
    
   

    // Create Image Array
    func createImageArray() { //Replace with Single image
        imageArray.removeAll()
        for i in 0..<totalFrames {
            guard let image = UIImage(
              named: "\(imageName)\(i)",
              in: Bundle(for: type(of: self)),
              compatibleWith: traitCollection)
              else { continue }
            imageArray.append(image)
        }
        imageView.image = UIImage(named: "\(imageName)\(currentFrame)") //Select current image
    }
}

