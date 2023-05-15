//
//  ViewController.swift
//  BlackJacko
//
//  Created by Joseph Wong on 7/2/2023.
//

import UIKit

class ViewController: UIViewController {

    var choices = false
    
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var ImagePop: UIImageView!
    // Gif Images
    let giphyImages = [UIImage(named: "m1"),
                      UIImage(named: "m2"),
                      UIImage(named: "m3"),
                      UIImage(named: "m4"),
                      UIImage(named: "m5"),
                       UIImage(named: "m6"),
                       UIImage(named: "m7"),
                       UIImage(named: "m8"),
                       UIImage(named: "m9"),
                       UIImage(named: "m10"),
                       UIImage(named: "m11"),
                       UIImage(named: "m12"),
                       UIImage(named: "m13"),
                       UIImage(named: "m14"),
                       UIImage(named: "m15"),
                       UIImage(named: "m16"),
                       UIImage(named: "m17")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // removes the nil values in the list in order for it to be utilized (no err)
        let usableImages = giphyImages.compactMap { $0 }
        
        // anim set-up
        ImageView.animationImages = usableImages
        ImageView.animationDuration = 0.5
        ImageView.animationRepeatCount = 0
        ImageView.startAnimating()
        
        ImagePop.isHidden = true;
    }
    @IBAction func InstructionsClicked(_ sender: Any) {
        
        //choices so that the image is able to reactivate/ activate on button press
        if choices == false{
            ImagePop.isHidden = false
            choices = true
        }
        else{
            ImagePop.isHidden = true
            choices = false
        }
    }
    

}

