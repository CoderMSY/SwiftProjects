//
//  StopwatchViewController.swift
//  SwiftProjects
//
//  Created by Simon Miao on 2021/12/29.
//

import UIKit
import SnapKit

class StopwatchViewController: MSYBaseViewController {
    fileprivate let btnWidth: CGFloat = 60.0
    fileprivate let cellId = "lapCell"
    private var isPlay: Bool = false
    private let mainStopwatch: Stopwatch = Stopwatch()
    private let lapStopwatch: Stopwatch = Stopwatch()
    fileprivate var laps: [String] = []
    
    private lazy var timerBgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        return bgView
    }()
    private lazy var lapTimerLabel: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 17)
        lab.textColor = UIColor.gray
        lab.text = "00:00:00"
        return lab
    }()
    private lazy var timerLabel: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 40)
        lab.text = "00:00:00"
        return lab
    }()
    private lazy var lapRestButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Lap", for: .normal)
        btn.setTitleColor(UIColor.green, for: .normal)
        btn.layer.cornerRadius = btnWidth / 2
        btn.layer.masksToBounds = true
        btn.backgroundColor = UIColor.white
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(lapRestButtonClicked(button:)), for: .touchUpInside)
        return btn
    }()
    private lazy var playPauseButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Start", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.layer.cornerRadius = btnWidth / 2
//        btn.layer.masksToBounds = true
        btn.backgroundColor = UIColor.white
        btn.addTarget(self, action: #selector(playPauseButtonClicked(button:)), for: .touchUpInside)
        return btn
    }()
    private lazy var lapsTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView.init()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "StopWatch"
        
        view.backgroundColor = UIColor.lightGray
        view.addSubview(timerBgView)
        timerBgView.addSubview(lapTimerLabel)
        timerBgView.addSubview(timerLabel)
        view.addSubview(lapRestButton)
        view.addSubview(playPauseButton)
        view.addSubview(lapsTableView)
        
        initConstraints()
    }


}

extension StopwatchViewController {
    private func initConstraints() {
        timerBgView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(view)
            make.height.equalTo(150)
        }
        lapTimerLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(timerLabel.snp.top)
            make.trailing.equalTo(timerLabel)
        }
        timerLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(timerBgView).offset(60)
            make.centerX.equalTo(timerBgView)
            make.centerY.equalTo(timerBgView).offset(20)
            make.leading.greaterThanOrEqualTo(timerBgView).offset(10)
            make.trailing.lessThanOrEqualToSuperview().offset(-10)
        }
        
        let margin = (UIScreen.main.bounds.size.width - btnWidth * 2) / 3
        lapRestButton.snp.makeConstraints { (make) in
            make.top.equalTo(timerBgView.snp.bottom).offset(30)
            make.leading.equalTo(view).offset(margin)
            make.size.equalTo(btnWidth)
        }
        playPauseButton.snp.makeConstraints { (make) in
            make.top.size.equalTo(lapRestButton)
            make.leading.equalTo(lapRestButton.snp.trailing).offset(margin)
        }
        lapsTableView.snp.makeConstraints { (make) in
            make.top.equalTo(playPauseButton.snp.bottom).offset(30)
            make.leading.bottom.trailing.equalTo(view)
        }
    }
    
    @objc private func lapRestButtonClicked(button: UIButton) {
        if isPlay {
            if let timerLabelText = timerLabel.text {
                laps.append(timerLabelText)
            }
//            lapsTableView.reloadData()
            let indexPath = IndexPath(row: laps.count - 1, section: 0)
            lapsTableView.insertRows(at: [indexPath], with: .fade)
            resetLapTimer()
            unowned let weakSelf = self
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: #selector(updateLapTimer), userInfo: nil, repeats: true)
            RunLoop.current.add(lapStopwatch.timer, forMode: .common)
        } else {
            resetMainTimer()
            resetLapTimer()
            changeButton(lapRestButton, title: "Lap", titleColor: UIColor.lightGray)
            lapRestButton.isEnabled = false
        }
    }
    
    private func resetMainTimer() {
        resetTimer(mainStopwatch, label: timerLabel)
        laps.removeAll()
        lapsTableView.reloadData()
    }
    
    private func resetLapTimer() {
        resetTimer(lapStopwatch, label: lapTimerLabel)
    }
    
    private func resetTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.timer.invalidate()
        stopwatch.counter = 0.0
        label.text = "00:00:00"
    }
    
    @objc private func playPauseButtonClicked(button: UIButton) {
        lapRestButton.isEnabled = true
        
        changeButton(lapRestButton, title: "Lap", titleColor: UIColor.black)
        
        if isPlay {
            mainStopwatch.timer.invalidate()
            lapStopwatch.timer.invalidate()
            isPlay = false
            changeButton(lapRestButton, title: "Reset", titleColor: .black)
            changeButton(playPauseButton, title: "Start", titleColor: .green)
        } else {
            //开始定时器
            unowned let weakSelf = self
            mainStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: #selector(updateMainTimer), userInfo: nil, repeats: true)
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: #selector(updateLapTimer), userInfo: nil, repeats: true)
            RunLoop.current.add(mainStopwatch.timer, forMode: .common)
            RunLoop.current.add(lapStopwatch.timer, forMode: .common)
            
            isPlay = true
            changeButton(playPauseButton, title: "Stop", titleColor: .red)
        }
        
    }
    
    private func changeButton(_ button: UIButton, title: String, titleColor: UIColor) {
        button.setTitle(title, for: UIControl.State())
        button.setTitleColor(titleColor, for: UIControl.State())
    }
    
    @objc func updateMainTimer() {
        updateTimer(mainStopwatch, label: timerLabel)
    }
    
    @objc func updateLapTimer() {
        updateTimer(lapStopwatch, label: lapTimerLabel)
    }
    
    private func updateTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.counter = stopwatch.counter + 0.035
        
        var minutes: String = "\((Int)(stopwatch.counter / 60))"
        if (stopwatch.counter / 60) < 10 {
            minutes = "0\((Int)(stopwatch.counter / 60))"
        }
        
        var seconds: String = String(format: "%.2f", (stopwatch.counter.truncatingRemainder(dividingBy: 60)))
        
        if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
          seconds = "0" + seconds
        }
        
        label.text = minutes + ":" + seconds
        
    }
}

extension StopwatchViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = laps[indexPath.row]
        
        return cell!
    }
    
    
}

