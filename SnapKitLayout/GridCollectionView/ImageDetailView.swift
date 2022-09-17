//
//  ImageDetailView.swift
//  SnapKitLayout
//
//  Created by JUNO on 2022/09/10.
//

import UIKit
import SnapKit
import Kingfisher

class ImageDetailView: UIViewController {
    
    private var url: String = ""
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultLoad()
    }
    
    func setImage(url: String){
        self.url = url
    }
    
}

private extension ImageDetailView {
    
    func setDefaultLoad(){
        self.view.backgroundColor = .systemBackground
        
        let imageURL = URL(string: url)
        imageView.kf.setImage(with: imageURL)
        
        [ imageView ].forEach {
            view.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.width.equalTo(view.frame.width - 50)
            $0.height.equalTo(imageView.snp.width)
        }
    }
}
