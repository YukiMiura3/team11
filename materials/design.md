# team11

## クラス名
* ①Piece(駒クラス)
* ②Board(盤面クラス)
* ③Player(プレイヤークラス)
* ④GameManager(ゲーム全体管理クラス)

## 主担当者名

## 属性（変数）一覧

### Pieceクラスの属性
* String name:コマの種類
* boolean isPromoted:成り状態かの判定
* boolean isMine:自分のコマかどうかの判定
* int x,y:コマの座標

### Boardクラスの属性
* Piece[][]:盤面
* int width,height:盤面サイズ

### Playerクラスの属性
* List<Piece>pieces:手持ちの駒一覧
* boolean isMyTurn:ターンの管理

### GameManagerクラスの属性
* Board board:盤面インスタンス
* Player player1,player2;プレイヤー情報
* String state:ゲーム状態(かいし・選択中・終了など)

## メソッド一覧

### Pieceクラスのメソッド
* void move(int x,int y):コマを移動させるメソッド
* List<Point> getMoveablePoinsts(Board board):現在の盤面から移動可能なマス
* void promote():駒が成る
* void reveal():正体公開処理

### Boardクラスのメソッド
* void initialize():コマを裏向きにランダム配置
* Piece getPiece(int x,int y):座標から駒を取得
* void draw():盤面の描画
* boolean isInsideBoard(int x,int y):有効な座標か確認

### Playerクラスのメソッド
* void playTurn():ターン内の処理
* void selectPiece(Piece p):コマの選択
* void makeMove(Piece p, int x,int y):移動処理

### GameManagerクラスのメソッド
* void update():ゲームの状態更新処理
* void checkWin():勝利条件
* void nextTurn():ターンの切り替え処理


## 各属性、各メソッドに関するメモ




