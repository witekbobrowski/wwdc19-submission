//
//  FeedViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 19/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

protocol FeedViewControllerDelegate: class {
    func feedViewController(
        _ feedViewController: FeedViewController, didSelect quack: Quack
    )
}

class FeedViewController: UIViewController {

    private lazy var tableView: UITableView = create {
        $0.estimatedRowHeight = 80
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
        $0.register(TableViewCell.self)
    }

    private let quacksService = QuacksService()

    private var contentViewControllers = [UIViewController]() {
        didSet {
            reloadContent(old: oldValue, new: contentViewControllers)
        }
    }

    weak var delegate: FeedViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        contentViewControllers = quacksService.fetch().map { quack in
            let viewcontroller = FeedCellViewController()
            viewcontroller.quack = quack
            return viewcontroller
        }
    }

}

extension FeedViewController {
    private func setupView() {
        view.addSubview(tableView)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    private func reloadContent(old: [UIViewController], new: [UIViewController]) {
        old.forEach { $0.moveFromParent() }
        new.forEach(add)
        tableView.reloadData()
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard
            let viewController = contentViewControllers[indexPath.row] as? FeedCellViewController,
            let quack = viewController.quack
        else { return }
        delegate?.feedViewController(self, didSelect: quack)
    }
}

extension FeedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentViewControllers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(TableViewCell.self, for: indexPath)
        cell.hostedView = contentViewControllers[indexPath.row].view
        return cell
    }
}
