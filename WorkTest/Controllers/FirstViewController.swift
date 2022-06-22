//
//  FirstViewController.swift
//  TestWork
//
//  Created by Вячеслав Терентьев on 22.06.2022.
//

import UIKit

class FirstViewController: UIViewController {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundFirstController")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let leftTimer: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "leftTimer")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let leftTimerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .specialPink
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     private let rightTimer: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rightTimer")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
     private let rightTimerLabel: UILabel = {
        let label = UILabel()
         label.textColor = .specialPink
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var overlayView: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "tapButton"), for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(tapButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var timer = Timer()
    private var durationTimer = 30
    private let leftLineTimer = CAShapeLayer()
    private let rightLineTimer = CAShapeLayer()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        animationRightTimer()
        animationLeftTimer()
//        animateButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        startTimer()
    }
    
    private func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(overlayView)
        view.addSubview(leftTimer)
        view.addSubview(leftTimerLabel)
        view.addSubview(rightTimer)
        view.addSubview(rightTimerLabel)
        view.addSubview(tapButton)
    }
    
    @objc private func tapButtonTapped() {
        let secondViewController = SecondViewController()
        secondViewController.modalPresentationStyle = .fullScreen
        present(secondViewController, animated: true)
    }
    
    @objc private func timerAction() {
        durationTimer -= 1
        leftTimerLabel.text = "\(durationTimer)"
        rightTimerLabel.text = "\(durationTimer)"

        if durationTimer == 0 {
            timer.invalidate()
            durationTimer = 30
            tapButton.isEnabled = false
            overlayView.alpha = 0
            showAlert(title: "Интерактив не пройден", message: "Попробуйте ещё раз") {
                self.startTimer()
            }
        } else {
            tapButton.isEnabled = true
        }
    }
    
    private func startTimer() {
        basicAnimation()
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
        overlayView.alpha = 0.8
    }
    
    private func animationLeftTimer() {
        
        let leftPath: UIBezierPath = UIBezierPath()
        leftPath.move(to: CGPoint(x: 32, y: 3))
        leftPath.addCurve(to: CGPoint(x: 32, y: 280),
                          controlPoint1: CGPoint(x: 0, y: 120),
                          controlPoint2: CGPoint(x: 0, y: 160))
        
        shapeLayer(shapeLayer: leftLineTimer, path: leftPath)
        leftTimer.layer.addSublayer(leftLineTimer)
    }
    
    private func animationRightTimer() {
        
        let rightPath: UIBezierPath = UIBezierPath()
        rightPath.move(to: CGPoint(x: 787, y: 3))
        rightPath.addCurve(to: CGPoint(x: 787, y: 280),
                           controlPoint1: CGPoint(x: 830, y: 120),
                           controlPoint2: CGPoint(x: 830, y: 160))
        
        shapeLayer(shapeLayer: rightLineTimer, path: rightPath)
        leftTimer.layer.addSublayer(rightLineTimer)
    }
    
//    private func animateButton() {
//        let animation = CABasicAnimation()
//        animation.keyPath = "position.x"
//        animation.fromValue = 100
//        animation.toValue = 750
//        animation.duration = 1
//
//        tapButton.layer.add(animation, forKey: "basic")
//    }
    
    private func basicAnimation() {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(durationTimer)
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = true
        leftLineTimer.add(basicAnimation, forKey: "basicAnimation")
        rightLineTimer.add(basicAnimation, forKey: "basicAnimation")
    }
}

//MARK: - SetConstraints

extension FirstViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            leftTimer.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            leftTimer.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 35)
        ])
        
        NSLayoutConstraint.activate([
            leftTimerLabel.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            leftTimerLabel.leadingAnchor.constraint(equalTo: leftTimer.trailingAnchor, constant: 1)
        ])
        
        NSLayoutConstraint.activate([
            rightTimer.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            rightTimer.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -35)
        ])
        
        NSLayoutConstraint.activate([
            rightTimerLabel.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            rightTimerLabel.leadingAnchor.constraint(equalTo: rightTimer.leadingAnchor, constant: -1)
        ])
        
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 0),
            overlayView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 0),
            overlayView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: 0),
            overlayView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            tapButton.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            tapButton.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor)
        ])
    }
}
