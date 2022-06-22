//
//  ShapeLayer.swift
//  TestWork
//
//  Created by Вячеслав Терентьев on 22.06.2022.
//

import UIKit

extension UIViewController {
    
    func shapeLayer(shapeLayer: CAShapeLayer, path: UIBezierPath) {
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 6
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.strokeColor = UIColor.specialPink.cgColor
    }
}
