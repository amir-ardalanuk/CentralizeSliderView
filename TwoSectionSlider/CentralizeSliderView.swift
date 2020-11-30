//
//  CentralizeSliderView.swift
//  TwoSectionSlider
//
//  Created by amir ardalan on 11/30/20.
//

import UIKit
class CentralizeSliderView: UIView {
    
    private var min = 0
    private var max = 100
    private var centerPosition: Float {
        return Float((self.max - self.min) / 2)
    }
    
    var thumbImage: UIImage? {
        set {
            return transparentSlider.setThumbImage(newValue, for: .normal)
        }
        get {
            return transparentSlider.currentThumbImage
        }
    }
    
    var value: Float {
        set {
            self.transparentSlider.value = newValue
        }
        get {
            return self.transparentSlider.value
        }
    }
    
    var activeColor: UIColor = UIColor.darkGray {
        didSet {
            self.setSliderTracksColor()
        }
    }
    
    var deavtiveColor: UIColor = UIColor.lightGray {
        didSet {
            self.setSliderTracksColor()
        }
    }
    
    var amplitude: Int {
        set {
            self.max = newValue
            self.defaultValues()
        }
        get {
            return max - min
        }
    }
    
    var sliderDidChange: ((Float) -> Void)?
    
    private lazy var leftSlider: UISlider = {
        let slider = UISlider()
        slider.isUserInteractionEnabled = false
        return slider
    }()
    
    private lazy var rightSlider: UISlider = {
        let slider = UISlider()
        slider.isUserInteractionEnabled = false
        return slider
    }()
    
    private lazy var transparentSlider: UISlider = {
        let slider = UISlider()
        slider.isContinuous = true
        return slider
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSliderToMainView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       addSliderToMainView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.frame != .zero {
            setSliderFrame()
            setSliderTracksColor()
            defaultValues()
        }
    }
    
    private func setSliderFrame() {
        transparentSlider.frame = self.bounds
        
        let sideSize = CGSize(width: self.bounds.width / 2, height: self.bounds.height)
        
        let rightFrame = CGRect(origin: self.bounds.origin, size: sideSize)
        rightSlider.frame = rightFrame
        
        let leftFrame = CGRect(origin: CGPoint(x: sideSize.width, y: self.bounds.origin.y), size: sideSize)
        leftSlider.frame = leftFrame
        
    }
    
    private func setSliderTracksColor() {
        self.transparentSlider.minimumTrackTintColor = UIColor.clear
        self.transparentSlider.maximumTrackTintColor = UIColor.clear
        self.rightSlider.minimumTrackTintColor = UIColor.clear
        self.rightSlider.maximumTrackTintColor = self.activeColor
        self.leftSlider.minimumTrackTintColor = self.activeColor
        self.leftSlider.maximumTrackTintColor = UIColor.clear
        
        rightSlider.setThumbImage(UIImage(), for: .normal)
        leftSlider.setThumbImage(UIImage(), for: .normal)
    }
    
    private func defaultValues() {
        self.transparentSlider.minimumValue = Float(self.min)
        self.transparentSlider.maximumValue = Float(self.max)
        self.rightSlider.minimumValue = Float(self.min)
        self.rightSlider.maximumValue = Float(centerPosition)
        
        self.leftSlider.minimumValue = Float(centerPosition)
        self.leftSlider.maximumValue = Float(self.max)
        
        self.rightSlider.value = Float(self.centerPosition)
        self.transparentSlider.value = Float(centerPosition)
    }
    
    private func addSliderToMainView() {
        self.addSubview(leftSlider)
        self.addSubview(rightSlider)
        self.addSubview(transparentSlider)
        self.transparentSlider.layer.zPosition = 1000
        
        transparentSlider.addTarget(self, action: #selector(self.updateValue(_:)), for: .valueChanged)
    }
    
    @objc func updateValue(_ sender: Any) {
        let value = transparentSlider.value
        if  value >= self.centerPosition {
            leftSlider.value = value
            rightSlider.value = self.centerPosition
        } else {
            rightSlider.value = value
            leftSlider.value = self.centerPosition
        }
        sliderDidChange?(value - centerPosition)
    }
}
