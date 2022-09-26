//
//  AdTableViewCell.swift
//  leboncoin
//
//  Created by Messaoui Meriam on 21/09/2022.
//

import UIKit

class AdTableViewCell: UITableViewCell {
    
    static let Identifier = String(describing: AdTableViewCell.self)
    var viewModel: AdViewModel? {
        didSet {
            titleLabel.text = viewModel?.title
            priceLabel.text = viewModel?.price
            categoryLabel.text = viewModel?.categoryName
            adImageView.image = UIImage(named: "small")
            guard let isUrgent = viewModel?.isUrgent else {return}
            urgentLabel.isHidden = !isUrgent
            guard let image = viewModel?.smallUrl else { return}
            adImageView.getImgFromUrl(link: image, contentMode: .scaleAspectFill)
            
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppStyle.Font.openSansBold(size: 16).font
        label.textColor = AppStyle.Color.black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = AppStyle.Font.openSansSemiBold(size: 14).font
        label.textColor = AppStyle.Color.black
        label.textAlignment = .left
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = AppStyle.Font.openSansMedium(size: 14).font
        label.textColor = AppStyle.Color.gray
        label.textAlignment = .left
        return label
    }()
    
    private let adImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private let urgentLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.urgent
        label.font = AppStyle.Font.openSansMedium(size: 12).font
        label.textColor = AppStyle.Color.red
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.layer.borderColor = AppStyle.Color.red.cgColor
        label.layer.borderWidth = 1
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.layer.borderColor = AppStyle.Color.lightGray.cgColor
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.autoFillToSuperView(edgeInset: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        urgentLabel.setAnchors(size: CGSize(width: urgentLabel.intrinsicContentSize.width + 8,
                                            height: urgentLabel.intrinsicContentSize.height + 4))
        let titleStackView = UIStackView(arrangedSubviews: [titleLabel, urgentLabel])
        titleStackView.axis = .horizontal
        titleStackView.alignment = .leading
        titleStackView.spacing = 8
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        let metadataStackView = UIStackView(arrangedSubviews: [titleStackView, priceLabel, UIView(), categoryLabel])
        metadataStackView.axis = .vertical
        metadataStackView.isLayoutMarginsRelativeArrangement = true
        metadataStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8)

        adImageView.setAnchors(size: CGSize(width: 100, height: 0))

        let containerStackView = UIStackView(arrangedSubviews: [adImageView, metadataStackView])
        containerStackView.axis = .horizontal

        containerView.addSubview(containerStackView)
        containerView.clipsToBounds = true

        containerStackView.autoFillToSuperView()
     }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
