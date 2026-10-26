import UIKit
class PokemonDetailViewController: UIViewController {
    let pokemonDetail = PokemonDetailView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view = pokemonDetail
        pokemonDetail.configure(with: .mock())
    }
}
