//
//  ChooseSexViewController.swift
//  Sociaphobia 2
//
//  Created by Evgeniy Uskov on 30.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import UIKit
import AVFoundation

struct Group {
    var title: String
    var list: [String]
    
    init(title: String, list: [String]) {
        self.title = title
        self.list = list
    }
}

class ChooseSexViewController: UIViewController {

    var sex: String?
    
    lazy var generalSounds = [
        "whoIsLast",
        "me",
        "stopOnNextStation",
        "imSorry",
        "howMuch",
        "howMuchDoIOweYou",
        "beHealthy",
        "thanks",
        "youreWelcome",
        "notAtAll",
        "whatsTime",
        "gladToKnow",
        "myPleasure"
    ]
    lazy var heys = [
        "heyBoy",
        "heyGirl"
    ]
    lazy var startConversation = [
        "howYouDoing",
        "haveYouMetTed"
    ]
    lazy var corrections = [
        "ringing",
        "coffee",
        "birthday"
    ]
    
    
    lazy var groups: [Group] = [
        Group(title: "Общие фразы", list: generalSounds),
        Group(title: "Обращения", list: heys),
        Group(title: "Фразы чтобы  завязать разговор", list: startConversation),
        Group(title: "Исправления", list: corrections)
    ]
    
    var names: [String: String] = [
        "me": "Я!",
        "whoIsLast": "Кто последний?",
        "imSorry": "Извините за беспокойство!",
        "howMuch": "Сколько стоит?",
        "howMuchDoIOweYou": "Сколько с меня?",
        "stopOnNextStation": "Остановите на следующей!",
        "beHealthy": "Будьте здоровы!",
        "thanks": "Спасибо!",
        "youreWelcome": "Пожалуйста!",
        "notAtAll": "Не за что!",
        "whatsTime": "Который час?",
        "gladToKnow": "Приятно познакомиться!",
        "myPleasure": "Очень приятно!",
        
        "heyBoy": "Молодой человек!",
        "heyGirl": "Девушка!",
        
        "howYouDoing": "Хау ю дуин?",
        "haveYouMetTed": "Вы знакомы с Тедом?",
        
        "ringing": "ЗвонИт!",
        "coffee": "МОЙ кофе!",
        "birthday": "МОЙ день рождения!",
        
    ]
    
    var soundsInverted: [String: String]?
    
    @IBOutlet weak var soundsTableView: UITableView!
    
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIHelper.getViewBackgroundColor()
        soundsInverted = Dictionary(uniqueKeysWithValues: names.map({ ($1, $0) }))
        setupTableView()
        setupNavBar()
    }

    func setupTableView() {
        soundsTableView.delegate = self
        soundsTableView.dataSource = self
        soundsTableView.allowsMultipleSelection = true
        soundsTableView.rowHeight = 70
        soundsTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        let view = UIView()
        soundsTableView.backgroundView = view;
        soundsTableView.separatorStyle = .none
        view.backgroundColor = UIHelper.getViewBackgroundColor()
    }
    
    func setupNavBar() {
        navigationItem.title = "Фразы. " + sex! + " голос"
        guard let navBar = navigationController?.navigationBar else {return}
        navBar.tintColor = .black
        navBar.backItem?.title = "Голос"
    }
}

extension ChooseSexViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groups[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups[section].list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = soundsTableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! TableViewCell
        
        cell.delegate = self
        let soundName = groups[indexPath.section].list[indexPath.row]
        cell.setup(soundName: soundName, title: names[soundName]!, row: indexPath.row)
        
        return cell
    }
}

extension ChooseSexViewController: PlaySoundDelegate {
    func didPlayedSound(_ sender: UIButton) {
        DispatchQueue.global(qos: .userInteractive).async {
            self.playSound(soundName: self.soundsInverted![sender.currentTitle!]!)
        }
        
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1.0
        }
    }
    
    func playSound(soundName: String) {
        var url: URL?
        if sex == "Мужской" {
            url = Bundle.main.url(forResource: soundName + "_male", withExtension: "mp3")//"wav"
        }
        else {
            url = Bundle.main.url(forResource: soundName + "_female", withExtension: "mp3")//"wav"
        }
        guard url != nil else {
            print("Error no sound with name")
            return
        }
        player = try! AVAudioPlayer(contentsOf: url!)
        player.setVolume(1, fadeDuration: 0)
        player.play()
        
    }
}

extension ChooseSexViewController {
    func showAlert() {
        let alert = UIAlertController(title: "Громкость", message: "Установите максимальную громкость для того чтобы окружающие слышали звук.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Продолжить", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}
