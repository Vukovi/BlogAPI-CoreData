//
//  BlogTabela.swift
//  Blog
//
//  Created by Vuk on 7/13/16.
//  Copyright © 2016 User. All rights reserved.///
//

import UIKit
import CoreData

var recnik1: [String : AnyObject] = [String:AnyObject]()
var niz1: [AnyObject] = [AnyObject]()

var niz: [NSDictionary] = [NSDictionary]()

var izabraniRed: Int?

var punjenjeBaze: BlogBaza?
var nizBaze = [BlogBaza]()

class BlogTabela: UITableViewController {
    
 
    
    let mojContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    

    func unosUBazu() {
        
        
        let internetAdresa = "https://www.googleapis.com/blogger/v3/blogs/30740798/posts?key=AIzaSyACYll4qVayWap4Vm8F_hHWwjH1KubKU3Q"
        if let mojUrl = URL(string: internetAdresa){
            if let podatak = try? Data(contentsOf: mojUrl){
                do{
                    let rezultatJSON = try JSONSerialization.jsonObject(with: podatak, options: JSONSerialization.ReadingOptions.mutableContainers)
                    
                    recnik1 = rezultatJSON as! [String : AnyObject]
                    niz1 = recnik1["items"] as! [AnyObject]
                    for i in 0...niz1.count - 1 {
                        niz.append(niz1[i] as! NSDictionary)
                    }
                }catch{}
            }
            
        }
        
        
        for i in 0...niz.count - 1{
            
            let unosPodatakaUBazu = NSEntityDescription.entity(forEntityName: "BlogBaza", in: mojContext)
            punjenjeBaze = BlogBaza(entity: unosPodatakaUBazu!, insertInto: mojContext)
        
        
            punjenjeBaze?.naslov = String(describing: niz[i]["title"]!)
            punjenjeBaze?.objava = String(describing: niz[i]["published"]!)
            punjenjeBaze?.autor = String(describing: (niz[i]["author"]! as! NSDictionary)["displayName"]!)
            punjenjeBaze?.sadrzaj = String(describing: niz[i]["content"]!)
            print(punjenjeBaze?.naslov)
            
            do{
                try mojContext.save()
            }catch{}
        
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       //hoću da proverim da li u bazi ima nešto i ako ima da to onda ispraznim da mi ne bi baza narasala sa svakim novim učitavanjem aplikacije, i to sa istim podacima, ovako ću je pri svakom učitavanju prazniti, to može da se namesti npr da se prazne blogi pre nekog datuma ili da se u bazi sadrzi npr 100 blogova i onda da se prazni, sledećih par redova o tome govori
        let upit = NSFetchRequest<NSFetchRequestResult>(entityName: "BlogBaza")
        upit.returnsObjectsAsFaults = false
        do{
            let rezultat = try mojContext.fetch(upit)
            if rezultat.count > 0{//dakle ovde pitam - ima li nešto u bazi
                for i in rezultat as! [NSManagedObject]{
                    mojContext.delete(i)
                    do{
                        try mojContext.save()
                    }catch{}
                }
            }
        }catch{} //ovde sam zavrsio sa pražnjenjem baze
 
        
        unosUBazu()
        
        
        let upit2 = NSFetchRequest<NSFetchRequestResult>(entityName: "BlogBaza")
        nizBaze = (try! mojContext.fetch(upit2)) as! [BlogBaza]
        self.tableView.reloadData()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if nizBaze.count == 0{
            return 0
        }
        else{
            return nizBaze.count
        }

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celija", for: indexPath)
        
        cell.textLabel?.text = nizBaze[indexPath.row].naslov
        cell.detailTextLabel?.text = nizBaze[indexPath.row].objava! + "   " + nizBaze[indexPath.row].autor!
       
        return cell
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let prelazak = segue.destination as! ViewController
        let indeksĆelije = tableView.indexPathForSelectedRow
        let red = indeksĆelije?.row
        prelazak.preuzmi = nizBaze[red!].sadrzaj // preuzmi mi se nalazi na drugom fajlu ViewController
    }
    

}
