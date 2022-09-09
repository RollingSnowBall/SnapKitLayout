//
//  TableViewController.swift
//  SnapKitLayout
//
//  Created by JUNO on 2022/09/02.
//

import UIKit
import SnapKit

class TableVC: UIViewController {
    
    var section = ["1 Section"]//, "2 Section", "3 Section", "4 Section"]
    var list = ["1 Cell", "2 Cell", "3 Cell", "4 Cell", "5 Cell", "6 Cell", "7 Cell", "8 Cell"]
    
    private lazy var tableview: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        
        table.dataSource = self
        table.delegate = self
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        setDefaultLoad()
    }
}

private extension TableVC {
    
    func setNavigation(){
        let editButton = UIBarButtonItem(title: "편집",style: .plain, target: self, action: #selector(tapEditing))
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(tapAdd))
        navigationItem.rightBarButtonItems = [addButton, editButton]
    }
    
    func setDefaultLoad(){
        view.backgroundColor = .systemBackground
        
        [ tableview ].forEach {
            view.addSubview($0)
        }
        
        tableview.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // Edit Mode 켜기/끄기
    @objc func tapEditing(){
        if tableview.isEditing {
            navigationItem.rightBarButtonItems![1].title = "편집"
            tableview.setEditing(false, animated: true)
        } else {
            navigationItem.rightBarButtonItems![1].title = "종료"
            tableview.setEditing(true, animated: true)
        }
    }
    
    // Cell 추가하기
    @objc func tapAdd(){
        let alert = UIAlertController(title: "추가", message: "Row Name을 입력해주세요.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Row Name"
        }
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            guard let text = alert.textFields?[0].text else { return }
            if text != "" {
                self.list.insert(text, at: self.list.count)
                self.tableview.reloadData()
            }
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension TableVC: UITableViewDataSource {
    
    // Section 숫자
    func numberOfSections(in tableView: UITableView) -> Int {
        section.count
    }
    
    // Row 숫자 - section 파라미터를 이용하면 Section마다 개수 조절가능
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    // UITableView Cell 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = list[indexPath.row]
        cell.backgroundColor = .systemGray5
        
        return cell
    }
    
    // Header 타이틀
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        self.section[section]
    }

    // Footer 타이틀
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        self.section[section]
    }
    
    // UITableViewCell Index 변경
    // sourceIndexPath = 원위치
    // destinationIndexPath = 이동 후 위치
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        list.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    // 편집시 사용
    // Insert / Delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.remove(at: indexPath.row)
            tableview.deleteRows(at: [indexPath], with: .automatic)
        } else {
            list.insert("XX Cell", at: indexPath.row)
            tableview.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    // Row 마다 Edit 스타일 설정 가능 (특정 Row는 Insert Button or Delete Button)
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == 0 {
            return .insert
        } else {
            return .delete
        }
    }
    
    // Row 별 높이
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//    }
}

extension TableVC: UITableViewDelegate {
    
}
