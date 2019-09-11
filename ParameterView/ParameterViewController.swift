//
//  ParameterViewController.swift
//  ParameterView
//
//  Created by Всеволод Андрющенко on 11/09/2019.
//  Copyright © 2019 Всеволод Андрющенко. All rights reserved.
//

import UIKit

protocol ParameterViewDataSource{
    func parameterViewDataCount(_ parameterView: ParameterView) -> Int
    
    func parameterViewTitle(_ parametrView: ParameterView,  indexPath: IndexPath) -> String
}

protocol ParameterViewDelegat {
    func parameterViewChanged(_ parameterView: ParameterView, didSelectedItem count: [Int])
}

class ParameterView : UIControl{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public var delegate: ParameterViewDelegat?
       // didSet{
         //   pressedButton()
        //}
    //}
    
    public var dataSource: ParameterViewDataSource?{
        didSet{
            setupView()
        }
    }
    
    private var buttons: [UIButton] = []
    private var stackView: UIStackView!
    
    override func layoutSubviews() {
        super .layoutSubviews()
        stackView.frame = bounds
    }
    
    private func setupView(){
        let count = dataSource?.parameterViewDataCount(self)
        
        if let count = count{
            for item in 0..<count{
                let indexPath = IndexPath(item: item, section: 0)
                let title = dataSource?.parameterViewTitle(self, indexPath: indexPath)
                let button = UIButton(type: .system)
                button.tag = item
                button.setTitle(title, for: .normal)
                button.setTitleColor(UIColor.black, for: .normal)
                button.setTitleColor(UIColor.white, for: .selected)
                button.addTarget(self, action: #selector(selectedButton(sender:)), for: .touchUpInside)
                buttons.append(button)
            }
        }
        
        stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        self.addSubview(stackView)
    }
    
    
    @objc func selectedButton(sender: UIButton){
        
        let index = sender.tag
        let button = self.buttons[index]
        let state = button.isSelected
        button.isSelected = !state
        
        var selectionButtons: [Int] = []
        
        for b in buttons{
            if b.isSelected{
                let index = b.tag
                selectionButtons.append(index)
            }
        }
         delegate?.parameterViewChanged(self, didSelectedItem: selectionButtons)
    }
    
}


