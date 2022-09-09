//
//  VerticalCollectionViewController.swift
//  SnapKitLayout
//
//  Created by JUNO on 2022/09/02.
//

import UIKit
import SnapKit

class VerticalCollectionVC: UIViewController {
    
    private var titleList: [String] = ["First Date", "Second Date", "Third Date", "Fourth Date"]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self

        view.register(SampleCell.self, forCellWithReuseIdentifier: "sampleCell")
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setNavigation()
        serDefaultLoad()
    }
}

private extension VerticalCollectionVC {
    
    func setNavigation(){
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(tapAdd))
        navigationItem.rightBarButtonItems = [addButton]
    }
    
    func serDefaultLoad(){
        
        [ collectionView ].forEach {
            view.addSubview($0)
        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
                .inset(UIEdgeInsets(top: 30, left: 5, bottom: 0, right: 5))
        }
    }
    
    @objc func tapAdd(){
        let alert = UIAlertController(title: "추가", message: "Title을 입력해주세요.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Row Name"
        }
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            guard let text = alert.textFields?[0].text else { return }
            if text != "" {
                self.titleList.insert(text, at: 0)
                self.collectionView.reloadData()
            }
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension VerticalCollectionVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sampleCell", for: indexPath) as? SampleCell else { return UICollectionViewCell() }
        cell.initCell(title: titleList[indexPath.row],indexPath: indexPath.row)
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 20, height: (collectionView.frame.height / 3) - 40)
    }
    
}

extension VerticalCollectionVC: CollectionControlDelegate {
    
    func deleteCell(indexPath: Int) {
        titleList.remove(at: indexPath)
        collectionView.reloadData()
    }
}
