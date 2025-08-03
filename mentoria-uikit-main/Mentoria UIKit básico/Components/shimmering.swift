//
//  shimmering.swift
//  Mentoria UIKit básico
//
//  Created by Vinicius Cabral on 03/08/25.
//

import Foundation
import UIKit

extension UIView {
    private static let shimmerLayerName = "shimmerLayer"

    func startShimmering() {
        // garante que o frame está atualizado
        layoutIfNeeded()

        let light = UIColor(white: 0.9, alpha: 1).cgColor
        let dark  = UIColor(white: 0.8, alpha: 1).cgColor

        let gradient = CAGradientLayer()
        gradient.name = UIView.shimmerLayerName
        gradient.frame = bounds
        gradient.cornerRadius = layer.cornerRadius
        gradient.colors   = [dark, light, dark]
        gradient.locations = [0, 0.5, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint   = CGPoint(x: 1, y: 0.5)
        layer.addSublayer(gradient)

        let anim = CABasicAnimation(keyPath: "locations")
        anim.fromValue    = [-1.0, -0.5, 0.0]
        anim.toValue      = [1.0, 1.5, 2.0]
        anim.duration     = 1.0
        anim.repeatCount  = .infinity
        gradient.add(anim, forKey: "shimmer")
    }

    func stopShimmering() {
        layer.sublayers?
            .filter { $0.name == UIView.shimmerLayerName }
            .forEach { $0.removeFromSuperlayer() }
    }
}
