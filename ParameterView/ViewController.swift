//
//  ViewController.swift
//  ParameterView
//
//  Created by Всеволод Андрющенко on 11/09/2019.
//  Copyright © 2019 Всеволод Андрющенко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var parameterView: ParameterView!
    
    private var item = ["Button1", "Button2", "Button3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        parameterView.dataSource = self
        parameterView.delegate = self
    }
    
}
extension ViewController: ParameterViewDataSource{
    func parameterViewDataCount(_ parameterView: ParameterView) -> Int {
        return item.count
    }
    
    func parameterViewTitle(_ parametrView: ParameterView, indexPath: IndexPath) -> String {
        return item[indexPath.item]
    }
}

extension ViewController:ParameterViewDelegat{
    func parameterViewChanged(_ parameterView: ParameterView, didSelectedItem indexPath: [Int]) {
        print(indexPath)
    }
}

