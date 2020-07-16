//
//  PLAlphaThresholdView.swift
//  PLAlphaThreshold
//
//  Created by 彭磊 on 2020/7/16.
//

import UIKit

public class PLAlphaThresholdView: UIView {

    lazy var btn: UIButton = {
            let btn = UIButton()
            btn.backgroundColor = UIColor.orange
            btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
            return btn
        }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(white: 0, alpha: 0.5)
        addSubview(btn)
        btn.frame = CGRect(x: 40, y: 150, width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.height - 300)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btnClick() {
        print("你瞅啥--透明层的按钮")
    }
        
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
            let alpha = alphaOfPoint(point: point)
            // 处于当前view及sub view的点击位置颜色的alpha值大于阈值，则事件不穿透，否则就透传
            if alpha > 0.6 {
                return true
            }else {
                return false
            }
        }
        
    func alphaOfPoint(point: CGPoint) -> CGFloat {
        return alphaOfPointFromLayer(point: point)
    }
    
    func alphaOfPointFromLayer(point: CGPoint) -> CGFloat {
        var pixel = [UInt8](repeatElement(0, count: 4))
//        var pixel: [UInt8] = [0, 0, 0, 0]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        context?.setBlendMode(.copy)
        context?.translateBy(x: -point.x, y: -point.y)
        if let context = context {
            layer.render(in: context)
        }
        let alpha = CGFloat(pixel[3]) / CGFloat(255.0)
        
        return alpha
    }
        
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.point(inside: point, with: event) {
            return super.hitTest(point, with: event)
        }
        guard isUserInteractionEnabled, !isHidden, alpha > 0 else {
            return nil
        }

        for subview in subviews.reversed() {
            let convertedPoint = subview.convert(point, from: self)
            if let hitView = subview.hitTest(convertedPoint, with: event) {
                return hitView
            }
        }
        return nil
    }

}
