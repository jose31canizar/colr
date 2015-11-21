//
//  gameView.swift
//  Rood
//
//  Created by Jose Canizares on 10/25/15.
//  Copyright © 2015 rustic_republic. All rights reserved.
//

import UIKit



@IBDesignable
class GameView: UIView {
    
    @IBInspectable
    var color: UIColor = UIColor.lightGrayColor() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var lineWidth: CGFloat = 3 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var numberOfBlocks: Int = 3 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var blockSize : CGFloat = 50 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var blockSpacing : Int = 75 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    var CornerRadius: CGFloat {
        return 0
    }
    
    
    
    
    
    var Rectangle : CGRect = CGRect(origin: CGPoint.zero, size: CGSize.zero);
    
    
    
    
    var Center: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    
    
    
    
    var Paths = [UIBezierPath]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    /*
    func setPath(path: UIBezierPath?) {
        //adds to dictionary
        Paths.push(path)
        //changes model so you need setNeedDisplay
        setNeedsDisplay()
    }
    
    */
    
    
    func DrawBlock(originX: CGFloat, originY: CGFloat, size: CGFloat) -> UIBezierPath {
        
        
        
        Rectangle.origin.x = originX
        Rectangle.origin.y = originY
        Rectangle.size.width = size
        Rectangle.size.height = size
        
        let Path = UIBezierPath(roundedRect: Rectangle, cornerRadius: CornerRadius)
        
        
        Path.lineWidth = lineWidth
        
        
        
        return Path
        
        
    }
    
    
    func Squircle(x: Double) -> Double {
        
        //Wolfram: (6,000,000- x^4)^(1/4)
        let Bound = 10*pow(2, 0.75)*pow(3, 0.25)*sqrt(Double(5))
        let Num = 1000*(sqrt(Double(6)))
        
        let y3 = pow((Bound - Double(x)), 0.25)
        print(y3)
        let y4 = pow((Double(x) + Bound), 0.25)
        print(y4)
        let y5 = pow((pow(Double(x), 2) + Num), 0.25)
        print(y5)
        let y6 = y5*y4*y3
        print(y6)
        return y6
        
    }
    
    
    
    
    
    
    func DrawSquircle(posX: Double, posY: Double) -> UIBezierPath {
        
        let Path : UIBezierPath = UIBezierPath()
        let a = posX
        let b = posY
        var x = 0.0
        
        
        let point = CGPoint(x: Double(x) + a, y: Squircle(x) + b)
        Path.moveToPoint(point)
        
        //Domain of x:
        //10*sqrt(2)*pow(5, 0.25) ~21.147
        //207
        
        
        //Domain of x:
        //10*pow(10, 0.75) ~56.234
        //562.34
        //Wolfram: (10,000,000- x^4)^(1/4)
        
        //Domain of x:
        //10*2^(0.75)*3^(1/4)*sqrt(5)
        //49.4923
        //Wolfram: (6,000,000- x^4)^(1/4)
        //Domain = thisNumber * 10
        
        let Domain = 494
        
        for var index = 0; index < Domain; ++index
        {
            let point1 = CGPoint(x: Double(x) + a, y: Squircle(x) + b)
            Path.addLineToPoint(point1)
            
            x += 0.1
        }
        
        for var index = 0; index < Domain; ++index
        {
            let point1 = CGPoint(x: Double(x) + a, y: -1*Squircle(x) + b)
            Path.addLineToPoint(point1)
            
            x -= 0.1
        }
        
        
        //middle line in this for loop
        for var index = 0; index < Domain; ++index
        {
            let point1 = CGPoint(x: Double(x) + a, y: Squircle(x) + b)
            Path.addLineToPoint(point1)
            
            x -= 0.1
        }
        
        
        
        
        for var index = 0; index < Domain; ++index
        {
            let point1 = CGPoint(x: Double(x) + a, y: -1*Squircle(x) + b)
            Path.addLineToPoint(point1)
            
            x += 0.1
        }
        
    
        
        
        Path.lineWidth = lineWidth
        
        //squircle centered at a,b equation: (x-a)^4 + (y-b)^4 = r^4
        
        return Path
    }
    
    
    
    
    //creates an array of Block paths
    func ArrangeBlocks(numBlocks: Int)
    {
        
        
        for var i = 0; i < numBlocks; ++i {
            
            
            //appends the array of Paths depending on numberOfBlocks
            Paths.append(DrawBlock(Center.x, originY: Center.y - 250 + CGFloat(i*blockSpacing), size: blockSize))
            
        }
        
        
    }
    
    
    
    
    
    //Drawing
    
    override func drawRect(rect: CGRect) {
        
        
        ArrangeBlocks(numberOfBlocks)
        
        color.set()
        
        for var i = 0; i < numberOfBlocks; ++i {
            
            Paths[i].fill()
            Paths[i].stroke()
        }
        
       
        
        
        
    }
    
    
    
    
    
    
    
    
}

