//
//  SecondRounting.swift
//  Spike-Swift-MyArchitecture
//
//  Created by ko2ic on 2015/11/19.
//  Copyright © 2015年 ko2ic. All rights reserved
//

import UIKit

class SecondRouting: UIViewController {
    @IBOutlet var secondPresentor: SecondPresentor!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    @IBAction func toThird(sender: AnyObject) {
        self.secondPresentor.toThird()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        secondPresentor.setup()
        WeatherFactory.sharedInstance.transitionState.observeNew { state in
            switch state {
            case .Start:
                self.performSegueWithIdentifier("toThird", sender: self)
                break
            default:
                break
            }
        }
        WeatherFactory.sharedInstance.errorState.observeNew { state in
            switch state {
                // TODO: 同じ処理があるので共通化する
            case .NotFound:
                // TODO: この画面でAPIを取得する場合
                let alertController = UIAlertController(title: "検索結果がありません", message: "", preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "OK", style: .Cancel) { alert in
                    print(alert)
                }
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                break
            default:
                break
            }
        }
    }
}
