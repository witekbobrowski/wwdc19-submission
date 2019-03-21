//
//  CircullarProgressView.swift
//  Quacker
//
//  Created by Witek Bobrowski on 20/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class CircullarProgressView: UIView {

    private let gradientLayer: CAGradientLayer =  create {
        $0.type = .conic
        $0.startPoint = CGPoint(x: 0.5, y: 0.5)
    }
    private let shapeLayer: CAShapeLayer = create {
        $0.fillColor = UIColor.clear.cgColor
        $0.strokeColor = UIColor.black.cgColor
        $0.lineWidth = 4
        $0.lineCap = .round
    }
    private let pointerShapeLayer: CAShapeLayer = create {
        $0.fillColor = UIColor.clear.cgColor
        $0.strokeColor = StyleSheet.Color.backgroundColor.cgColor
        $0.lineWidth = 1.5
    }

    var colors = [UIColor]() {
        didSet {
            gradientLayer.colors = colors.map { $0.cgColor }
        }
    }

    var value: Double? = 0 { didSet { updatePointer(for: value) } }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        shapeLayer.path = getMainPath(in: bounds)
        updatePointer(for: value)
    }

}

extension CircullarProgressView {

    private func updatePointer(for value: Double?) {
        guard let value = value else { return shapeLayer.path = UIBezierPath().cgPath }

        let lineWidth: CGFloat = pointerShapeLayer.lineWidth
        let radius: CGFloat = shapeLayer.lineWidth/2 + lineWidth

        pointerShapeLayer.path = getPointerPath(lineWidth: lineWidth, radius: radius)
        pointerShapeLayer.frame = CGRect(
            origin: getPointerOrigin(value: value, lineWidth: lineWidth, radius: radius),
            size: CGSize(width: radius * 2, height: radius * 2)
        )
    }

    private func setupView() {
        [gradientLayer, pointerShapeLayer].forEach(layer.addSublayer)
        gradientLayer.mask = shapeLayer
    }

    private func getMainPath(in frame: CGRect) -> CGPath {
        let path = UIBezierPath()
        path.addArc(
            withCenter: CGPoint(x: frame.midX, y: frame.midY),
            radius: frame.width/2 - 2,
            startAngle: .pi * 0.8,
            endAngle: .pi * 0.2,
            clockwise: true
        )
        return path.cgPath
    }

    private func getPointerPath(lineWidth: CGFloat, radius: CGFloat) -> CGPath {
        let path = UIBezierPath()
        path.addArc(
            withCenter: CGPoint(x: radius, y: radius),
            radius: radius - lineWidth/2,
            startAngle: 0,
            endAngle: .pi * 2,
            clockwise: true
        )
        return path.cgPath
    }

    private func getPointerOrigin(value: Double, lineWidth: CGFloat, radius: CGFloat) -> CGPoint {

        let angle: CGFloat = .pi * 0.8 + (.pi * 1.4) * CGFloat(value)

        let x = bounds.midX + (bounds.width/2 - 2) * cos(angle)
        let y = bounds.midY + (bounds.height/2 - 2) * sin(angle)
        return CGPoint(x: x - radius, y: y - radius)
    }

}
