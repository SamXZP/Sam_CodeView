//
//  CodeView.swift
//  Sam_CodeView
//
//  Created by Sam on 2020/5/27.
//

import UIKit
import Foundation

public enum  CodeStyle {
    case CodeStyle_line      //下划线格式
    case CodeStyle_border    //带边框格式
}

public class CodeView: UIView {
    
    fileprivate var shapeArray:[CAShapeLayer] = Array()  //自定义底部线条、边框存放的数组
    fileprivate var labelArray:[UILabel] = Array()       //文字存放的数组
    fileprivate var layerArray:[CALayer] = Array()       //文字存放的数组
    public var codeNumber:Int = 0                        //验证码位数
    public var mainColor:UIColor?                        //光标颜色和输入验证码的边框、线条颜色
    public var normalColor:UIColor?                      //未选中的颜色
    public var labelTextColor:UIColor?                   //验证码文字的颜色
    public var style:CodeStyle?                          //输入框的风格
    public var margin:CGFloat = 12                       //两个验证码之间的间距
    public var codeBlock: ((String) -> Void)?            //验证码回调
    fileprivate lazy var textField: UITextField = {
            let view = UITextField.init()
            view.tintColor = UIColor.clear
            view.backgroundColor = UIColor.clear
            view.textColor = UIColor.clear
            view.keyboardType = .numberPad
            if #available(iOS 12.0, *) {
                view.textContentType =  .oneTimeCode  //验证码自动填充
            }
            view.addTarget(self, action: #selector(textChage( _:)), for: .editingChanged)
            return view
    }()
    
    /// 重新UIView 的init方法
    /// - Parameters:
    ///   - frame: view 的frame
    ///   - codeNumber: 验证码位数 默认6位
    ///   - style: 输入框的风格 默认线条样式
    ///   - labelTextColor: 验证码输入文字的颜色
    ///   - mainColor: 光标颜色和输入验证码的边框、线条颜色
    ///   - normalColor: 未选中的颜色
    ///   - margin: 两个验证码之间的间距，随需求更改
    public init(frame:CGRect,codeNumber:Int = 6,style:CodeStyle = .CodeStyle_line,labelTextColor:UIColor = UIColor.black, mainColor:UIColor = UIColor.orange,normalColor:UIColor = UIColor.gray,margin:CGFloat = 12.0) {
        super.init(frame: frame)
        self.codeNumber = codeNumber
        self.labelTextColor = labelTextColor
        self.mainColor = mainColor
        self.normalColor = normalColor
        self.style = style
        self.margin = margin
        setUpSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUpSubview() {
        //每一个验证码的宽度
        let width = (self.bounds.width - CGFloat(codeNumber-1)*margin)/CGFloat(codeNumber)
        self.addSubview(textField)
        textField.frame = self.bounds
        for index in 0..<codeNumber  {
            let subView = UIView.init()
            subView.frame = CGRect.init(x: (width+margin)*CGFloat(index), y: 0, width: width, height: width)
            subView.isUserInteractionEnabled = false
            self.addSubview(subView)
            
            //底部线条、边框的格式
            let layer = CALayer.init()
            
            if style == .CodeStyle_line {
                layer.frame = CGRect.init(x: 0, y: width-1, width: width, height: 1)
                if index == 0 {
                    layer.backgroundColor = mainColor?.cgColor
                }else{
                    layer.backgroundColor = normalColor?.cgColor
                }
            }else{
                layer.frame = CGRect.init(x: 0, y: 0, width: width, height: width)
                layer.borderWidth = 0.5
                layer.cornerRadius = 5
                layer.backgroundColor = UIColor.white.cgColor
                if index == 0 {
                    layer.borderColor = mainColor?.cgColor
                }else{
                    layer.borderColor = normalColor?.cgColor
                }
            }
            subView.layer.addSublayer(layer)
            
            //验证码文字设置
            let label = UILabel.init()
            label.frame = CGRect.init(x: 0, y: 0, width: width, height: width)
            label.textAlignment = .center
            label.textColor = labelTextColor
            label.backgroundColor = UIColor.clear
            label.font = UIFont.systemFont(ofSize: 20)
            subView.addSubview(label)
            
            //光标
            let path  = UIBezierPath.init(rect: CGRect.init(x: width/2, y: (width/2)-8, width: 2, height:16))
            let line = CAShapeLayer.init()
            line.path = path.cgPath
            line.fillColor = mainColor?.cgColor
            subView.layer.addSublayer(line)
            if index == 0 {
                line.add(opacityAnimation(), forKey: "kOpacityAnimation")
                line.isHidden = false
            }
            else{
                line.isHidden = true
            }
            shapeArray.append(line)
            labelArray.append(label)
            layerArray.append(layer)
        }
        startEdit()
    }
}

extension CodeView{
    //当输入内容等于验证码的长度时候，把输入的验证码回调
    @objc func textChage(_ textField: UITextField) {
        var verStr:String = textField.text ?? ""
        if verStr.count > codeNumber {
            let substring = textField.text?.prefix(codeNumber)   //控制输入文字的长度
            textField.text = String(substring ?? "")
            verStr = textField.text ?? ""
        }
        if  verStr.count >= codeNumber {
            if (self.codeBlock != nil) {
                self.codeBlock?(textField.text ?? "")
            }
        }
        //设置文字的显示和光标的移动
        for index in 0..<codeNumber {
            let label:UILabel = labelArray[index]
            if (index < verStr.count){
                let str : NSString = verStr as NSString
                label.text = str.substring(with: NSMakeRange(index, 1))
            }
            else{
                label.text = ""
            }
            changeOpacityAnimalForShapeLayerWithIndex(index: index, hidden: index == verStr.count ? false : true)
            changeColorForLayerWithIndex(index: index, hidden: index > verStr.count ? false : true)
        }
    }
    //根据文字所在的位置设置底部layer的颜色
    fileprivate func changeColorForLayerWithIndex(index:NSInteger, hidden:Bool) {
        let layer = layerArray[index];
        if (hidden) {
            if style == .CodeStyle_line {
                layer.backgroundColor = mainColor?.cgColor;
            }else{
                layer.borderColor = mainColor?.cgColor;
            }
        }else{
            if style == .CodeStyle_line {
                layer.backgroundColor = normalColor?.cgColor;
            }else{
                layer.borderColor = normalColor?.cgColor;
            }
        }
    }
    //根据文字所在的位置改变光标的位置
    fileprivate func changeOpacityAnimalForShapeLayerWithIndex(index:Int, hidden:Bool) {
        let line = shapeArray[index]
        if hidden {
            line.removeAnimation(forKey: "kOpacityAnimation")
        }
        else{
            line.add(opacityAnimation(), forKey: "kOpacityAnimation")
        }
        UIView.animate(withDuration: 0.25) {
            line.isHidden = hidden
        }
    }
    //开启键盘
    public func startEdit() {
        textField.becomeFirstResponder()
    }
    //关闭键盘
    public func stopEdit() {
        textField.resignFirstResponder()
    }
    //模仿光标 闪动效果
    fileprivate func opacityAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation.init(keyPath: "opacity")
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.duration = 0.9
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = true
        animation.fillMode = CAMediaTimingFillMode.init(string: "forwards") as String
        animation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.init(string: "easeIn") as String)
        return animation
    }
}

