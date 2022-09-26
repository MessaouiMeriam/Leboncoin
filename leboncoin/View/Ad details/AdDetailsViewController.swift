//
//  AdDetailsViewController.swift
//  leboncoin
//
//  Created by Messaoui Meriam on 21/09/2022.
//

import UIKit

class AdDetailsViewController: UIViewController {

    // MARK: - Private vars
    private var viewModel: AdViewModel

    private let scrollView = UIScrollView()
    
    private let adImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = AppStyle.Font.openSansBold(size: 16).font
        label.textColor = AppStyle.Color.black
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = AppStyle.Font.openSansBold(size: 16).font
        label.textColor = AppStyle.Color.black
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = AppStyle.Font.openSansMedium(size: 14).font
        label.textColor = AppStyle.Color.black
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = AppStyle.Font.openSansMedium(size: 12).font
        label.textColor = AppStyle.Color.black
        return label
    }()
    
    private let descriptioLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .justified
        label.font = AppStyle.Font.openSansRegular(size: 14).font
        label.textColor = AppStyle.Color.black
        label.numberOfLines = 0
        return label
    }()

    private let urgentLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.urgent
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.backgroundColor = AppStyle.Color.lightOrange
        label.font = AppStyle.Font.openSansMedium(size: 14).font
        label.textColor = AppStyle.Color.black
        label.numberOfLines = 0
        label.setAnchors(size: CGSize(width: label.intrinsicContentSize.width + 12,
                                            height: label.intrinsicContentSize.height + 4))
        return label
    }()
    
    // MARK: - Init
    init(viewModel: AdViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()
        setupUI()
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configure()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.addSubview(scrollView)
        
        scrollView.autoFillToSuperView()
        
        let metadataStackView = UIStackView(arrangedSubviews: [titleLabel, categoryLabel, priceLabel, urgentLabel, dateLabel, descriptioLabel])
        metadataStackView.axis = .vertical
        metadataStackView.spacing = 8
        metadataStackView.alignment = .leading
        metadataStackView.isLayoutMarginsRelativeArrangement = true
        metadataStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)

        let stackView = UIStackView(arrangedSubviews: [adImageView, metadataStackView])
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.autoFillToSuperView()
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }

    private func setupView() {
        view.backgroundColor = AppStyle.Color.white
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: Constants.retour, style: .plain, target: nil, action: nil)
    }

    private func configure() {
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.price
        categoryLabel.text = viewModel.categoryName
        adImageView.image = UIImage(named: "thumb")
        dateLabel.text = viewModel.creationDate
        descriptioLabel.text = viewModel.adDescription
        guard let isUrgent = viewModel.isUrgent else {return}
        urgentLabel.isHidden = !isUrgent
        guard let image = viewModel.thumb else { return}
        adImageView.getImgFromUrl(link: image, contentMode: .scaleAspectFill)
    }
}
