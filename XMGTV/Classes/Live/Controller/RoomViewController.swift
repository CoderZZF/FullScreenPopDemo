//
//  LiveViewController.swift
//  XMGTV
//
//  Created by apple on 16/11/9.
//  Copyright © 2016年 coderwhy. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController {
    
    // MARK: 控件属性
    @IBOutlet weak var bgImageView: UIImageView!
    
    // MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}


// MARK:- 设置UI界面内容
extension RoomViewController {
    fileprivate func setupUI() {
        setupBlurView()
    }
    
    fileprivate func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.frame = bgImageView.bounds
        bgImageView.addSubview(blurView)
    }
}


// MARK:- 事件监听
extension RoomViewController {
    @IBAction func exitBtnClick() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bottomMenuClick(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            print("点击了聊天")
        case 1:
            print("点击了分享")
        case 2:
            print("点击了礼物")
        case 3:
            print("点击了更多")
        case 4:
            performParticleAnim()
        default:
            fatalError("未处理按钮")
        }
    }
    
    private func performParticleAnim() {
        // 1.创建发射器
        let emitter = CAEmitterLayer()
        
        // 2.设置粒子发射的位置
        emitter.emitterPosition = CGPoint(x: 100, y: 100)
        
        // 3.开启三维效果
        emitter.preservesDepth = true
        
        // 4.创建粒子
        var cells = [CAEmitterCell]()
        for i in 0..<10 {
            // 4.1.创建粒子
            let cell = CAEmitterCell()
            
            // 4.2.设置每秒发出粒子的个数
            cell.birthRate = 1

            // 4.3.设置粒子的存活时间
            cell.lifetime = Float(arc4random_uniform(4) + 1)
            cell.lifetimeRange = 1.5
            
            // 4.4.设置粒子图片
            cell.contents = UIImage(named: "good\(i)_30x30")?.cgImage
            
            // 4.5.设置粒子的速度
            cell.velocity = CGFloat(arc4random_uniform(100) + 100)
            cell.velocityRange = 80
            
            // 4.6.设置粒子的方向
            cell.emissionLongitude = CGFloat(M_PI_2)
            cell.emissionRange = CGFloat(M_PI_2 / 6)
            
            // 4.7.设置粒子的存储
            cell.scale = 0.7
            cell.scaleRange = 0.3
            
            // 4.8.将粒子添加到发射器中
            cells.append(cell)
        }
        
        // 5.设置粒子
        emitter.emitterCells = cells
        
        // 6.开始发射粒子
        view.layer.addSublayer(emitter)
    }
}
