//
//  GridCollectionVC.swift
//  SnapKitLayout
//
//  Created by JUNO on 2022/09/02.
//

import UIKit
import SnapKit
import Alamofire

class GridCollectionVC: UIViewController {
    
    private var imageSet: [Image] = []
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(SampleGridCell.self, forCellWithReuseIdentifier: "sampleGridCell")
        
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultLoad()
        getRamdomImageSet()
    }
}

private extension GridCollectionVC {
    
    func setDefaultLoad(){
        
        [ collectionView ].forEach {
            view.addSubview($0)
        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func getRamdomImageSet(){
        
        let param = [
            "api_key" : "live_WEDa0BFZL2SS37E44nTJA55W7u28B1ZcVYVA8kVfbLVPeTzET3BV7MDleqCT54jQ"
        ]
        
        AF.request("https://api.thecatapi.com/v1/images/search?limit=39", method: .get, parameters: param )
            .responseData { response in
                switch response.result {
                case let .success(data):
                    do
                    {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode([Image].self, from: data)
                        result.forEach{
                            self.imageSet.append($0)
                        }
                        self.collectionView.reloadData()
                    }
                    catch
                    {
                        
                    }
                case let .failure(data):
                    print("Error ", data)
                }
            }
    }
}

extension GridCollectionVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sampleGridCell", for: indexPath) as? SampleGridCell else { return UICollectionViewCell() }
        
        cell.initCell(url: imageSet[indexPath.row].url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = (collectionView.frame.width / 3) - 3
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let viewController = ImageDetailView()
        viewController.setImage(url: imageSet[indexPath.row].url)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
