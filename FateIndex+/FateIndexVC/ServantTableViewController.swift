//
//  ServantTableViewController.swift
//  FateIndex+
//
//  Created by 管君 on 9/26/18.
//  Copyright © 2018 管君. All rights reserved.
//

import UIKit

class ServantTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(closeBtnClick))
        
        tableView.register(UINib(nibName: "ServantTableViewCell", bundle: nil), forCellReuseIdentifier: "ServantTableViewCell")
        
        tableView.register(UINib(nibName: "NoblePhantasmNameTableViewCell", bundle: nil), forCellReuseIdentifier: "NoblePhantasmNameTableViewCell")
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    let name1 = ["玛修・基列莱特", "阿尔托莉雅・潘德拉贡", "阿尔托莉雅・潘德拉贡(Alter)", "阿尔托莉雅・潘德拉贡(Lily)", "尼禄・克劳狄乌斯"]
    let name2 = ["マシュ・キリエライト", "アルトリア・ペンドラゴン", "アルトリア・ペンドラゴン〔オルタ〕", "アルトリア・ペンドラゴン〔リリィ〕", "ネロ・クラウディウス"]
    let name3 = ["Mash Kyrielight", "Altria Pendragon", "Altria Pendragon (Alter)", "Altria Pendragon (Lily)", "Nero Claudius"]
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ServantTableViewCell", for: indexPath) as! ServantTableViewCell
//        let img = "Servant00" + String(indexPath.row + 1)
//        cell.servantIcon.image = UIImage(imageLiteralResourceName: img)
//        cell.servantNumberLabel.text = "00" + String(indexPath.row + 1)
//        cell.servantTopNameLabel.text = name1[indexPath.row]
//        cell.servantMidNameLabel.text = name2[indexPath.row]
//        cell.servantBotNameLabel.text = name3[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoblePhantasmNameTableViewCell", for: indexPath) as! NoblePhantasmNameTableViewCell
        
        cell.noblePhantasmIcon.image = UIImage(imageLiteralResourceName: "Arts")
        cell.phantasmTopLabel.text = "穢れを漱げ、青く美しきナイル"
        cell.phantasmMidLabel.text = "Sneferu Iteru Nile"
        cell.phantasmBotLabel.text = "洗刷污秽吧，青色美丽的尼罗河"
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
 
    @objc func closeBtnClick(sender: UIBarButtonItem) {
        dismiss(animated: false, completion: nil)
    }
    
}
