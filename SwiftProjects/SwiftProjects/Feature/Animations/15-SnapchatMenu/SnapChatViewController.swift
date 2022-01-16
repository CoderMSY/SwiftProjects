//
//  SnapChatViewController.swift
//  SwiftProjects
//
//  Created by SimonMiao on 2022/1/16.
//

import UIKit

class SnapChatViewController: MSYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = createImageView(imageName: "snap_chat")
        view.addSubview(imageView)
        let margin_bottom = UIView.msy_safeAreaBottom
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-margin_bottom)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
