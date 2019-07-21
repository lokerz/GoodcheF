//
//  RecipeLiveViewController.swift
//  GoodcheF
//
//  Created by Ridwan Abdurrasyid on 01/07/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit
import Speech
import AVKit

class RecipeLiveViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let layout = UICollectionViewFlowLayout()
    //    speech recognizer variable
    let audioEngine = AVAudioEngine()
    let speechRecognizer : SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask : SFSpeechRecognitionTask?
    //
    
    @IBOutlet weak var liveCollectionView: UICollectionView!
    
    var judul = "Ayam Kremes"
    var steps = [["1","2","3"],["4","5","6"],["7","8"],["9","10"],["11"],["12","13"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBottomControls()
        
        liveCollectionView.backgroundColor = .clear
        liveCollectionView.isPagingEnabled = true
        setupNavbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recordAndRecognizeSpeech()
    }
    
    func setupNavbar(){
        navigationController?.navigationBar.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return steps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! LiveCollectionViewCell
        
        cell.judulResep.text = judul
        var stepMasak = ""
        for step in steps[indexPath.row]{
            stepMasak.append("\(step)\n\n")
        }
        cell.caraMasakResep.text = stepMasak
        cell.caraMasakResep.backgroundColor = .clear
        
        cell.stepResepKe.text = "Step ke \(indexPath.row + 1) dari \(steps.count)"
        
        cell.judulResep.textColor = .chocoColor
        cell.stepResepKe.textColor = .lightchocoColor
        cell.caraMasakResep.textColor = .darkchocoColor
        
        cell.cardBackground.backgroundColor = .yellowColor
        cell.cardBackground.layer.cornerRadius = 20.0
    
        
        return cell
    }
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = steps.count
        
        pc.currentPageIndicatorTintColor = .darkchocoColor
        pc.isEnabled = false
        pc.pageIndicatorTintColor = .creamColor
        return pc
    }()
    
    fileprivate func setupBottomControls() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [pageControl])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        print("clicked")
        navigationController?.popViewController(animated: true)
    }
    
}


extension RecipeLiveViewController : SFSpeechRecognizerDelegate{
    
    func recordAndRecognizeSpeech(){
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.request.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print("error")
        }
        
        guard let myRecognizer = SFSpeechRecognizer() else {return}
        if !myRecognizer.isAvailable {return}
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {
                let bestString = result.bestTranscription.formattedString
                self.title = bestString
            }else if let error = error {
                print(error)
            }
        })
        
    }
    
    
}
