//
//  UserInfoView.swift
//  GitHubUsersMF
//
//  Created by Shashi Nishantha on 9/22/24.
//

import UIKit
import SnapKit
import SDWebImage

final class UserInfoView: UIView {
    
    private var user: User?
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView.init(frame: .zero)
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var userDescriptionLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    init(user: User){
        super.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
        self.user = user
        setupConstraints()
        setData()
    }
    
    func setupConstraints(){
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.width.height.equalTo(150)
            make.centerX.equalTo(self.center.x)
        }
        
        addSubview(fullNameLabel)
        fullNameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).inset(-10)
            make.left.right.equalToSuperview().inset(20)
        }
        
        addSubview(userDescriptionLabel)
        userDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(fullNameLabel.snp.bottom).inset(-10)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    func setData(){
        if let imgPath = user?.avatarURL, let url = URL.init(string: imgPath) {
            avatarImageView.sd_setImage(with: url)
        }
        fullNameLabel.text = user?.name
        userDescriptionLabel.text = user?.bio
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
