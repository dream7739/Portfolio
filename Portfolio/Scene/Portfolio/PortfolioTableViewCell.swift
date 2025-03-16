//
//  PortfolioTableViewCell.swift
//  PracticeGraph
//
//  Created by 홍정민 on 3/16/25.
//

import UIKit
import SnapKit

final class PortfolioTableViewCell: UITableViewCell {
    private let cardView = UIView()
    private let logoImageView = UIImageView()
    private let previousDayLabel = UILabel()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let rateLabel = UILabel()
    private let quantityLabel = UILabel()
      
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        contentView.addSubview(cardView)
        cardView.addSubview(logoImageView)
        cardView.addSubview(previousDayLabel)
        cardView.addSubview(nameLabel)
        cardView.addSubview(descriptionLabel)
        cardView.addSubview(rateLabel)
        cardView.addSubview(quantityLabel)
    }
    
    private func configureLayout() {
        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
            make.width.equalTo(70)
            make.height.equalTo(25)
        }
        
        previousDayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(12)
            make.leading.equalTo(logoImageView)
            make.trailing.equalToSuperview().offset(-120)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(nameLabel)
            make.trailing.equalTo(nameLabel)
        }
        
        rateLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel)
            make.trailing.equalTo(previousDayLabel)
        }
        
        quantityLabel.snp.makeConstraints { make in
            make.top.equalTo(rateLabel.snp.bottom).offset(4)
            make.trailing.equalTo(rateLabel)
        }
    }
    
    private func configureView() {
        backgroundColor = .clear
        selectionStyle = .none

        cardView.layer.borderWidth = 0.4
        cardView.layer.borderColor = UIColor.lightGray.cgColor
        cardView.backgroundColor = .white
        
        logoImageView.image = UIImage(resource: .logo)
        
        previousDayLabel.text = "전일대비 수익률"
        previousDayLabel.textColor = .gray
        previousDayLabel.font = UIFont.systemFont(ofSize: 12)
        
        nameLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        nameLabel.textColor = .black
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0
        
        rateLabel.font = UIFont.systemFont(ofSize: 13)
        
        quantityLabel.font = UIFont.boldSystemFont(ofSize: 24)
        quantityLabel.textColor = .stock1
    }
    
    func configureData(_ data: Asset) {
        nameLabel.text = data.securityName
        descriptionLabel.text = data.securityDescription
        
        // 수익률 데이터가 없기 때문에 임의로 랜덤값 설정
        let returnRate = Double.random(in: -1...1)
        let isNegative = returnRate < 0
        let sign = returnRate < 0 ? "": "+"
        let rateText = returnRate.toRateFormat()
        rateLabel.text = sign + rateText
        rateLabel.textColor = isNegative ? .systemBlue : .systemRed
        
        quantityLabel.text = data.quantityDescription
    }
}
