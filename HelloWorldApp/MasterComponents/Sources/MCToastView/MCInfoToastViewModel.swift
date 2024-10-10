//
//  MCInfoToastViewModel.swift
//  MasterComponents
//
//  Created by Anton Vlezko on 27/05/2024.
//  Copyright (c) 2024 Smart Lads Software. All rights reserved.

import SnapKit
import UIKit
import Common
import Resources

// MARK: - View Model

public struct MCInfoToastViewModel: Equatable {

    // MARK: Construction

    public init(
        text: String,
        mode: Mode = .bottom,
        isError: Bool = false,
        bottomOffset: CGFloat? = nil
    ) {
        self.text = text
        self.mode = mode
        self.isError = isError
        self.bottomOffset = bottomOffset
    }

    // MARK: Properties

    public enum Mode {
        case top, bottom, none
    }

    public let text: String
    public let mode: Mode
    public let bottomOffset: CGFloat?
    public var isError: Bool
}

public class MCInfoToastView: UIView {

    // MARK: Private Properties

    private var mode: MCInfoToastViewModel.Mode = .bottom
    private var topConstraint: Constraint?
    private var bottomConstraint: Constraint?
    private var viewBottomOffset: CGFloat = Constants.viewTopBottomOffset
    private var bottomOffset: CGFloat {
        let value = frame.height + (mode == .top ? Constants.viewTopBottomOffset : viewBottomOffset)
        return mode == .top ? -value : value
    }

    // MARK: UI Properties

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        return label
    }()

    // MARK: Init

    public init() {
        super.init(frame: .zero)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Methods

    public func showInfo(viewModel: MCInfoToastViewModel, completion: (() -> Void)? = nil) {
        guard isHidden else {
            return
        }

        mode = viewModel.mode
        if let bottomOffset = viewModel.bottomOffset {
            viewBottomOffset = bottomOffset
            bottomConstraint?.update(offset: -viewBottomOffset)
        }

        if viewModel.isError {
            backgroundColor = .systemRed
        }
        infoLabel.attributedText = viewModel.text.style(
            .body,
            color: .buttonTextColor,
            alignment: .left
        )
        show()
        hide(completion: completion)
    }

    public func updateViewConstraints() {
        snp.makeConstraints {
            let viewTopOffset = UIApplication.shared.currentKeyWindow?.safeAreaInsets.top ?? .zero
            topConstraint = $0.top.equalToSuperview().offset(viewTopOffset).constraint
            bottomConstraint = $0.bottom.equalToSuperview().offset(-viewBottomOffset).constraint
            $0.height.greaterThanOrEqualTo(Constants.viewHeight)
            $0.leading.trailing.equalToSuperview().inset(Constants.horizontalInsets)
        }
    }
}

// MARK: - ViewConfigurable

extension MCInfoToastView: ViewConfigurable {

    public func configureViews() {
        isHidden = true
        backgroundColor = .buttonBackgroundColor
        layer.cornerRadius = MCConstants.shimmerLabelCornerRadius
        addSubview(infoLabel)
    }

    public func configureConstraints() {
        infoLabel.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets(
                vertical: Constants.verticalInsets,
                horizontal: Constants.horizontalInsets
            ))
        }
    }
}

// MARK: - Private Methods

fileprivate extension MCInfoToastView {

    func show() {
        guard mode != .none else {
            isHidden = false
            return
        }

        mode == .top ? topConstraint?.activate() : topConstraint?.deactivate()
        mode == .top ? bottomConstraint?.deactivate() : bottomConstraint?.activate()
        isHidden = false
        setNeedsLayout()
        layoutIfNeeded()
        transform = CGAffineTransform(translationX: 0, y: bottomOffset)

        UIView.animate(withDuration: Constants.animateInfoViewWithDuration) {
            self.transform = .identity
        }
    }

    func hide(completion: (() -> Void)?) {
        guard mode != .none else {
            return
        }

        UIView.animate(
            withDuration: Constants.animateInfoViewWithDuration,
            delay: Constants.animateInfoViewWithDelay,
            animations: {
                self.transform = CGAffineTransform(translationX: 0, y: self.bottomOffset)
            },
            completion: {_ in
                self.isHidden = true
                completion?()
            }
        )
    }
}

// MARK: - Constants

fileprivate extension MCInfoToastView {

    enum Constants {
        static let animateInfoViewWithDuration: TimeInterval = 0.5
        static let animateInfoViewWithDelay: TimeInterval = 4.0
        static let viewTopBottomOffset: CGFloat = 56
        static let viewHeight: CGFloat = 48
        static let verticalInsets: CGFloat = 14
        static let horizontalInsets: CGFloat = 16
    }
}

