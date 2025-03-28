//
//  DetailView.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/10/25.
//

import UIKit
import SnapKit
import DGCharts

final class DetailView: BaseView {
    
    private let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private let priceLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = DesignSystem.Color.Tint.main.inUIColor()
        return label
    }()
    
    private let changeLabel = UpDownPercentageLabel()
    
    let lineChartView = LineChartView()
    
    private let updateTimeStampLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = DesignSystem.Color.Tint.submain.inUIColor()
        return label
    }()
    
    private let basicTitleContainer = {
        let view = UIView()
        view.backgroundColor = DesignSystem.Color.Renewal.tint.inUIColor()
        return view
    }()
    private let basicInfoTitle = UILabel()
    let seeMoreBasicButton = UIButton()
    private let basicInfoContainer = UIView()
    
    private let highPrice24hTitle = UILabel()
    private let highPrice24hValue = UILabel()
    private let lowPrice24hTitle = UILabel()
    private let lowPrice24hValue = UILabel()
    private let highPriceAllTimeTitle = UILabel()
    private let highPriceAllTimeValue = UILabel()
    private let highPriceAllTimeDate = UILabel()
    private let lowPriceAllTimeTitle = UILabel()
    private let lowPriceAllTimeValue = UILabel()
    private let lowPriceAllTimeDate = UILabel()
    
    private let detailTitleContainer = {
        let view = UIView()
        view.backgroundColor = DesignSystem.Color.Renewal.tint.inUIColor()
        return view
    }()
    private let detailInfoTitle = UILabel()
    let seeMoreDetailButton = UIButton()
    private let detailInfoContainer = UIView()
    
    private let capitalTitle = UILabel()
    private let capitalValue = UILabel()
    private let fDVTitle = UILabel()
    private let fDVValue = UILabel()
    private let volumnTitle = UILabel()
    private let volumnValue = UILabel()
    
    override func configureViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [priceLabel, changeLabel, lineChartView, updateTimeStampLabel, basicTitleContainer, basicInfoContainer, detailTitleContainer, detailInfoContainer].forEach {
            contentView.addSubview($0)
        }
        
        basicTitleContainer.addSubview(basicInfoTitle)
        basicTitleContainer.addSubview(seeMoreBasicButton)
        detailTitleContainer.addSubview(detailInfoTitle)
        detailTitleContainer.addSubview(seeMoreDetailButton)
        
        [highPrice24hTitle, highPrice24hValue, lowPrice24hTitle, lowPrice24hValue, highPriceAllTimeTitle, highPriceAllTimeValue, highPriceAllTimeDate, lowPriceAllTimeTitle, lowPriceAllTimeValue, lowPriceAllTimeDate].forEach {
            basicInfoContainer.addSubview($0)
        }
        
        [capitalTitle, capitalValue, fDVTitle, fDVValue, volumnTitle, volumnValue].forEach {
            detailInfoContainer.addSubview($0)
        }
    }
    
    override func configureViewConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(scrollView)
            $0.verticalEdges.equalTo(scrollView)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.leading.equalTo(contentView).offset(16)
        }
        
        changeLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(16)
            $0.top.equalTo(priceLabel.snp.bottom).offset(8)
        }
        
        lineChartView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView).inset(16)
            $0.height.equalTo(lineChartView.snp.width).multipliedBy(2.0/3.0)
            $0.top.equalTo(changeLabel.snp.bottom).offset(8)
        }
        
        updateTimeStampLabel.snp.makeConstraints {
            $0.top.equalTo(lineChartView.snp.bottom).offset(8)
            $0.leading.equalTo(contentView).offset(16)
        }
        
        basicTitleContainer.snp.makeConstraints {
            $0.top.equalTo(updateTimeStampLabel.snp.bottom).offset(16)
            $0.leading.equalTo(contentView)
        }
        
        basicInfoTitle.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(6)
            $0.leading.equalToSuperview().offset(16)
        }
        
        seeMoreBasicButton.snp.makeConstraints {
            $0.centerY.equalTo(basicInfoTitle)
            $0.leading.equalTo(basicInfoTitle.snp.trailing).offset(40)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        basicInfoContainer.snp.makeConstraints {
            $0.top.equalTo(basicInfoTitle.snp.bottom).offset(16)
            $0.leading.equalTo(contentView).offset(32)
            $0.trailing.equalTo(contentView)
        }
        
        highPrice24hTitle.snp.makeConstraints {
            $0.top.leading.equalTo(basicInfoContainer).offset(16)
        }
        
        highPrice24hValue.snp.makeConstraints {
            $0.leading.equalTo(basicInfoContainer).offset(16)
            $0.top.equalTo(highPrice24hTitle.snp.bottom).offset(8)
        }
        
        highPriceAllTimeTitle.snp.makeConstraints {
            $0.leading.equalTo(basicInfoContainer).offset(16)
            $0.top.equalTo(highPrice24hValue.snp.bottom).offset(16)
        }
        
        highPriceAllTimeValue.snp.makeConstraints {
            $0.leading.equalTo(basicInfoContainer).offset(16)
            $0.top.equalTo(highPriceAllTimeTitle.snp.bottom).offset(8)
        }
        
        highPriceAllTimeDate.snp.makeConstraints {
            $0.leading.equalTo(basicInfoContainer).offset(16)
            $0.top.equalTo(highPriceAllTimeValue.snp.bottom).offset(8)
            $0.bottom.equalTo(basicInfoContainer).offset(-16) // make bottom line with super view
        }
        
        lowPrice24hTitle.snp.makeConstraints {
            $0.top.equalTo(basicInfoContainer).offset(16)
            $0.leading.equalTo(basicInfoContainer.snp.centerX).offset(16)
        }
        
        lowPrice24hValue.snp.makeConstraints {
            $0.top.equalTo(lowPrice24hTitle.snp.bottom).offset(8)
            $0.leading.equalTo(basicInfoContainer.snp.centerX).offset(16)
        }
        
        lowPriceAllTimeTitle.snp.makeConstraints {
            $0.top.equalTo(lowPrice24hValue.snp.bottom).offset(16)
            $0.leading.equalTo(basicInfoContainer.snp.centerX).offset(16)
        }
        
        lowPriceAllTimeValue.snp.makeConstraints {
            $0.top.equalTo(lowPriceAllTimeTitle.snp.bottom).offset(8)
            $0.leading.equalTo(basicInfoContainer.snp.centerX).offset(16)
        }
        
        lowPriceAllTimeDate.snp.makeConstraints {
            $0.top.equalTo(lowPriceAllTimeValue.snp.bottom).offset(8)
            $0.leading.equalTo(basicInfoContainer.snp.centerX).offset(16)
        }
        
        detailTitleContainer.snp.makeConstraints {
            $0.top.equalTo(basicInfoContainer.snp.bottom).offset(16)
            $0.leading.equalTo(contentView)
        }
        
        detailInfoTitle.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(6)
            $0.leading.equalToSuperview().offset(16)
        }
        
        seeMoreDetailButton.snp.makeConstraints {
            $0.centerY.equalTo(detailInfoTitle)
            $0.leading.equalTo(detailInfoTitle.snp.trailing).offset(40)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        detailInfoContainer.snp.makeConstraints {
            $0.top.equalTo(detailInfoTitle.snp.bottom).offset(16)
            $0.leading.equalTo(contentView).offset(32)
            $0.trailing.equalTo(contentView)
        }
        
        capitalTitle.snp.makeConstraints {
            $0.top.leading.equalTo(detailInfoContainer).offset(16)
        }
        
        capitalValue.snp.makeConstraints {
            $0.top.equalTo(capitalTitle.snp.bottom).offset(8)
            $0.trailing.equalTo(detailInfoContainer).offset(-16)
        }
        
        fDVTitle.snp.makeConstraints {
            $0.top.equalTo(capitalValue.snp.bottom).offset(16)
            $0.leading.equalTo(detailInfoContainer).offset(16)
        }
        
        fDVValue.snp.makeConstraints {
            $0.top.equalTo(fDVTitle.snp.bottom).offset(8)
            $0.trailing.equalTo(detailInfoContainer).offset(-16)
        }
        
        volumnTitle.snp.makeConstraints {
            $0.top.equalTo(fDVValue.snp.bottom).offset(16)
            $0.leading.equalTo(detailInfoContainer).offset(16)
        }
        
        volumnValue.snp.makeConstraints {
            $0.top.equalTo(volumnTitle.snp.bottom).offset(8)
            $0.trailing.equalTo(detailInfoContainer).offset(-16)
            $0.bottom.equalTo(detailInfoContainer).offset(-16)
        }
        
        contentView.snp.makeConstraints {
            $0.bottom.equalTo(detailInfoContainer.snp.bottom).offset(16)
        }
    }
    
    override func configureViewDetails() {
        backgroundColor = DesignSystem.Color.Background.main.inUIColor()
        
        basicInfoTitle.text = "가격 정보"
        detailInfoTitle.text = "재무 관련"
        
        [basicInfoTitle, detailInfoTitle].forEach {
            $0.textColor = DesignSystem.Color.Background.main.inUIColor()
            $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        }
        
        [basicInfoContainer, detailInfoContainer].forEach {
            $0.backgroundColor = DesignSystem.Color.Background.segment.inUIColor()
        }
        
        setAttributedTextOnSeeMoreLabel()
        
        highPrice24hTitle.text = "24시간 고가"
        lowPrice24hTitle.text = "24시간 저가"
        highPriceAllTimeTitle.text = "역대 최고가"
        lowPriceAllTimeTitle.text = "역대 최저가"
        
        capitalTitle.text = "시가 총액"
        fDVTitle.text = "완전 희석 가치(FDV)"
        volumnTitle.text = "총 거래량"
        
        [highPrice24hTitle, lowPrice24hTitle, highPriceAllTimeTitle, lowPriceAllTimeTitle, capitalTitle, fDVTitle, volumnTitle].forEach {
            $0.textColor = DesignSystem.Color.Tint.submain.inUIColor()
            $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        }
        
        [highPrice24hValue, highPriceAllTimeValue, lowPrice24hValue, lowPriceAllTimeValue, capitalValue, fDVValue, volumnValue].forEach {
            $0.textColor = DesignSystem.Color.Tint.main.inUIColor()
            $0.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        }
        
        [highPriceAllTimeDate, lowPriceAllTimeDate].forEach {
            $0.textColor = DesignSystem.Color.Tint.submain.inUIColor()
            $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        }
        
        basicInfoContainer.layer.cornerRadius = 10
        basicInfoContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        detailInfoContainer.layer.cornerRadius = 10
        detailInfoContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        basicInfoContainer.layer.cornerRadius = 20
        basicInfoContainer.layer.masksToBounds = true
        
        detailInfoContainer.layer.cornerRadius = 20
        detailInfoContainer.layer.masksToBounds = true
        
        basicTitleContainer.layer.cornerRadius = basicTitleContainer.frame.height / 2
        basicTitleContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        basicTitleContainer.layer.masksToBounds = true
        
        detailTitleContainer.layer.cornerRadius = detailTitleContainer.frame.height / 2
        detailTitleContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        detailTitleContainer.layer.masksToBounds = true
    }
}


