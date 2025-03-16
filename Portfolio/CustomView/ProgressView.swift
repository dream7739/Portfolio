//
//  ProgressGraphView.swift
//  Portfolio
//
//  Created by 홍정민 on 3/16/25.
//

import UIKit
import SnapKit

final class ProgressView: UIView {
    private let nameLabel = UILabel()
    private let progressView = UIProgressView()
    private let ratioLabel = UILabel()
    
    var ratio: Float
    var type: PortfolioDetailType
    
    init(ratio: Float = 0.00, type: PortfolioDetailType) {
        self.ratio = ratio
        self.type = type
        super.init(frame: .zero)
        
        configureHierarchy()
        configureLayout()
        configureView()
        updateValue(ratio)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        addSubview(nameLabel)
        addSubview(progressView)
        addSubview(ratioLabel)
    }
    
    private func configureLayout() {
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(90)
        }
        
        progressView.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing).offset(15)
            make.trailing.equalTo(ratioLabel.snp.leading).offset(-15)
            make.centerY.equalTo(nameLabel)
            make.height.equalTo(5)
        }
        
        ratioLabel.snp.makeConstraints { make in
            make.leading.equalTo(progressView.snp.trailing).offset(15)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(nameLabel)
            make.width.equalTo(50)
        }
    }
    
    private func configureView() {
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 13)
        nameLabel.text = type.name
        
        progressView.progressTintColor = type.color
        progressView.trackTintColor = .progressBlack
        progressView.layer.cornerRadius = 3
        progressView.layer.sublayers![1].cornerRadius = 10
        progressView.clipsToBounds = true
        
        ratioLabel.textAlignment = .right
        ratioLabel.textColor = type.color
        ratioLabel.font = .systemFont(ofSize: 12)
    }
    
    func updateValue(_ ratio: Float) {
        self.ratio = ratio
        progressView.progress = ratio / 100
        ratioLabel.text = ratio.toRateFormat()
    }
}
