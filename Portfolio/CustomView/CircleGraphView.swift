//
//  CircleGraphView.swift
//  Portfolio
//
//  Created by 홍정민 on 3/16/25.
//

import UIKit

final class CircleGraphView: UIView {
    let circleLayer: CAShapeLayer = CAShapeLayer()
    var startAngle: CGFloat = (-(.pi) / 2)
    var endAngle: CGFloat = 0.0
    var values: [CGFloat] = [0, 0, 0]
    var currentIndex: Int = 0
    var myCenter = CGPoint.zero
    
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let colors: [UIColor] = [.stock1, .bond1, .etc1]
        
        let total = values.reduce(0, +)
        
        // -90도(12시 방향) 부터 시작하도록 구성
        var startAngle: CGFloat = (-(.pi) / 2)
        var endAngle: CGFloat = 0.0
        
        for (idx, value) in values.enumerated() {
            endAngle = (value / total) * (.pi * 2)
            
            let path = UIBezierPath()
            path.move(to: center)
            path.addArc(withCenter: center,
                        radius: 60,
                        startAngle: startAngle,
                        endAngle: startAngle + endAngle,
                        clockwise: true)
            
            
            colors[idx].set()
            path.fill()
            startAngle += endAngle
            path.close()
        }
        
        // 내부 원 설정
        let semiCircle = UIBezierPath(arcCenter: center,
                                      radius: 30,
                                      startAngle: 0,
                                      endAngle: (360 * .pi) / 180,
                                      clockwise: true)
        
        UIColor.darkBlack.set()
        semiCircle.fill()
    }
    
    func updateValues(_ values: [CGFloat]) {
        self.values = values
        setNeedsDisplay()
    }
}
