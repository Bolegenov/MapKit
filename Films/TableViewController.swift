//
//  TableViewController.swift
//  Films
//
//  Created by Азамат Булегенов on 08.08.2023.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet weak var imageview: UIImageView!
    
    @IBAction func addFilm(_ sender: Any) {
        
       arrayFilms.append(Films(name: "new name", year: "new year", imagename: "avatar", genre: "new genre", budget: "new budget", description: "new text"))
                          
        tableView.reloadData()
    }
    
    
    var arrayFilms = [Films (name: "Avatar", year: "Год производства:  2009", imagename: "image", genre: "Жанр:  Драмы, Боевики, Приключения, Фантастика, Фильмы про НЛО", budget: "Бюджет:  237 миллионов USD", description: "О фильме \n Бывший морпех Джейк Салли прикован к инвалидному креслу. Несмотря на немощное тело, Джейк в душе по-прежнему остается воином. Он получает задание совершить путешествие в несколько световых лет к базе землян на планете Пандора, где корпорации добывают редкий минерал, имеющий огромное значение для выхода Земли из энергетического кризиса."), Films(name: "Переводчик", year: "Год производства:  2022", imagename: "Perevod", genre: "Жанр:  боевик, триллер, военный, история, драма", budget: "Бюджет:  $55 000 000", description: "О фильме \n Афганистан, март 2018 года. Во время спецоперации по поиску оружия талибов отряд сержанта армии США Джона Кинли попадает в засаду. В живых остаются только сам Джон, получивший ранение, и местный переводчик Ахмед, который сотрудничает с американцами. Очнувшись на родине, Кинли не помнит, как ему удалось выжить, но понимает, что именно Ахмед спас ему жизнь, протащив на себе через опасную территорию. Теперь чувство вины не даёт Джону покоя, и он решает вернуться за Ахмедом и его семьёй, которых в Афганистане усиленно ищут талибы."), Films(name: "Веном", year: "Год производства:  2018", imagename: "venom", genre: " Жанр:  фантастика, боевик, триллер, ужасы", budget: "Бюджет:   100000000 $", description: "О фильме \n Что, если в один прекрасный день в тебя вселится симбиот, который наделит тебя сверхчеловеческими способностями? Вот только Веном — симбиот совсем недобрый, и договориться с ним невозможно. А нужно ли договариваться? Ведь в какой-то момент ты понимаешь, что быть плохим вовсе не так уж и плохо, так даже веселее. А в мире и так слишком много супергероев.") ]
    
        override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayFilms.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 146
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVc = storyboard?.instantiateViewController(withIdentifier: "detailViewContreller") as! ViewController
        
       
        detailVc.film = arrayFilms[indexPath.row]
        
        navigationController?.show(detailVc, sender: self)
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let label = cell.viewWithTag(1000) as! UILabel
        label.text = arrayFilms[indexPath.row].name
        
        let labelyear = cell.viewWithTag(1001) as! UILabel
        labelyear.text = arrayFilms[indexPath.row].year
        
        let labelgenre = cell.viewWithTag(1002) as! UILabel
        labelgenre.text = arrayFilms[indexPath.row].genre
        
        let labelbudget = cell.viewWithTag(1003) as! UILabel
        labelbudget.text = arrayFilms[indexPath.row].budget
        
        
        let imageView = cell.viewWithTag(1005) as! UIImageView
        imageView.image = UIImage(named: arrayFilms[indexPath.row].imagename)
        
        // Configure the cell...

        return cell
    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            arrayFilms.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
   

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
