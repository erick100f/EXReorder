//
//  EXReorderViewController.swift
//  EXReorder
//
//  Created by Erick Cienfuegos on 27/10/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import UIKit

protocol EXReorderViewControllerDelegate: class {
    func wrong(element: EXReorder, message: String?)
    func success(element: EXReorder, message: String?)
    func refresh()
}

class EXReorderViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var controllView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private let presenter = EXReorderPresenter(service: EXReorderService())
    
    var elements: [EXReorder] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        title = "EXReorder"
        setup()
    }
    
    func setup(){
        tableView.delegate = self
        tableView.dataSource = self
        
        textField.delegate = self
        
        button.layer.cornerRadius = button.frame.height / 2
        button.setTitle("Go!", for: .normal)
        button.backgroundColor = .green
        
        clear()
    }
    
    private func showError(message: String?){
        controllView.backgroundColor = .red
        showMessage(message)
    }
    
    private func showInfo(message: String?){
        controllView.backgroundColor = .blue
        showMessage(message)
    }
    
    private func showMessage(_ message: String?){
        if let message = message {
            infoLabel.text = message
        }
    }
    
    private func add(_ element: EXReorder){
        elements.insert(element, at: 0)
        
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(integersIn: 0...0), with: .automatic)
        tableView.endUpdates()
        view.endEditing(true)
    }

    func clear(){
        controllView.backgroundColor = .white
//        button.backgroundColor = .gray
        infoLabel.text = ""
    }

    // MARK: - IBActions
    @IBAction func addTapped(_ sender: Any) {
        clear()
        if let text = textField.text {
            let element = EXReorder(inn: text, out: nil, status: nil)
            presenter.reorderRequest(element: element)
        }else{
            print("Add textfirs ")
        }
        
    }

}


extension EXReorderViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = elements[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(element.inn) -> \(element.out ?? EXMessagesError.upps)"
        if let status = element.status,status == .ok  {
            cell.backgroundColor = .clear
        }else {
            cell.backgroundColor = .purple
        }
        return cell
    }
    
}

extension EXReorderViewController: EXReorderViewControllerDelegate {
    func wrong(element: EXReorder, message: String?){
        print("wrong")
        add(element)
        showError(message: message)
    }
    
    func success(element: EXReorder, message: String?){
        clear()
        add(element)
        showInfo(message: message)
    }
    func refresh() {
        clear()
    }
}


extension EXReorderViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        clear()
    }
}
