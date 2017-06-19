//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import Eureka

// MARK: SegueCell

open class SegueCellOf<T: Equatable>: Cell<T>, CellType {

    public required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func update() {
        super.update()
        selectionStyle = row.isDisabled ? .none : .default
        accessoryType = .none
        editingAccessoryType = accessoryType
        textLabel?.textAlignment = .center
        textLabel?.textColor = tintColor
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        tintColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        textLabel?.textColor = UIColor(red: red, green: green, blue: blue, alpha: row.isDisabled ? 0.3 : 1.0)
    }

    open override func didSelect() {
        super.didSelect()
        row.deselect()
    }
}

// MARK: SegueRow

open class _SegueRowOf<T: Equatable>: Row<SegueCellOf<T>> {
    open var controller: UIViewController.Type?

    public required init(tag: String?) {
        super.init(tag: tag)
        displayValueFor = nil
        cellStyle = .default
    }

    open override func customDidSelect() {
        super.customDidSelect()
        if !isDisabled {
            if let controller = controller {
                let dest = controller.init()
                cell.formViewController()?.pushTo(dest, tag: self.tag)
            }
        }
    }

    open override func customUpdateCell() {
        super.customUpdateCell()
        let leftAligmnment = controller != nil
        cell.textLabel?.textAlignment = leftAligmnment ? .left : .center
        cell.accessoryType = !leftAligmnment || isDisabled ? .none : .disclosureIndicator
        cell.editingAccessoryType = cell.accessoryType
        if !leftAligmnment {
            var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
            cell.tintColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            cell.textLabel?.textColor = UIColor(red: red, green: green, blue: blue, alpha: isDisabled ? 0.3 : 1.0)
        } else {
            cell.textLabel?.textColor = nil
        }
    }
}

/// A generic row with a button. The action of this button can be anything but normally will push a new view controller
public final class SegueRowOf<T: Equatable>: _SegueRowOf<T>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}

/// A row with a button and String value. The action of this button can be anything but normally will push a new view controller
public typealias SegueRow = SegueRowOf<String>
