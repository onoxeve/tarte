//
//  ViewController.swift
//  tarte
//
//  Created by onox on 2018/12/12.
//  Copyright © 2018 onox. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var elapsedTimeLabel: UILabel!
    @IBOutlet var startStopButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var timerTable: UITableView!
    
    var displayTimers = [[String]]()
    var timer = Timer()
    var elapsedSec = 0
    var startStopState = "stop"
    let timerKey = "timer"
    let nowDate = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayDate()
        timerTable.delegate = self
        timerTable.dataSource = self
        doneButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if UserDefaults.standard.object(forKey: timerKey) != nil {
            displayTimers = UserDefaults.standard.object(forKey: timerKey) as! [[String]]
        }
        
        timerTable.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayTimers.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let date = displayTimers[indexPath.row][0]
        let sec = displayTimers[indexPath.row][1]
        let (h,m,s) = self.secondsToHoursMinutesSeconds(seconds: Int(sec)!)
        let timeStr = NSString(format: "%02d:%02d:%02d", h, m, s) as String

        cell.textLabel?.text = date
        cell.detailTextLabel?.text = timeStr

        cell.textLabel?.textColor = UIColor.white;
        cell.textLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: 17, weight: UIFont.Weight.regular)
        
        cell.detailTextLabel?.textColor = UIColor.white;
        cell.detailTextLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: 17, weight: UIFont.Weight.regular)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func displayDate() {
        nowDate.dateFormat = DateFormatter.dateFormat(fromTemplate: "E ydMMM", options: 0, locale: Locale(identifier: "en_US"))
        dateLabel.text = nowDate.string(from: Date())
    }

    @IBAction func tapStartButton(_ sender: Any) {
        switch startStopState {
        case "stop":
            startStopButton.setImage(UIImage(named: "stop-48"), for: .normal)
            startStopState = "start"
            doneButton.isEnabled = true

            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
                self.timerUpdate()
            })
        case "start":
            startStopButton.setImage(UIImage(named: "start-48"), for: .normal)
            startStopState = "stop"
            doneButton.isEnabled = true

            timer.invalidate()
        default:
            break
        }
    }

    @IBAction func tapDone(_ sender: Any) {
        if UserDefaults.standard.object(forKey: timerKey) != nil {
            displayTimers = UserDefaults.standard.object(forKey: timerKey) as! [[String]]
        }
        
        displayTimers.insert([nowDate.string(from: Date()), String(elapsedSec)], at: 0)
        
        UserDefaults.standard.set(displayTimers, forKey: timerKey)
        resetTimer()
        timerTable.reloadData()
    }
    
    @IBAction func tapReset(_ sender: Any) {
        resetTimer()
    }
    
    func timerUpdate() {
        elapsedSec += 1
        let (h,m,s) = self.secondsToHoursMinutesSeconds(seconds: Int(elapsedSec))
        elapsedTimeLabel.text = NSString(format: "%02d:%02d:%02d", h, m, s) as String
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 60))
    }
    
    func resetTimer() {
        startStopButton.setImage(UIImage(named: "start-48"), for: .normal)
        elapsedSec = 0
        elapsedTimeLabel.text = "00:00:00"
        timer.invalidate()
        startStopState = "stop"
        doneButton.isEnabled = false
    }
}

