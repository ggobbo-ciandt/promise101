//
//  ViewController.swift
//  Promise101App
//
//  Created by Giuliano Gobbo Maranha on 25/07/21.
//

import PromiseKit
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var blueView: UIView!

    @IBOutlet weak var redWidth: NSLayoutConstraint!
    @IBOutlet weak var greenWidth: NSLayoutConstraint!
    @IBOutlet weak var blueWidth: NSLayoutConstraint!

    let duration = 1.0
    let delay = 0.2

    var loopGuarantee: Guarantee<Bool>?
    var loopResolve: ((Bool) -> Void)?
    let width: CGFloat = 24

    @IBAction func didTapRedButton() {
        focus(redWidth)
    }

    @IBAction func didTapGreenButton() {
        focus(greenWidth)
    }

    @IBAction func didTapBlueButton() {
        focus(blueWidth)
    }


    @IBAction func didTapLoopButton() {
        guard loopGuarantee == nil else {
            loopResolve?(true)
            return
        }

        (loopGuarantee, loopResolve) = Guarantee.pending()

        animationLoop().done { _ in
            self.loopGuarantee = nil
            self.loopResolve = nil
        }
    }

    @discardableResult
    func animationLoop() -> Guarantee<Bool> {
        firstly {
            self.rotateView(self.redView)
        }.then { _ in
            self.rotateView(self.greenView)
        }.then { _ in
            self.rotateView(self.blueView)
        }.then { completed in
            if self.loopGuarantee?.isFulfilled ?? false {
                return .value(completed)
            }
            return self.animationLoop()
        }
    }

    @discardableResult
    func rotateView(_ view: UIView) -> Guarantee<Bool> {
        UIView.animate(.promise,
                       duration: self.duration,
                       delay: self.delay) {
            view.transform = view.transform.rotated(by: CGFloat.pi)
        }
    }

    @discardableResult
    func focus(_ constraint: NSLayoutConstraint) -> Guarantee<Bool> {
        return firstly {
            loopGuarantee ?? .value(true)
        }.then { _ in
            let widthConstant = { (constraintT: NSLayoutConstraint) -> CGFloat in
                constraint === constraintT && constraintT.constant == self.width ? self.width * 2 : self.width
            }
            self.redWidth.constant = widthConstant(self.redWidth)
            self.greenWidth.constant = widthConstant(self.greenWidth)
            self.blueWidth.constant = widthConstant(self.blueWidth)
            return UIView.animate(.promise,
                           duration: self.duration,
                           delay: self.delay) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
