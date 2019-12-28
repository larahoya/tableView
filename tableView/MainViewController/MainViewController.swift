import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    private var tasks: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func configureView() {
        textField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self

        let nibName = NSStringFromClass(TaskCell.self).components(separatedBy: ".").last!
        let nibBundle = Bundle(for: TaskCell.self)
        let cellNib = UINib(nibName: nibName, bundle: nibBundle)
        tableView.register(cellNib, forCellReuseIdentifier: TaskCell.reuseIdentifier)
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tasks.insert(textField.text!, at: 0)
        textField.text = ""
        tableView.reloadData()
        return true
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskCell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier, for: indexPath) as! TaskCell
        cell.taskLabel.text = tasks[indexPath.row]
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
}
