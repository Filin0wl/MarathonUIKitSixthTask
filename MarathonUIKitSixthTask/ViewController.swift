//
//  ViewController.swift
//  MarathonUIKitSixthTask
//
//  Created by Anastasiia Perminova on 17.07.2023.
//

import UIKit

class ViewController: UIViewController {

    private lazy var squareView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        view.backgroundColor = .green
        view.layer.cornerRadius = 10
        return view
    }()

    private lazy var dynamicAnimator = UIDynamicAnimator()
    private lazy var collision = UICollisionBehavior()
    private var snap: UISnapBehavior?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(squareView)
        squareView.center = view.center
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tap)
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collision)

    }


    @objc func tapped(_ gesture: UITapGestureRecognizer){
        if let snap {
            dynamicAnimator.removeBehavior(snap)
        }

        let touchPoint = gesture.location(in: view)
        snap = UISnapBehavior(item: squareView, snapTo: touchPoint)
        snap?.damping = 1.0
        dynamicAnimator.addBehavior(snap ?? UISnapBehavior())
    }
}

