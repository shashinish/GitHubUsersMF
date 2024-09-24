//
//  DetailItemTableViewCell.swift
//  GitHubUsersMF
//
//  Created by Shashi Nishantha on 9/22/24.
//

import UIKit
import SnapKit

class DetailItemTableViewCell: UITableViewCell {
    
    private lazy var leftTextLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = "Title"
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var rightTextLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "Info Text"
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none

        contentView.addSubview(leftTextLabel)
        leftTextLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(rightTextLabel)
        rightTextLabel.snp.makeConstraints { make in
            make.top.equalTo(leftTextLabel.snp.bottom).inset(-5)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func setData(title: String, infoText: String) {
        leftTextLabel.text = title
        rightTextLabel.text = infoText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
