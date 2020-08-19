//
//  ViewController.swift
//  AdaptiveCardSwiftSample
//
//  Created by Shinya Nakajima on 2019/05/08.
//  Copyright © 2019 nakasho. All rights reserved.
//

import UIKit
import SafariServices
import BrightFutures
import TinyConstraints
import RxSwift

class ViewController: UIViewController {
    
    let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
            // Do any additional setup after loading the view, typically from a nib.
            let jsonStr = "{ \"type\": \"AdaptiveCard\", \"version\": \"1.0\", \"body\": [ { \"type\": \"Image\", \"url\": \"http://adaptivecards.io/content/adaptive-card-50.png\", \"horizontalAlignment\":\"center\" }, { \"type\": \"TextBlock\", \"horizontalAlignment\":\"center\", \"text\": \"Hello **Adaptive Cards!**\" } ], \"actions\": [ { \"type\": \"Action.OpenUrl\", \"title\": \"Learn more\", \"url\": \"http://adaptivecards.io\" }, { \"type\": \"Action.OpenUrl\", \"title\": \"GitHub\", \"url\": \"http://github.com/Microsoft/AdaptiveCards\" } ] }"
        
            let cardParseResult = ACOAdaptiveCard.fromJson(jsonStr);
            if((cardParseResult?.isValid)!){
                let renderResult = ACRRenderer.render(cardParseResult!.card, config: nil, widthConstraint: 335);

                if(renderResult?.succeeded ?? false)
                {
                    let ad = renderResult?.view
                    ad!.acrActionDelegate = self
                    self.view.autoresizingMask = [.flexibleHeight]
                    self.view.addSubview(ad!)
                    ad!.translatesAutoresizingMaskIntoConstraints = false
        
                    NSLayoutConstraint(item: ad!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0).isActive = true
                    NSLayoutConstraint(item: ad!, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 3).isActive = true
                }
            }

        _ = Observable.just("hoge")
        
        
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

extension ViewController : ACRActionDelegate {
    func didFetchUserResponses(_ card: ACOAdaptiveCard, action: ACOBaseActionElement)
    {
        if(action.type == ACRActionType.openUrl){
            let url = URL.init(string:action.url());
            let svc = SFSafariViewController.init(url: url!);
            self.present(svc, animated: true, completion: nil);
        }
    }
}

