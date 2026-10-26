import UIKit

class PokemonListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //let service = RequestOperation()
    var pokemonID: [PokemonID] = []

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "CustomCell")//devo chamar uma TableViewCell?
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        fetchID()
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
    func fetchID(){
//        service.fetchPokemonUrl { result in
//            switch result{
//            case .success(let result):
//                self .pokemonID = result
//            case .failure:
//                print("Caiu na falha")
//                break
//            }
//        }
    }
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: pokemonID)

        
        //cell.configure(with: Pokemon.mock())
        return cell
    }
}




