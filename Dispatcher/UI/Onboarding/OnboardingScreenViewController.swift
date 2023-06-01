//
//  OnboardingScreenViewController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 01/06/2023.
//

import UIKit

class OnboardingScreenViewController: UIViewController {

    @IBOutlet weak var dispatcherLabel: UILabel!
    @IBOutlet weak var boardingProgressView: UIProgressView!
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        introductionLabel.text = TextCostants.firstOnBaordingText
       
    }
    

    @IBAction func skipButtonPressed(_ sender: UIButton) {
        prepareForThirdPage()
    }
    
  
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        currentPage += 1
        prepareForNextOnboardingPage()
    }
    
    private func prepareForNextOnboardingPage() {
        switch currentPage {
        case 2:
            prepareForSecondPage()
        case 3:
            prepareForThirdPage()
        case 4:
            self.performSegue(withIdentifier: SegueIdentifiers.fromOnboardingToHomepage, sender: self)
        default:
            break
        }
    }
    
    private func prepareForSecondPage() {
        introductionLabel.text = TextCostants.secondOnBaordingText
        backgroundImageView.image = UIImage(named: "secondBoardingBackgroundImage")
        //boardingProgressView.
        
    }
    
    private func prepareForThirdPage() {
        introductionLabel.text = TextCostants.thirdOnBaordingText
        backgroundImageView.image = UIImage(named: "thirdBoardingBackgroundImage")
    }
    

}
