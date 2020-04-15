//
//  HPAndATKChartVC.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/4/14.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

enum HPAndATKMode {
    case hp
    case atk
}

class HPAndATKChartVC: UIViewController {

    private let dataModel: HPAndATKModel
    private let mode: HPAndATKMode

    private let yLabel = UILabel()
    private let xLabel = UILabel()
    private let chart = Chart(frame: .zero)

    init(dataModel: HPAndATKModel, mode: HPAndATKMode) {
        self.dataModel = dataModel
        self.mode = mode
        super.init(nibName: nil, bundle: nil)

        view.addSubview(yLabel)
        view.addSubview(xLabel)
        xLabel.text = "LV"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        chart.frame = CGRect(x: 0.0, y: 50, width: view.bounds.width, height: view.bounds.height - 125.0 * 2)

        let ySize = yLabel.sizeThatFits(CGSize(width: view.bounds.width, height: view.bounds.height))
        yLabel.frame = CGRect(x: 8.0, y: (50.0 - ySize.height) / 2, width: ySize.width, height: ySize.height)

        let xSize = xLabel.sizeThatFits(CGSize(width: view.bounds.width, height: view.bounds.height))
        xLabel.frame = CGRect(x: view.bounds.width - 8.0 - xSize.width, y: view.bounds.height - 125.0 * 2 + 50.0 + (50.0 - ySize.height) / 2, width: xSize.width, height: xSize.height)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        switch traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                view.backgroundColor = .white
            case .dark:
                chart.labelColor = .white
                view.backgroundColor = .black
        @unknown default:
            fatalError()
        }

        var data1: [(x: Double, y: Double)] = []
        var data2: [(x: Double, y: Double)] = []

        var count = 0
        for d in dataModel.data {
            if d.lv == 1 {
                data1.append((x: Double(d.lv), y: Double(d.HP)))
                data2.append((x: Double(d.lv), y: Double(d.ATK)))
            }
            else if d.lv == 60 {
                data1.append((x: Double(d.lv), y: Double(d.HP)))
                data2.append((x: Double(d.lv), y: Double(d.ATK)))
            }
            else if d.lv == 70 {
                data1.append((x: Double(d.lv), y: Double(d.HP)))
                data2.append((x: Double(d.lv), y: Double(d.ATK)))
            }
            else if d.lv == 80 {
                data1.append((x: Double(d.lv), y: Double(d.HP)))
                data2.append((x: Double(d.lv), y: Double(d.ATK)))
            }
            else if d.lv == 90 {
                data1.append((x: Double(d.lv), y: Double(d.HP)))
                data2.append((x: Double(d.lv), y: Double(d.ATK)))
            }
            else if d.lv == 100 {
                data1.append((x: Double(d.lv), y: Double(d.HP)))
                data2.append((x: Double(d.lv), y: Double(d.ATK)))
            }

            count += 1
        }

        let series1 = ChartSeries(data: data1)

        let series2 = ChartSeries(data: data2)
        series2.color = ChartColors.orangeColor()

        switch mode {
        case .hp:
            title = "HP 成长曲线"
            yLabel.text = "HP"
            yLabel.textColor = ChartColors.blueColor()
            series1.color = ChartColors.blueColor()
            chart.add(series1)
        case .atk:
            title = "ATK 成长曲线"
            yLabel.text = "ATK"
            yLabel.textColor = ChartColors.orangeColor()
            series2.color = ChartColors.orangeColor()
            chart.add(series2)
        }

        view.addSubview(chart)
    }

}
