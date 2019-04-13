//
//  TextViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 21/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

protocol TextViewControllerDelegate: class {
    func textViewController(_ textViewController: TextViewController, didChange text: String)
}

class TextViewController: UIViewController {

    private lazy var textView: UITextView = create {
        $0.textColor = StyleSheet.Color.textColor
        $0.layer.cornerRadius = 8
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.backgroundColor = StyleSheet.Color.textColor.withAlphaComponent(0.05)
        $0.delegate = self
        $0.keyboardType = .twitter
    }

    weak var delegate: TextViewControllerDelegate?
    var text: String { return textView.text }
    var characterLimit: Int = 280

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }

}

extension TextViewController {

    private func setupView() {
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
    }

    private func setupLayout() {
        [textView].forEach(view.addSubview)
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.topAnchor.constraint(equalTo: view.topAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}

extension TextViewController: UITextViewDelegate {
    func textView(
        _ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String
    ) -> Bool {
        let currentValue = textView.text as NSString? ?? ""
        let updated = currentValue.replacingCharacters(in: range, with: text)
        return updated.count <= characterLimit
    }
    func textViewDidChange(_ textView: UITextView) {
        delegate?.textViewController(self, didChange: text)
    }
}
