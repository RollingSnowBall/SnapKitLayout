//
//  SampleHorizontalCell.swift
//  SnapKitLayout
//
//  Created by JUNO on 2022/09/09.
//

import SwiftUI
import SnapKit

class SampleHorizontalCell: UICollectionViewCell {
    
    private var index: Int = -1
    weak var delegate: CollectionControlDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("삭제하기", for: .normal)
        button.titleLabel?.textColor = .red
        
        button.addTarget(self, action: #selector(deleteCell), for: .touchDown)
        
        return button
    }()
    
    func initCell(title: String, indexPath: Int){
        setDefaultCell()
        
        index = indexPath
        titleLabel.text = title
    }
}

private extension SampleHorizontalCell {
    
    func setDefaultCell(){
        
        [ titleLabel, deleteButton ].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        deleteButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 4
    }
    
    @objc func deleteCell(){
        self.delegate?.deleteCell(indexPath: index)
    }
}
