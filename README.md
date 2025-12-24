## robosys2025
このリポジトリは2025年度ロボットシステム学にて作成したものです。  
[![test](https://github.com/yagikai2112/robosys2025/actions/workflows/test.yml/badge.svg)](https://actions/yagikai2112/robosys2025/.github/workflows/test.yml)

## ヴィジュネル暗号
アルファベットの表と「鍵」を使った暗号。平文の1文字ごとに異なるシーザー暗号>を適用するような効果を生み出す。

## テスト環境  
- Ubuntu-24.04
    - Python version: 3.7~3.12

## 使用方法
以下のコマンドを実行し、robosys2025をダウンロードしてください。  
その後ディレクトリに移動してください。  
```
$ git clone https://github.com/yagikai2112/robosys2025.git
$ cd robosys2025
```

## vigenereコマンド使い方
vigenereコマンドは1.暗号化、2.復元の2つのモードがあります。    
使い方がモードによって少し異なるため分けて説明します。   
また、それぞれ指定している入力とは異なるものが入力されると強制的に終了します。   
モード選択は半角のアラビア数字1か2、「鍵」は半角のアラビア数字0～9、暗号化と復号は大文字小文字の半角アルファベットと半角スペースが入力可能です。  
文頭や文末のスペースは自動的に省略します。   
- 1.暗号化  
標準入力を用いてモードを選択するための数字と暗号化したい英文を読み込み、「鍵」と暗号文を出力します。2つの入力の区切り目には[\n]を忘れずに入れてください。  
下記の例では「Hello It is nice weather」を暗号化しています。  
```
$ printf "1\nHello It is nice weather" | ./vigenere
6
Tydtq Un aa puww egmnzmt
```  
- ２.復号  
標準入力を用いてモードを選択するための数字と「鍵」、復号したい英文を読み込み、原文を出力します。3つの入力の区切り目には[\n]を忘れずに入れてください。  
下記の例では「Tydtq Un aa puww egmnzmt」を｛2｝の「鍵」を使って復号しています。  
```
$ printf "2\n6\nTydtq Un aa puww egmnzmt" | ./vigenere
Hello It is nice weather
```

## 著作権、ライセンス
- このソフトウェアパッケージは，3条項BSDライセンスの下，再頒布および使用が許可されます．
- © 2025 Kaito Yagiuchi
