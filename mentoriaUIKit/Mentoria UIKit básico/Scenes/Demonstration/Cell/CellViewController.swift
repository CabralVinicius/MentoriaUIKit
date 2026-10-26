import UIKit

class CellViewController: UIViewController {
    //3
    private let customCell = PokemonTableViewCell(style: .default, reuseIdentifier: "CustomCell")
    //private let service: RequestOperation = RequestOperation()
    private var pokemons: [PokemonID] = []
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
//        service.fetchPokemonUrl(completion: { result in
//            switch result{
//            case .success(let result):
//                self.pokemons = result
//            case .failure(let error):
//                print(error)
//            }
//        })
        super.viewDidLoad()
        
        view.addSubview(customCell.contentView)
        customCell.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customCell.contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customCell.contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            customCell.contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customCell.contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

            customCell.configure(with: pokemons)
    }
}
