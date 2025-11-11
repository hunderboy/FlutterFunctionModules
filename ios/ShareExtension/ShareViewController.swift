//  ShareViewController.swift
import UIKit
import Flutter
import UniformTypeIdentifiers

// 기본 코드
class ShareViewController: UIViewController {

    override func viewDidLoad() {
        print("viewDidLoad 출력")
        super.viewDidLoad()

        showFlutter()
    }


    func showFlutter() {
        print("showFlutter 출력")

        let flutterViewController = FlutterViewController(
            project: nil,
            initialRoute: "/share",
            nibName: nil,
            bundle: nil
        )

        addChild(flutterViewController)
        view.addSubview(flutterViewController.view)
        flutterViewController.view.frame = view.bounds

        flutterViewController.didMove(toParent: self)
    }
}

// ShareExtension 에 Swift 코드의 List 를 적용한 코드
// class ShareViewController: UIViewController {
//
//     private lazy var tableView: UITableView = {
//         let table = UITableView()
//         table.delegate = self
//         table.dataSource = self
//         table.translatesAutoresizingMaskIntoConstraints = false
//
//         // 스크롤이 top에 있을 때만 sheet dismiss 가능하도록
//         table.bounces = true
//         table.alwaysBounceVertical = true
//
//         return table
//     }()
//
//     override func viewDidLoad() {
//         super.viewDidLoad()
//
//         isModalInPresentation = true         // 모달 드래그로 닫기 비활성화
//
//         setupUI()
//
//         // Sheet 설정 (iOS 15+)
//         if let presentationController = presentationController as? UISheetPresentationController {
//             presentationController.detents = [.medium(), .large()]
//             presentationController.prefersGrabberVisible = true
//
//             // 중요: 스크롤뷰 설정으로 중첩 해결
//             presentationController.prefersScrollingExpandsWhenScrolledToEdge = false
//         }
//     }
//
//     private func setupUI() {
//         view.addSubview(tableView)
//
//         NSLayoutConstraint.activate([
//             tableView.topAnchor.constraint(equalTo: view.topAnchor),
//             tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//             tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//         ])
//     }
// }
//
// extension ShareViewController: UITableViewDelegate, UITableViewDataSource {
//     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//         return 20
//     }
//
//     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
//         cell.textLabel?.text = "Item \(indexPath.row + 1)"
//         return cell
//     }
// }