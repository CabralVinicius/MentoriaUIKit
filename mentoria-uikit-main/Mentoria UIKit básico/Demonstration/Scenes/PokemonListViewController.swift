import UIKit

class PokemonListViewController: UIViewController {
    private let service = PokemonService()
    private var pokemons: [PokemonDetail] = []
    private var isLoading = true
    private let cacheKey = "cachedPokemons"

    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.dataSource = self
        tv.delegate = self
        tv.register(PokemonTableViewCell.self,
                    forCellReuseIdentifier: PokemonTableViewCell.identifier)
        tv.rowHeight = 80
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokédex"
        view.backgroundColor = .white
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        if loadCache() {
            // já temos dados, exibe sem skeleton
            isLoading = false
            tableView.reloadData()
        } else {
            // não há cache: busca da rede
            loadPokemons()
        }
    }
}

// MARK: - UITableViewDataSource
extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLoading ? 50 : pokemons.count
    }

    func tableView(_ tv: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tv.dequeueReusableCell(
                withIdentifier: PokemonTableViewCell.identifier,
                for: indexPath) as? PokemonTableViewCell
        else { fatalError() }
        
        if isLoading {
            cell.showSkeleton()
        } else {
            let detail = pokemons[indexPath.row]
            cell.configure(with: detail)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PokemonListViewController: UITableViewDelegate {
    func tableView(_ tv: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        guard !isLoading else { return }
        let detail = pokemons[indexPath.row]
        let vc = PokemonDetailViewController(pokemon: detail)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PokemonListViewController {
    private func loadPokemons() {
        isLoading = true
        tableView.reloadData()

        Task {
            do {
                let list = try await service.fetchFirst150Details()
                self.pokemons = list

                saveCache()

                isLoading = false
                tableView.reloadData()
            } catch {
                print("❌ erro ao buscar pokémons:", error)
                isLoading = false
                tableView.reloadData()
                // por um UIAlert depois
            }
        }
    }

    // MARK: — Cache Helpers
    private func loadCache() -> Bool {
        let defaults = UserDefaults.standard
        guard let data = defaults.data(forKey: cacheKey) else {
            return false
        }
        do {
            let decoded = try JSONDecoder().decode([PokemonDetail].self, from: data)
            self.pokemons = decoded
            return true
        } catch {
            print("⚠️ erro ao decodificar cache:", error)
            return false
        }
    }

    private func saveCache() {
        do {
            let data = try JSONEncoder().encode(pokemons)
            UserDefaults.standard.set(data, forKey: cacheKey)
        } catch {
            print("⚠️ erro ao codificar cache:", error)
        }
    }
}
