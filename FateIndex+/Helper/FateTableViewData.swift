//
//  FateTableViewData.swift
//  FateIndex+
//
//  Created by Peter-Guan on 2020/3/18.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

/**
 FateTableViewData is a helper class that can be used to link two enum's (Section and Row) values to their index path in a table view.
 */
public struct FateTableViewData<Section: Equatable, Row: Equatable> {

    private struct SectionData {
        let section: Section
        var rows = [Row]()
    }

    // MARK: Private

    private var sections = [SectionData]()

    // MARK: Init

    public init() {}

    // MARK: Public

    public var sectionCount: Int {
        return sections.count
    }

    public func rowCount(at sectionIndex: Int) -> Int {
        return sections[sectionIndex].rows.count
    }

    public func rows(at sectionIndex: Int) -> [Row] {
        return sections[sectionIndex].rows
    }

    // Section operations

    public mutating func append(section: Section, with rows: [Row] = [Row]()) {
        insert(section: section, at: sections.count, with: rows)
    }

    public mutating func insert(section: Section, at sectionIndex: Int, with rows: [Row] = [Row]()) {
        let data = SectionData(section: section, rows: rows)
        sections.insert(data, at: sectionIndex)
    }

    /// Return index of removed section, if it was present
    @discardableResult public mutating func remove(section: Section) -> Int? {
        guard let index = index(section: section) else {
            return nil
        }

        sections.remove(at: index)
        return index
    }

    public mutating func remove(sections: [Section]) {
        sections.forEach { remove(section: $0) }
    }

    public mutating func removeAll() {
        sections.removeAll()
    }

    // Row operations

    public mutating func append(rows: [Row], to section: Section) {
        guard let sectionIndex = index(section: section) else {
            assertionFailure("Section not found to append rows section=\(section)")
            return
        }

        sections[sectionIndex].rows.append(contentsOf: rows)
    }

    public mutating func append(row: Row, to section: Section) {
        guard let sectionIndex = index(section: section) else {
            assertionFailure("Section not found to append rows section=\(section)")
            return
        }

        insert(row: row, at: rowCount(at: sectionIndex), to: section)
    }

    public mutating func insert(row: Row, at rowIndex: Int, to section: Section) {
        guard let sectionIndex = index(section: section) else {
            assertionFailure("Section not found to insert row section=\(section)")
            return
        }

        sections[sectionIndex].rows.insert(row, at: rowIndex)
    }

    public mutating func set(row: Row, at rowIndex: Int, in section: Section) {
        guard let sectionIndex = index(section: section) else {
            assertionFailure("Section not found to set row section=\(section)")
            return
        }

        sections[sectionIndex].rows[rowIndex] = row
    }

    /// Return index path of removed row, if it was present
    @discardableResult public mutating func remove(row: Row, from section: Section) -> IndexPath? {
        guard let sectionIndex = index(section: section), let rowIndex = sections[sectionIndex].rows.firstIndex(of: row) else {
            return nil
        }

        sections[sectionIndex].rows.remove(at: rowIndex)
        return IndexPath(row: rowIndex, section: sectionIndex)
    }

    public func isEmpty() -> Bool {
        if sections.contains(where: { !$0.rows.isEmpty }) {
            return false
        }
        return true
    }

    // IndexPath operations

    public func section(at sectionIndex: Int) -> Section {
        assert((0..<sections.count).contains(sectionIndex), "index is out of bounds (index = \(sectionIndex), section count = \(sections.count)")
        return sections[sectionIndex].section
    }

    public func row(at indexPath: IndexPath) -> Row {
        assert((0..<sections.count).contains(indexPath.section), "index is out of bounds for section (section index = \(indexPath.section), section count = \(sections.count)")
        assert((0..<sections[indexPath.section].rows.count).contains(indexPath.row), "index is out of bounds for row (row index = \(indexPath.row), row count = \(sections[indexPath.section].rows.count)")
        return sections[indexPath.section].rows[indexPath.row]
    }

    public func index(section: Section) -> Int? {
        return sections.firstIndex { $0.section == section }
    }

    public func indexPath(section: Section, row: Row) -> IndexPath? {
        guard let sectionIndex = index(section: section), let rowIndex = sections[sectionIndex].rows.firstIndex(of: row) else {
            return nil
        }

        return IndexPath(row: rowIndex, section: sectionIndex)
    }

    public func indexPaths(section: Section) -> [IndexPath]? {
        guard let sectionIndex = index(section: section) else {
            return nil
        }

        return (0..<sections[sectionIndex].rows.count).map { IndexPath(row: $0, section: sectionIndex) }
    }

}
