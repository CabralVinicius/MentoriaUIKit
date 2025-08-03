import UIKit

class PokemonDetailViewController: UIViewController {
    private let pokemon: PokemonDetail
    private let detailView = PokemonDetailView()

    init(pokemon: PokemonDetail) {
        self.pokemon = pokemon
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }

    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = pokemon.name.capitalized
        detailView.configure(with: pokemon)
    }
}
