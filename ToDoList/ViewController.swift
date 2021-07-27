//
//  ViewController.swift
//  ToDoList
//
//  Created by Stepan Ilmukov on 27.07.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    private let table: UITableView  = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = UserDefaults.standard.stringArray(forKey: "items") ?? []
        title = "Ту-ду лист"
        view.addSubview(table)
        table.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "Добавить новый пункт", message: "Добавить новое значение в список", preferredStyle: .alert)
        
        alert.addTextField { field in field.placeholder = "Введите текст"
            
        }
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler:  { [weak self](_) in
            if let field = alert .textFields?.first {
                if let text = field.text, !text.isEmpty {
                    
                    // добавление нового пункта
                    DispatchQueue.main.async {
                        var currentsItems = UserDefaults.standard.stringArray(forKey: "items") ?? []
                        
                        currentsItems.append(text)
                        UserDefaults.standard.setValue(currentsItems, forKey: "Items")
                        self?.items.append(text)
                        self?.table.reloadData()
                    }
                }
            }
        }))
        
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    


}

