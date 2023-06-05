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
        boardingProgressView.setProgress(0.333, animated: true)
        boardingProgressView.layer.cornerRadius = 7
    }
    

    @IBAction func skipButtonPressed(_ sender: UIButton) {
        currentPage = 3
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
            self.performSegue(withIdentifier: SegueIdentifiers.fromOnboardingToAuth, sender: self)
        default:
            break
        }
    }
    
    private func prepareForSecondPage() {
        introductionLabel.text = TextCostants.secondOnBaordingText
        backgroundImageView.image = UIImage(named: "secondBoardingBackgroundImage")
        boardingProgressView.setProgress(0.666, animated: true)
        
    }
    
    private func prepareForThirdPage() {
        introductionLabel.text = TextCostants.thirdOnBaordingText
        backgroundImageView.image = UIImage(named: "thirdBoardingBackgroundImage")
        boardingProgressView.setProgress(1, animated: true)
    }
}
