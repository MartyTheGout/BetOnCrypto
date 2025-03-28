//
//  UnderlinedSegmentedControl.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/9/25.
//

import UIKit
import SnapKit

final class UnderlinedSegmentedControl : UISegmentedControl {
    
    private lazy var underline: UIView = {
        let width = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let height = 2.0
        let xPosition = CGFloat(self.selectedSegmentIndex * Int(width))
        let yPosition = self.bounds.size.height - 2.0
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        let view = UIView(frame: frame)
        view.backgroundColor = DesignSystem.Color.Renewal.tint.inUIColor()
        self.addSubview(view)
        return view
    }()
    
    private var fixedBottmline: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystem.Color.Tint.submain.inUIColor()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDesign()
        addFixedUnderLine()
    }
    override init(items: [Any]?) {
        super.init(items: items)
        configureDesign()
        addFixedUnderLine()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureDesign(){
        removeBackground()
        setDiverImage()
    }
    
    private func removeBackground() {
        let image = UIImage()
        self.setBackgroundImage(image, for: .normal, barMetrics: .default)
        self.setBackgroundImage(image, for: .selected, barMetrics: .default)
        self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
    }
    
    private func setDiverImage() {
        let image = UIImage()
        self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    
    private func addFixedUnderLine() {
        self.addSubview(fixedBottmline)
        
        fixedBottmline.snp.makeConstraints {
            $0.top.equalTo(self.snp.bottom).offset(-1)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(self.selectedSegmentIndex)
        UIView.animate(
            withDuration: 0.1,
            animations: {
                self.underline.frame.origin.x = underlineFinalXPosition
            }
        )
    }
}

