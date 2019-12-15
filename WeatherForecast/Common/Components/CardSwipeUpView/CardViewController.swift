import UIKit

class CardViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var handlerArea: UIView!
    @IBOutlet weak var tableview: UITableView!
    
    var items = [Home.CircleViewModel.HomeViewDataSourceModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.separatorStyle = .none
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        let cellView = FavouritesView.init(frame: cell.contentView.frame)
        cellView.options(items: items, intexPath: indexPath)
        cell.addSubview(cellView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }

}
