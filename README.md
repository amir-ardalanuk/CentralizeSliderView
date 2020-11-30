# Centralize SliderView (Swift - UIKit)

Designers make us in the trouble. Whit this SliderView you can set 0 in the center of Slider! Yeah, it's cool.

## Installation

you only need to add CentralizeSliderView.swift file in your project.

```bash
CentralizeSliderView.swift
```

## Usage

```Swift
class ViewController: UIViewController {

    @IBOutlet weak var slider: CentralizeSliderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider?.amplitude = 50 /// the range of slider if you set it 50 -> you will get -25...25
        slider?.thumbImage = UIImage()
        slider?.activeColor = .blue
        slider?.deavtiveColor = .red
        
        slider?.sliderDidChange = { [weak slider] value in
            if value > 10 {
                slider?.activeColor = .blue
            } else if value < 0 {
                slider?.activeColor = .red
            } else {
                slider?.activeColor = .lightGray
            }
        }
    }
}


```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.


## License
[MIT](https://choosealicense.com/licenses/mit/)
