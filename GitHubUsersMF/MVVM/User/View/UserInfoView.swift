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
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
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
    
    private lazy var countsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()

    init(user: User){
        super.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 390))
        self.user = user
        setupConstraints()
        createStarViews()
        setData()
    }
    
    func createStarViews(){
        let publicRepos = UserInfoStarView(
            iconName: UserConstants.iconNames.publicRepos,
            labelText: UserConstants.labelStrings.publicRepos,
            labelNumber: user?.publicRepos ?? 0
        )
        let publicGists = UserInfoStarView(
            iconName: UserConstants.iconNames.publicGists,
            labelText: UserConstants.labelStrings.publicGists,
            labelNumber: user?.publicGists ?? 0
        )
        let followers = UserInfoStarView(
            iconName: UserConstants.iconNames.followers,
            labelText: UserConstants.labelStrings.followers,
            labelNumber: user?.followers ?? 0
        )
        let following = UserInfoStarView(
            iconName: UserConstants.iconNames.following,
            labelText: UserConstants.labelStrings.following,
            labelNumber: user?.following ?? 0
        )
        
        publicRepos.snp.makeConstraints { make in
            make.width.equalTo(70)
        }
        
        countsStack.addArrangedSubview(publicRepos)
        countsStack.addArrangedSubview(publicGists)
        countsStack.addArrangedSubview(followers)
        countsStack.addArrangedSubview(following)
    }
    
    func setupConstraints(){
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.width.height.equalTo(150)
            make.centerX.equalTo(self.center.x)
        }
        
        addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).inset(-10)
            make.left.right.equalToSuperview().inset(20)
        }
        
        addSubview(fullNameLabel)
        fullNameLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).inset(-10)
            make.left.right.equalToSuperview().inset(20)
        }
        
        addSubview(countsStack)
        countsStack.snp.makeConstraints { make in
            make.top.equalTo(fullNameLabel.snp.bottom).inset(-10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(80)
            make.width.equalTo(280)
        }
        
        addSubview(userDescriptionLabel)
        userDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(countsStack.snp.bottom).inset(-10)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    func setData(){
        if let imgPath = user?.avatarURL, let url = URL.init(string: imgPath) {
            avatarImageView.sd_setImage(with: url)
        }
        userNameLabel.text = user?.login
        fullNameLabel.text = user?.name
        userDescriptionLabel.text = user?.bio
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
