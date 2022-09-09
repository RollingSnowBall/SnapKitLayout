//
//  HorizontalCollectionVC.swift
//  SnapKitLayout
//
//  Created by JUNO on 2022/09/02.
//

import UIKit

class HorizontalCollectionVC: UIViewController {
    
    private var titleList: [String] = ["First Date", "Second Date", "Third Date", "Fourth Date"]
    private var currentPage: Int = 1
    
    private var currentPageStackView: UIStackView = {
        let stackview = UIStackView(frame: .zero)
        stackview.distribution = .equalSpacing
        
        return stackview
    }()

    private lazy var currentPageLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false 
        view.dataSource = self
        view.delegate = self

        view.register(SampleVerticalCell.self, forCellWithReuseIdentifier: "sampleCell")
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setNavigation()
        serDefaultLoad()
    }
}

private extension HorizontalCollectionVC {
    
    func setNavigation(){
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(tapAdd))
        navigationItem.rightBarButtonItems = [addButton]
    }
    
    func serDefaultLoad(){
        let safeArea = UIView()
        
        [ safeArea, currentPageLabel, collectionView ].forEach {
            view.addSubview($0)
        }
        
        safeArea.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        currentPageLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top).offset(30)
            $0.trailing.equalTo(safeArea.snp.trailing).inset(15)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(currentPageLabel.snp.bottom)
            $0.leading.equalTo(safeArea.snp.leading)
            $0.trailing.equalTo(safeArea.snp.trailing)
            $0.bottom.equalTo(safeArea.snp.bottom)
        }
        
        updateCurrentPage(current: currentPage)
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
                self.updateCurrentPage(current: self.currentPage)
            }
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateCurrentPage(current: Int) {
        if titleList.count == 0 {
            currentPageLabel.isHidden = true
        }
        else
        {
            currentPageLabel.isHidden = false
            currentPageLabel.text = "\(current) / \(titleList.count)"
        }
    }
}

extension HorizontalCollectionVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sampleCell", for: indexPath) as? SampleVerticalCell else { return UICollectionViewCell() }
        cell.initCell(title: titleList[indexPath.row],indexPath: indexPath.row)
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 10, height: (collectionView.frame.height) - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x) / pageWidth) + 1)
        currentPage = (page == 0) ? 1 : page
        updateCurrentPage(current: currentPage)
    }
}

extension HorizontalCollectionVC: CollectionControlDelegate {
    
    func deleteCell(indexPath: Int) {
        titleList.remove(at: indexPath)
        updateCurrentPage(current: currentPage)
        collectionView.reloadData()
    }
}

