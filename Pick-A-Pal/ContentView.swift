//
//
//import SwiftUI
//let gradientColors: [Color] = [
//    .gradientTop,
//    .gradientBottom
//]
//struct ContentView: View {
//    @State private var names: [String] = ["Aditya","Nandani","Eklavya","Sumedha"]
//    @State private var nameToAdd = ""
//    @State private var pickedName = ""
//    @State private var shouldRemovePickedName = false
//    @State private var deleteAction = ""
//    var body: some View {
//        VStack {
//
//           Text("Name Chooser")
//                    .font(Font.title)
//                    .bold()
//                    .background(){
//                        RoundedRectangle(cornerRadius: 10)
//                            .frame(width:400,height: 50)
//                            .foregroundStyle(.black)
//                            .opacity(0.25)
//
//                    }
//            }
//            List{
//                ForEach(names, id: \.description){ name in
//                    Text(name)
//
//                }
//            }
//            HStack{
//                Text("Picked Name is: ")
//
//                Text(pickedName.isEmpty ? "":pickedName)
//            }
//            Divider()
//            TextField("        Add Name",text: $nameToAdd)
//                .autocorrectionDisabled()
//                .onSubmit {
//                if !nameToAdd.isEmpty{
//                    names.append(nameToAdd)
//                    nameToAdd = ""
//                }
//            }
//            Divider()
//            Toggle("      Remove When Picked" , isOn: $shouldRemovePickedName)
//            Button("Pick A Random Name"){
//                if let randomName = names.randomElement(){
//                    pickedName = randomName
//                    if shouldRemovePickedName{
//                        names.removeAll(){name in
//                            return (name==randomName)
//                        }
//                    }
//                }else{
//                    pickedName=""
//                }
//            }
//            .buttonStyle(.borderedProminent)
//            .font(.title2)
//
//        }
//
//    }
//
//
//#Preview {
//    ContentView()
//
//}
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var items = ["Item 1", "Item 2", "Item 3", "Item 4"]

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup TableView
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }

    // MARK: - UITableViewDelegate

    // Enable swipe-to-delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Delete action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            // Remove item from data source
            self?.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }

        deleteAction.backgroundColor = .red

        // Add other actions if needed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true // Optional: Full swipe to delete
        return configuration
    }
}
