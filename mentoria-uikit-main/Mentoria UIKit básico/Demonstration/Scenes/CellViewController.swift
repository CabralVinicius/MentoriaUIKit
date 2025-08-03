import UIKit

class CellViewController: UIViewController {
    // 1) Recebemos o modelo no init e guardamos como let
    private let pokemon: PokemonDetail
    private let customCell: PokemonTableViewCell = {
        let cell = PokemonTableViewCell(style: .default,
                                        reuseIdentifier: PokemonTableViewCell.identifier)
        // Opcional: remove qualquer seleção
        cell.selectionStyle = .none
        return cell
    }()

    // 2) Init personalizado
    init(pokemon: PokemonDetail) {
        self.pokemon = pokemon
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 3) Montamos a view
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = pokemon.name.capitalized

        // Adiciona a célula inteira como subview
        view.addSubview(customCell)
        customCell.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Centraliza verticalmente, com largura igual à view
            customCell.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            customCell.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customCell.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // Altura fixa ou baseada no conteúdo:
            customCell.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])

        // 4) Configura com o modelo
        customCell.configure(with: pokemon)
    }
}