extension DetailView {
    
    func applyData(with data: CoinDetailPresentable) {
        priceLabel.text = data.currentPrice
        
        changeLabel.applyPercentageData(with: data.priceChangePercentage24h, bigSize: true)
        
        if let curvedValues = data.sparklineIn7d {
            setChart(values: curvedValues)
        }
        
        updateTimeStampLabel.text = data.lastUpdated
        
        highPrice24hValue.text = data.high24h
        highPriceAllTimeValue.text = data.ath
        highPriceAllTimeDate.text = data.athDate
        
        lowPrice24hValue.text = data.low24h
        lowPriceAllTimeValue.text = data.atl
        lowPriceAllTimeDate.text = data.atlDate
        
        capitalValue.text = data.marketCap
        fDVValue.text = data.fullyDilutedValuation
        volumnValue.text = data.totalVolume
        
    }
    
    private func setAttributedTextOnSeeMoreLabel() {
        
        let color = DesignSystem.Color.Renewal.subTint.inUIColor()
        let symbol = DesignSystem.Icon.Input.detail.toUIImage()
        
        let mutableAttributedString = NSMutableAttributedString(string: "")
        
        let attributedString = NSAttributedString(string: "더보기" , attributes: [
            .foregroundColor : color,
            .font : UIFont.boldSystemFont(ofSize: 13)
        ])
        
        let chevronSymbolAttachment = NSTextAttachment()
        chevronSymbolAttachment.image = symbol.withTintColor(color)
        chevronSymbolAttachment.bounds = CGRect(x: 0, y: 0, width: 11, height: 11)
        
        let chevronSymbol = NSMutableAttributedString(attachment: chevronSymbolAttachment)
        
        mutableAttributedString.append(attributedString)
        mutableAttributedString.append(chevronSymbol)
        
        seeMoreDetailButton.setAttributedTitle(mutableAttributedString, for: .normal)
        seeMoreBasicButton.setAttributedTitle(mutableAttributedString, for: .normal)
    }
    
