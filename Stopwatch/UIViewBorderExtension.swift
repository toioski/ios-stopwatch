//
//  UIViewBorderExtension.swift
//  Stopwatch
//
//  Created by Vittorio Morganti on 23/01/16.
//  Copyright © 2016 toioski. All rights reserved.
//

import UIKit

extension UIView {
    func addTopBorderWithColor(color: UIColor, andWidth borderWidth: CGFloat) {
        let border: UIView = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.FlexibleWidth, .FlexibleBottomMargin]
        border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth)
        self.addSubview(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, andWidth borderWidth: CGFloat) {
        let border: UIView = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.FlexibleWidth, .FlexibleTopMargin]
        border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth)
        self.addSubview(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, andWidth borderWidth: CGFloat) {
        let border: UIView = UIView()
        border.tag = 10
        border.backgroundColor = color
        border.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height)
        border.autoresizingMask = [.FlexibleHeight, .FlexibleRightMargin]
        self.addSubview(border)
    }
    
    func addRightBorderWithColor(color: UIColor, andWidth borderWidth: CGFloat) {
        let border: UIView = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.FlexibleHeight, .FlexibleLeftMargin]
        border.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height)
        self.addSubview(border)
    }
}
