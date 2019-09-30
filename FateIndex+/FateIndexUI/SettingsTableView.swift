////
////  SettingsTableView.swift
////  FateIndex+
////
////  Created by Peter Guan on 2019/7/31.
////  Copyright © 2019 管君. All rights reserved.
////
//
//import UIKit
//
//class SettingsTableView: UITableView {
//
//    public enum CellsLayoutType {
//        /// Completely ignore 'narrow container'
//        case fullScreen
//        /// Forced to use 'narrow container'
//        case narrow
//        /// Decides if use 'narrow container' or not automaticly
//        case automatic
//    }
//
//    // MARK: Static
//
//    // Use custom value for left and right layout margins
//    public static let defaultHorizontalMargin: CGFloat = 16
//
//    fileprivate static let cellIdentifierToCellClassDictionnary: [String: AnyClass] = [
//        ActionTableViewCell.identifier: ActionTableViewCell.self,
//        ActionsTableViewCell.identifier: ActionsTableViewCell.self,
//        ActivityIndicatorTableViewCell.identifier: ActivityIndicatorTableViewCell.self,
//        ArrowTableViewCell.identifier: ArrowTableViewCell.self,
//        CenteredLabelTableViewCell.identifier: CenteredLabelTableViewCell.self,
//        CheckboxTableViewCell.identifier: CheckboxTableViewCell.self,
//        DaysOfWeekPickerTableViewCell.identifier: DaysOfWeekPickerTableViewCell.self,
//        DayOfWeekTimeDatePickerTableViewCell.identifier: DayOfWeekTimeDatePickerTableViewCell.self,
//        FormTextFieldTableViewCell.identifier: FormTextFieldTableViewCell.self,
//        ImageTableViewCell.identifier: ImageTableViewCell.self,
//        PlainTableViewCell.identifier: PlainTableViewCell.self,
//        SwitchTableViewCell.identifier: SwitchTableViewCell.self,
//        TextFieldTableViewCell.identifier: TextFieldTableViewCell.self,
//        TextViewTableViewCell.identifier: TextViewTableViewCell.self,
//        TwoLinesArrowTableViewCell.identifier: TwoLinesArrowTableViewCell.self,
//        TwoLinesCheckboxTableViewCell.identifier: TwoLinesCheckboxTableViewCell.self,
//        MarkupTextTableViewCell.identifier: MarkupTextTableViewCell.self,
//        TimeDatePickerTableViewCell.identifier: TimeDatePickerTableViewCell.self,
//        TwoLabelTableViewCell.identifier: TwoLabelTableViewCell.self,
//        TwoLabelWithArrowTableViewCell.identifier: TwoLabelWithArrowTableViewCell.self,
//    ]
//
//    // MARK: - Instance -
//
//    open var cellsLayoutType: CellsLayoutType = .automatic {
//        didSet {
//            setupSeparatorStyle()
//        }
//    }
//
//    // MARK: Init
//
//    @objc public init(frame: CGRect, tableViewCellIdentifiers: [String]?) {
//        super.init(frame: frame, style: .grouped)
//
//        // Style
//        backgroundColor = .underPageBackground
//        setupSeparatorStyle()
//
//        // Default Section Headers/Footers Heights
//        sectionHeaderHeight = 0.0
//        sectionFooterHeight = 0.0
//
//        // Register Header/Footer Cells
//        register(ACTableHeaderView.self, forHeaderFooterViewReuseIdentifier: ACTableHeaderView.identifier)
//        register(ACTableFooterView.self, forHeaderFooterViewReuseIdentifier: ACTableFooterView.identifier)
//
//        // Register Table Cells
//        if let tableViewCellIdentifiers = tableViewCellIdentifiers {
//            for cellIdentifier in tableViewCellIdentifiers {
//                if let cellClass: AnyClass = ACGroupedTableView.cellIdentifierToCellClassDictionnary[cellIdentifier] {
//                    register(cellClass, forCellReuseIdentifier: cellIdentifier)
//                }
//            }
//        }
//
//        // Observations
//        addObserver(self, forKeyPath: "frame", options: .new, context: nil)
//
//        // Keep the cell layout margins fixed
//        cellLayoutMarginsFollowReadableWidth = false
//    }
//
//    public convenience init(frame: CGRect) {
//        self.init(frame: frame, tableViewCellIdentifiers: nil)
//    }
//
//    public required init(coder aDecoder: NSCoder) { fatalError() }
//
//    deinit {
//        // Observations
//        removeObserver(self, forKeyPath: "frame")
//    }
//
//    // MARK: UITableView
//
//    override open func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell? {
//        let cell = super.dequeueReusableCell(withIdentifier: identifier)
//
//        if let narrowSupportCell = cell as? ACTableViewCell {
//            narrowSupportCell.cellsLayoutType = cellsLayoutType
//        }
//
//        return cell
//    }
//
//    override open func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
//        let cell = super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
//
//        if let narrowSupportCell = cell as? ACTableViewCell {
//            narrowSupportCell.cellsLayoutType = cellsLayoutType
//        }
//
//        return cell
//    }
//
//    // MARK: Setup
//
//    fileprivate func setupSeparatorStyle() {
//        separatorStyle = shouldShowNarrowContainerOnCells() ? .none : .singleLine
//        separatorColor = .divider
//    }
//
//    fileprivate func shouldShowNarrowContainerOnCells() -> Bool {
//        switch cellsLayoutType {
//        case .fullScreen:
//            return false
//
//        case .narrow:
//            return true
//
//        case .automatic:
//            return traitCollection.horizontalSizeClass == .regular
//        }
//    }
//
//    // MARK: Table Header View
//
//    fileprivate var tableHeaderViewWrapper: UIView? {
//        didSet {
//            tableHeaderView = tableHeaderViewWrapper
//        }
//    }
//    open var tableHeaderViewLayoutCallback: (() -> Void)?
//
//    open func setTableHeaderView(_ tableHeaderView: UIView?, withLayoutCallback layoutCallback: (() -> Void)?) {
//        // TODO @AP@: Check that there's no retain cycles
//        tableHeaderViewWrapper = tableHeaderView
//        tableHeaderViewLayoutCallback = layoutCallback
//    }
//
//    // MARK: Observations
//
//    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
//        if object as? NSObject == self && keyPath == "frame" {
//            if let tableHeaderViewWrapper = tableHeaderViewWrapper {
//                // Layout Table Header View
//                tableHeaderViewLayoutCallback?()
//
//                // Reset Table Header View On Each Layout. UITableView doesn't resize
//                // tableHeaderView properly. The workaround is to reset it on each
//                // layout but we can't do that in layout methods such as layoutSubviews,
//                // viewWillLayoutSubviews or viewDidLayoutSubviews because it triggers a
//                // new layout pass, then an infinite layout loop. Hence, we observe the
//                // tableView's frame and reset tableHeaderView before the layout pass is
//                // triggered.
//                tableHeaderView = tableHeaderViewWrapper
//            }
//        }
//    }
//
//    // MARK: TraitEnvironment
//
//    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        super.traitCollectionDidChange(previousTraitCollection)
//        setupSeparatorStyle()
//        setNeedsLayout()
//    }
//
//}
//
