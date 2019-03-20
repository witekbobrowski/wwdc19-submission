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
        $0.register(TableViewCell.self)
    }

    private var contentViewControllers = [UIViewController]() {
        didSet {
            reloadContent(old: oldValue, new: contentViewControllers)
        }
    }

    var quacks: [Quack] = [] {
        didSet {
            contentViewControllers = quacks.map { _ in
                FeedCellViewController()
            }
        }
    }

    weak var delegate: FeedViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension FeedViewController {
    private func setupView() {
        navigationItem.title = "Latest Quacks"
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    private func reloadContent(old: [UIViewController], new: [UIViewController]) {
        old.forEach { viewController in
            viewController.willMove(toParent: nil)
            viewController.removeFromParent()
        }
        new.forEach { viewController in
            addChild(viewController)
            viewController.didMove(toParent: self)
        }
        tableView.reloadData()
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.feedViewController(self, didSelect: quacks[indexPath.row])
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
