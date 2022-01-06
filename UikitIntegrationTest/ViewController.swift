//
//  ViewController.swift
//  UikitIntegrationTest
//
//  Created by Renan Silveira on 4/1/22.
//

import UIKit

import SwiftUI

class ViewController: UIViewController {

  // MARK: - Private Properties

  private lazy var stackView: UIStackView = {
    let stackview = UIStackView()
    stackview.translatesAutoresizingMaskIntoConstraints = false
    stackview.axis = .vertical
    stackview.backgroundColor = .blue
    return stackview
  }()

  private lazy var containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .yellow
    return view
  }()

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setupViewController()
    addElements()
    setupContainerViewConstraints()
    setupStackViewConstraints()
    setupSwiftUIView()
  }

  // MARK: - Private Methods

  private func tapFirstOption() {
    print("NavigationView option")
  }

  private func tapSecondOption() {
    print("Expanding Rows option")
  }

  // MARK: - UI Elements

  private func setupViewController() {
    view.backgroundColor = .red
  }

  private func addElements() {
    view.addSubview(containerView)
    containerView.addSubview(stackView)
  }

  private func setupContainerViewConstraints() {
    containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive = true
    containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60).isActive = true
  }

  private func setupStackViewConstraints() {
    stackView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor).isActive = true
    stackView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor).isActive = true
    stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
  }

  // MARK: - Adding SwiftUI to UIKIt

  private func setupSwiftUIView() {
    let datasource: SampleItem = .init(title: "SwiftUI", items: [
      .init(title: "NavigationView", action: tapFirstOption),
      .init(title: "Expanding Rows", action: tapSecondOption)
    ])

    let collapsible = ContentView(tutorialItems: [datasource])

    let child = UIHostingController(rootView: collapsible)
    child.view.translatesAutoresizingMaskIntoConstraints = false

    stackView.addArrangedSubview(child.view)
  }
}


// MARK: - SwiftUI logic

struct SampleItem: Identifiable {
  let id = UUID()
  let title: String
  var items: [SampleItem]?
  var action: (() -> Void)?
}

struct ContentView: View {
  let tutorialItems: [SampleItem]

  var body: some View {
    List(tutorialItems, children: \.items)
    { tutorial in
      let stack = HStack {
        Text(tutorial.title)
          .foregroundColor(.yellow)
        Spacer()
      }
      .contentShape(Rectangle())

      if let action = tutorial.action {
        stack.onTapGesture {
          action()
        }
      } else {
        stack
      }
      Spacer(minLength: 4)
        .background(Color.green)
    }
  }
}
