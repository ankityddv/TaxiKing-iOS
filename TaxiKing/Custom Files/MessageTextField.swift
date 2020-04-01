//
//  MessageTextField.swift
//  TaxiKing
//
//  Created by ANKIT YADAV on 31/03/20.
//  Copyright © 2020 ANKIT YADAV. All rights reserved.
//

import UIKit

@IBDesignable
class MessageTextField: UITextField {
    
    @IBInspectable var cornerRad: CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRad
        }
    }

	@IBInspectable var borderWid: CGFloat = 0{
		didSet{
			layer.borderWidth = borderWid
		}
	}
	
	@IBInspectable var leftPadding: CGFloat = 0 {
        didSet{
            updateView()
        }
    }
    
    //Padding text and image in text field
    
    let padding = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: 5)
    let imagePadding = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 321)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: imagePadding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    //
    
    
    func updateView() {
        leftViewMode = .always
		
		var width = leftPadding + 20
		
		if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
			width = width + 5
		}
		
		let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
		//view.addSubview(imageView)
		
		//leftView = imageView
        
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor:tintColor])
    }
}


