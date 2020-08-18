//
//  ViewController.swift
//  AdaptiveCardSwiftSample
//
//  Created by Shinya Nakajima on 2019/05/08.
//  Copyright © 2019 nakasho. All rights reserved.
//

import UIKit
import BrightFutures
import TinyConstraints

class ViewController: UIViewController {
    
    let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonStr = "{ \"type\": \"AdaptiveCard\", \"version\": \"1.0\", \"body\": [ { \"type\": \"Image\", \"url\": \"http://adaptivecards.io/content/adaptive-card-50.png\", \"horizontalAlignment\":\"center\" }, { \"type\": \"TextBlock\", \"horizontalAlignment\":\"center\", \"text\": \"Hello **Adaptive Cards!**\" } ], \"actions\": [ { \"type\": \"Action.OpenUrl\", \"title\": \"Learn more\", \"url\": \"http://adaptivecards.io\" }, { \"type\": \"Action.OpenUrl\", \"title\": \"GitHub\", \"url\": \"http://github.com/Microsoft/AdaptiveCards\" } ] }"
        
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        
        
        configSubviews()
        addSubviews()
        layoutSubviews()
    }


    private func configSubviews() {
        titleLabel.text = "テスト"
    }
    
    private func addSubviews() {
        view.addSubview(titleLabel)
    }
    
    private func layoutSubviews() {
        titleLabel.center(in: view)
    }
    
    func asyncCalculation() -> Future<String, Never> {
        return Future { complete in
            DispatchQueue.global().async {
                // do a complicated task and then hand the result to the promise:
                complete(.success("forty-two"))
            }
        }
    }
}

