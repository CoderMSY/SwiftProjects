//
//  AnimationsExampleViewController.swift
//  SwiftProjects
//
//  Created by SimonMiao on 2022/1/14.
//

import UIKit

let kAnimationsDuration = 1.5

class AnimationsExampleViewController: MSYBaseViewController {
    
    fileprivate let items = [
        "2-Color",
        "Simple 2D Rotation",
        "Multicolor",
        "Multi Point Position",
        "BezierCurve Position",
        "Color and Frame Change",
        "View Fade In",
        "Pop"
    ]
    
    lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(MSYBaseTableViewCell.self, forCellReuseIdentifier: MSYBaseTableViewCell.cellReuseId)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCloseItem()

        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animateTable()
    }
    
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight = tableView.bounds.size.height
        
        // move all cells to the bottom of the screen
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        // move all cells from bottom to the right place
        var index = 0
        for cell in cells {
            UIView.animate(withDuration: kAnimationsDuration, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            index += 1
            
//            UIView.animate(withDuration: kAnimationsDuration, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
//                cell.transform = CGAffineTransform(translationX: 0, y: 0)
//            }, completion: nil)
        }
    }
}

// MARK: - UITableViewDataSource

extension AnimationsExampleViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Basic Animations"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MSYBaseTableViewCell.cellReuseId, for: indexPath) as!MSYBaseTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }

}

// MARK: - UITableViewDelegate
extension AnimationsExampleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ctr = AnimationDetailViewController()
        ctr.barTitle = items[indexPath.row]
        self.navigationController?.pushViewController(ctr, animated: true)
    }
}
