//
//  ViewController.swift
//  TwoSectionSlider
//
//  Created by amir ardalan on 11/30/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: CentralizeSliderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider?.amplitude = 50
        slider?.sliderDidChange = { [weak slider] value in
            if value > 10 {
                slider?.activeColor = .blue
            } else if value < 0 {
                slider?.activeColor = .red
            } else {
                slider?.activeColor = .lightGray
            }
        }
        // Do any additional setup after loading the view.
    }


}