    private func setChart(values: [Double]) {
        
        var lineChardEntries = [ChartDataEntry]()
        
        values.enumerated().forEach { index, value in
            let dataEntry = ChartDataEntry(x: Double(index), y: value)
            lineChardEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(entries: lineChardEntries, label: "Coin")
        lineChartDataSet.label = nil
        
        lineChartDataSet.drawValuesEnabled = false
        let color = DesignSystem.Color.Renewal.tint.inUIColor()
        
        let gradientColors = [
            color.cgColor,
            color.cgColor,
            color.withAlphaComponent(0.5).cgColor
        ] as CFArray
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: [1.0, 0.2, 0.0])!
        
        lineChartDataSet.fill = LinearGradientFill(gradient: gradient, angle: 90.0)
        lineChartDataSet.drawFilledEnabled = true
        
        lineChartDataSet.highlightEnabled = false
        
        lineChartDataSet.isDrawLineWithGradientEnabled = true
        lineChartDataSet.gradientPositions = [0.0, 1.0]
        
        lineChartDataSet.colors = [DesignSystem.Color.Renewal.tint.inUIColor()]
        lineChartDataSet.lineWidth = 3
        lineChartDataSet.mode = .cubicBezier
        lineChartDataSet.cubicIntensity = 0.2
        lineChartDataSet.drawCirclesEnabled = false
        
        let lineChartData = LineChartData()
        lineChartData.dataSets.append(lineChartDataSet)
        
        lineChartView.data = lineChartData
        
        lineChartView.drawGridBackgroundEnabled = false
        lineChartView.drawBordersEnabled = false
        lineChartView.setScaleEnabled(false)
        
        lineChartView.legend.enabled = false
        lineChartView.xAxis.enabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.rightAxis.enabled = false
    }
}
