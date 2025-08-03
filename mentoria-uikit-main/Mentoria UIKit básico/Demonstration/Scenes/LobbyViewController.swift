import UIKit

class LobbyViewController: UIViewController {

    private lazy var listButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Lista (150 Pokémons)", for: .normal)
        btn.addTarget(self, action: #selector(goToList), for: .touchUpInside)
        return btn
    }()

    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [listButton])
        sv.axis = .vertical
        sv.spacing = 20
        sv.alignment = .center
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lobby"
        view.backgroundColor = .white
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    // MARK: – Actions
    @objc private func goToList() {
        let vc = PokemonListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
