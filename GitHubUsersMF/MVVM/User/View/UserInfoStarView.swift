//
//  UserInfoStarView.swift
//  GitHubUsersMF
//
//  Created by Shashi Nishantha on 9/24/24.
//

import Foundation
import SnapKit
import UIKit

final class UserInfoStarView: UIView {
    private var iconName: String = ""
    private var labelText: String = ""
    private var labelNumber: Int = 0
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView.init(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var iconNameLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        return label
    }()
    
    private lazy var iconCountLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImageView, iconNameLabel, iconCountLabel])
        //stackView.frame = CGRect(x: 0, y: 0, width: 30, height: 90)
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        iconImageView.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(30)
            make.top.equalToSuperview()
        }
        iconNameLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.left.right.equalToSuperview()
            make.top.equalTo(iconImageView.snp.bottom)
        }
        iconCountLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(iconNameLabel.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        return stackView
    }()
    
    
    init(iconName: String, labelText: String, labelNumber: Int){
        super.init(frame: .zero)
        self.iconName = iconName
        self.labelText = labelText
        self.labelNumber = labelNumber
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView(){

        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.width.equalTo(70)
        }
        
        iconImageView.image = UIImage.init(named: iconName)
        iconNameLabel.text = labelText
        iconCountLabel.text = "\(labelNumber)"
    }
    
}
