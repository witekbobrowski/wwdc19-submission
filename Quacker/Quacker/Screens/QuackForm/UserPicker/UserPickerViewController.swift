//
//  UserPickerViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 23/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

class UserPickerViewController: UIViewController {

    private let userService = UserService()

    private lazy var scrollView: UIScrollView = create {
        $0.isPagingEnabled = false // We will use custom paging
        $0.decelerationRate = .fast
        $0.showsHorizontalScrollIndicator = false
        $0.delegate = self
    }

    private let stackView: UIStackView = create {
        $0.spacing = 16
        $0.alignment = .center
        $0.distribution = .fillEqually
    }

    private let maskLayer: CAGradientLayer = create {
        $0.colors = [UIColor.clear, .black, .black, .clear].map { $0.cgColor }
        $0.locations = [0, 0.25, 0.75, 1]
        $0.startPoint = CGPoint(x: 0, y: 0.5)
        $0.endPoint = CGPoint(x: 1, y: 0.5)
    }

    private var users = [User]() {
        didSet { reload(with: users) }
    }
    private var contentViewControllers = [UIViewController]() {
        didSet { reloadContent(old: oldValue, new: contentViewControllers) }
    }

    var current: User? { didSet { scrollToUser(current) } }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        users = userService.fetch()
        current = users.first
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let inset = view.bounds.width/2 - view.bounds.height/2
        scrollView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        maskLayer.frame = view.bounds
    }

    @objc private func didTapUserAvatar(sender: UIGestureRecognizer) {
        guard
            let view = sender.view,
            let index = stackView.arrangedSubviews.firstIndex(where: { $0 == view })
        else { return }
        current = users[index]
    }

}

extension UserPickerViewController {

    private func reload(with users: [User]) {
        contentViewControllers = users.map { user in
            let viewController = FeedCellAvatarViewController()
            viewController.avatar = user.avatar
            viewController.avatarBackgroundColor = .clear
            viewController.view.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(didTapUserAvatar))
            )
            return viewController
        }
    }

    private func reloadContent(old: [UIViewController], new: [UIViewController]) {
        old.forEach { $0.moveFromParent() }
        new.forEach(add)
        updateStackView(with: new)
    }

    private func updateStackView(with content: [UIViewController]) {
        stackView.removeArrangedSubviews()
        content.map { $0.view }.forEach(stackView.addArrangedSubview)
    }

    private func setupView() {
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.mask = maskLayer
        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }

    private func scrollToUser(_ user: User?) {
        guard
            let user = user,
            let index = users.firstIndex(where: { $0.username == user.username })
            else { return }
        scrollWithAnimation(to: contentViewControllers[index].view)
    }

    /// Retrive horizontal center point of each item in stackView. Returned
    /// values are in relation to the super view.
    private func getItemCenters(from stackView: UIStackView) -> [CGFloat] {
        return stackView.arrangedSubviews.map { getItemOffset(from: $0) }
    }

    /// Function that looks for the center of the item that is closes to the
    /// point where ScrollView would normally stop.
    private func getNearestItemLocation(current target: CGPoint) -> CGPoint {
        let centers = getItemCenters(from: stackView)
        // Do not do nothing if there are no items
        if centers.isEmpty { return target }
        // Make sure there are more items the one, else return the single item location
        guard centers.count > 1 else {
            return CGPoint(x: centers[0], y: target.y)
        }
        // Proceed to find nearest located item
        var nearest: CGFloat = .greatestFiniteMagnitude
        for location in centers {
            let distance = abs(location - target.x)
            // If distance to current location is bigger the to the previous one,
            // we can break the loop and return the previous location.
            guard distance < abs(nearest - target.x) else { break }
            nearest = location
        }
        return CGPoint(x: nearest, y: target.y)
    }

    /// Function that will select an item when ScrollView stops decelerating
    /// and lands in the center of the item.
    private func updateCurrentItem(_ offset: CGPoint) {
        let centers = getItemCenters(from: stackView)
        let index = centers.firstIndex(where: {
            abs(offset.x - $0) < 8 // Allow for 8px error
        })
        current = index.map { users[$0] }
    }

    /// Function to animate scroll after item was manually selected (tapped).
    private func scrollWithAnimation(to subview: UIView) {
        var offset = scrollView.contentOffset
        offset.x = getItemOffset(from: subview)
        scrollView.setContentOffset(offset, animated: true)
    }

    /// Calculates the offset needed center the StackView item in ScrollView.
    private func getItemOffset(from subview: UIView) -> CGFloat {
        let fullWidth = scrollView.bounds.width
        return subview.frame.midX - fullWidth / 2
    }

}

extension UserPickerViewController: UIScrollViewDelegate {

    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        // Custom paging, since the we want the page to be equal to 1 item width
        let location = getNearestItemLocation(current: targetContentOffset.pointee)
        targetContentOffset.pointee = location
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateCurrentItem(scrollView.contentOffset)
    }

}
