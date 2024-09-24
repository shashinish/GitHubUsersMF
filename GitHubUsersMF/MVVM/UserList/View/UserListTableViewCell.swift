//
//  UserListTableViewCell.swift
//  GitHubUsersMF
//
//  Created by Shashi Nishantha on 9/21/24.
//

import UIKit
import SnapKit
import SDWebImage

class UserListTableViewCell: UITableViewCell {
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView.init(frame: .zero)
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var userTypeLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        contentView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(20)
            make.width.height.equalTo(70)
        }
        
        contentView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(20)
            make.left.equalTo(avatarImageView.snp.right).inset(-20)
        }
        
        contentView.addSubview(userTypeLabel)
        userTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).inset(-10)
            make.right.equalToSuperview().inset(20)
            make.left.equalTo(avatarImageView.snp.right).inset(-20)
        }
    }
    
    func configureCell(user: UserList){
        userNameLabel.text = String(
            format: UserListConstants.labelStrings.userName, user.id , user.login
        )
        userTypeLabel.text = String(
            format: UserListConstants.labelStrings.userType, user.type
        )
        guard let imageUrl = URL.init(string: user.avatarURL) else { return }
        avatarImageView.sd_setImage(with: imageUrl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
