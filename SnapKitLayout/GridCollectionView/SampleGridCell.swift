//
//  SampleGridCell.swift
//  SnapKitLayout
//
//  Created by JUNO on 2022/09/10.
//

import Kingfisher
import SnapKit
import UIKit

class SampleGridCell: UICollectionViewCell {
    
    private var url: String = ""
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    func initCell(url: String){
        self.url = url
        
        setDefaultCell()
        getRandomImage()
    }
}

private extension SampleGridCell {
    
    func setDefaultCell(){
        imageView.backgroundColor = .systemBackground
        self.layer.borderColor = UIColor.systemGray4.cgColor
        self.layer.borderWidth = 2
        
        [ imageView ].forEach {
            addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func getRandomImage(){
        let imageURL = URL(string: url)
        imageView.kf.setImage(with: imageURL)
    }
}
