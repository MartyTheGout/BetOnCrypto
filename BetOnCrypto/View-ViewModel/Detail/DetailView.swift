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
    
    let lineChartView = LineChartView() // gradient fill
    
    private let updateTimeStampLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 9)
        label.textColor = DesignSystem.Color.Tint.submain.inUIColor()
        return label
    }()
    
    private let basicInfoTitle = UILabel()
    private let seeMoreBasicLabel = UILabel()
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
    
    private let detailInfoTitle = UILabel()
    private let seeMoreDetailLabel = UILabel()
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
        
        [priceLabel, changeLabel, lineChartView, updateTimeStampLabel, basicInfoTitle, basicInfoContainer, seeMoreBasicLabel, detailInfoTitle, detailInfoContainer, seeMoreDetailLabel].forEach {
            contentView.addSubview($0)
        }
        
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
            $0.height.equalTo(350)
            $0.top.equalTo(changeLabel.snp.bottom).offset(8)
        }
        
        updateTimeStampLabel.snp.makeConstraints {
            $0.top.equalTo(lineChartView.snp.bottom).offset(8)
            $0.leading.equalTo(contentView).offset(16)
        }
        
        basicInfoTitle.snp.makeConstraints {
            $0.top.equalTo(updateTimeStampLabel.snp.bottom).offset(16)
            $0.leading.equalTo(contentView).offset(16)
        }
        
        seeMoreBasicLabel.snp.makeConstraints {
            $0.top.equalTo(updateTimeStampLabel.snp.bottom).offset(16)
            $0.trailing.equalTo(contentView).offset(-16)
        }
        
        basicInfoContainer.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView).inset(16)
            $0.top.equalTo(basicInfoTitle.snp.bottom).offset(16)
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
        
        detailInfoTitle.snp.makeConstraints {
            $0.top.equalTo(basicInfoContainer.snp.bottom).offset(16)
            $0.leading.equalTo(contentView).offset(16)
        }
        
        seeMoreDetailLabel.snp.makeConstraints {
            $0.top.equalTo(basicInfoContainer.snp.bottom).offset(16)
            $0.trailing.equalTo(contentView).offset(-16)
        }
        
        detailInfoContainer.snp.makeConstraints {
            $0.top.equalTo(detailInfoTitle.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(contentView).inset(16)
        }
        
        capitalTitle.snp.makeConstraints {
            $0.top.leading.equalTo(detailInfoContainer).offset(16)
        }
        
        capitalValue.snp.makeConstraints {
            $0.top.equalTo(capitalTitle.snp.bottom).offset(8)
            $0.leading.equalTo(detailInfoContainer).offset(16)
        }
        
        fDVTitle.snp.makeConstraints {
            $0.top.equalTo(capitalValue.snp.bottom).offset(16)
            $0.leading.equalTo(detailInfoContainer).offset(16)
        }
        
        fDVValue.snp.makeConstraints {
            $0.top.equalTo(fDVTitle.snp.bottom).offset(8)
            $0.leading.equalTo(detailInfoContainer).offset(16)
        }
        
        volumnTitle.snp.makeConstraints {
            $0.top.equalTo(fDVValue.snp.bottom).offset(16)
            $0.leading.equalTo(detailInfoContainer).offset(16)
        }
        
        volumnValue.snp.makeConstraints {
            $0.top.equalTo(volumnTitle.snp.bottom).offset(8)
            $0.leading.equalTo(detailInfoContainer).offset(16)
            $0.bottom.equalTo(detailInfoContainer).offset(-16)
        }
        
        contentView.snp.makeConstraints {
            $0.bottom.equalTo(detailInfoContainer.snp.bottom).offset(16)
        }
    }
    
    override func configureViewDetails() {
        basicInfoTitle.text = "종목정보"
        detailInfoTitle.text = "투자지표"
        
        [basicInfoTitle, detailInfoTitle].forEach {
            $0.textColor = DesignSystem.Color.Tint.main.inUIColor()
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
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        basicInfoContainer.layer.cornerRadius = 20
        basicInfoContainer.layer.masksToBounds = true
        
        detailInfoContainer.layer.cornerRadius = 20
        detailInfoContainer.layer.masksToBounds = true
    }
}


extension DetailView {
    
    func applyData(with data: CoinDetail) {
        priceLabel.text = "₩\(data.currentPrice)"
        
        if let percentageValue = data.priceChangePercentage24h {
            changeLabel.applyPercentageData(with: "\(percentageValue)", bigSize: true)
        }
        
        let curvedValues = data.sparklineIn7d!.price.enumerated().filter { offset, element in
            offset % 2 == 0
        }.map { $0.element }
        
        setChart(values: curvedValues)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/dd hh:mm:ss 업데이트"
        updateTimeStampLabel.text = dateFormatter.string(from: Date())
        
        highPrice24hValue.text = "\(data.high24h)"
        highPriceAllTimeValue.text = "\(data.ath)"
        highPriceAllTimeDate.text = "\(data.athDate)"
        
        lowPrice24hValue.text = "\(data.low24h)"
        lowPriceAllTimeValue.text = "\(data.atl)"
        lowPriceAllTimeDate.text = "\(data.atlDate)"
        
        capitalValue.text = "\(data.marketCap)"
        fDVValue.text = "\(data.fullyDilutedValuation)"
        volumnValue.text = "\(data.totalVolume)"
        
    }
    
    private func setAttributedTextOnSeeMoreLabel() {
        
        let color = DesignSystem.Color.Tint.submain.inUIColor()
        let symbol = DesignSystem.Icon.Input.detail.toUIImage()
        
        let mutableAttributedString = NSMutableAttributedString(string: "")
        
        let attributedString = NSAttributedString(string: "더보기" , attributes: [
            .foregroundColor : color,
            .font : UIFont.boldSystemFont(ofSize: 15)
        ])
        
        let chevronSymbolAttachment = NSTextAttachment()
        chevronSymbolAttachment.image = symbol.withTintColor(color)
        chevronSymbolAttachment.bounds = CGRect(x: 0, y: 0, width: 13, height: 13)
        
        let chevronSymbol = NSMutableAttributedString(attachment: chevronSymbolAttachment)
        
        mutableAttributedString.append(attributedString)
        mutableAttributedString.append(chevronSymbol)
        
        seeMoreBasicLabel.attributedText = mutableAttributedString
        seeMoreDetailLabel.attributedText = mutableAttributedString
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
        let color = DesignSystem.Color.InfoDeliver.negative.inUIColor()
        
        let gradientColors = [
            color.cgColor,
            color.withAlphaComponent(0.6).cgColor,
            color.withAlphaComponent(0.2).cgColor
        ] as CFArray
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: [1.0, 0.5, 0.0])!
        
        lineChartDataSet.fill = LinearGradientFill(gradient: gradient, angle: 90.0)
        lineChartDataSet.drawFilledEnabled = true
        
        lineChartDataSet.highlightEnabled = false
        lineChartDataSet.gradientPositions = [0.0, 1.0]
        lineChartDataSet.isDrawLineWithGradientEnabled = true
        
        lineChartDataSet.colors = [DesignSystem.Color.InfoDeliver.negative.inUIColor()]
        lineChartDataSet.lineWidth = 2
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
