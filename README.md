# CodeView

[![CI Status](https://img.shields.io/travis/gztzxzp@163.com/Sam_CodeView.svg?style=flat)](https://travis-ci.org/gztzxzp@163.com/Sam_CodeView)
[![Version](https://img.shields.io/cocoapods/v/Sam_CodeView.svg?style=flat)](https://cocoapods.org/pods/Sam_CodeView)
[![License](https://img.shields.io/cocoapods/l/Sam_CodeView.svg?style=flat)](https://cocoapods.org/pods/Sam_CodeView)
[![Platform](https://img.shields.io/cocoapods/p/Sam_CodeView.svg?style=flat)](https://cocoapods.org/pods/Sam_CodeView)

## 预览图

![border.png](https://upload-images.jianshu.io/upload_images/1320114-9cb3ab1476e983d1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![line.png](https://upload-images.jianshu.io/upload_images/1320114-b12bc134966bac71.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Sam_CodeView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```swift
source 'https://github.com/SamXZP/Sam_CodeViewSpec.git'  //在podfile 里面加上私有库源
pod 'Sam_CodeView', '1.0.1'   
```
###介绍
**CodeView** 是一个可以高度自定义手机验证码输入的控件。

下面介绍下`CodeView`**swift版本**的原理和用法
###  原理 基于UITextField，使用UILabel来代替验证码的显示，使用CAShapeLayer代替光标的显示，使用CALayer绘制底部线条。根据UITextField的文字变化的监听，去改变光标的显示位置和验证码的下划线或边框的风格。

### 使用方法

**import Sam_CodeView**

```swift

let view = CodeView.init(frame: CGRect.init(x: 50, y: 160, width: SCREEN_WIDTH-100, height: 50),codeNumber: 4,style: .CodeStyle_line)

view.codeBlock = { [weak self] code in

    print("\n\n=======>您输入的验证码是：\(code)")

}

self.view.addSubview(view)

```

自定义属性介绍：

`codeNumber`  验证码的长度，一般是4/6位 默认6位

`margin` CodeView 两个验证码之间的间距，可以自定义，默认12

`style`  验证码输入的风格，可根据自己的需求选择

`labelFont`  验证码字体大小

`labelTextColor`  验证码字体颜色

`mainColor`  光标颜色和输入验证码的边框、线条 主颜色

`normalColor`  光标颜色和输入验证码的边框、线条 普通颜色

### 主要代码

**根据UITextField的text改变，移动光标**

```swift

@objc func textChage(_ textField: UITextField) {

    var verStr:String = textField.text ?? ""

    if verStr.count > codeNumber {

        let substring = textField.text?.prefix(codeNumber)

        textField.text = String(substring ?? "")

        verStr = textField.text ?? ""

    }

    if  verStr.count >= codeNumber {

        if (self.codeBlock != nil) {

            self.codeBlock?(textField.text ?? "")

        }

    }



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

```
## Author

gztzxzp@163.com, gztzxzp@gmail.com

## License

Sam_CodeView is available under the MIT license. See the LICENSE file for more info.


