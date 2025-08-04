# team11

## TitleScreen.pde
### 属性（変数）一覧
* boolean showRules: ルール画面表示中フラグ

### メソッド一覧
* void drawTitleScreen(): タイトル画面を描画
* void drawRulesScreen(): ルール説明画面を描画
* void drawTitleScreenWrapper(): タイトル／ルール画面を切り替えて描画
* boolean overStartButton(float mx, float my): 「ゲーム開始」ボタン上か判定
* boolean overRulesButton(float mx, float my): 「ルール説明」ボタン上か判定
* boolean overBackButton(float mx, float my): 「戻る」ボタン上か判定
* void titleMousePressed(): タイトル／ルール画面のクリック処理

## app.pde
### 属性（変数）一覧
* PFont jpFont: 日本語フォント
* GameManager game: ゲーム管理オブジェクト
* boolean started: タイトル画面かゲーム画面かのフラグ
* PImage komaImage: 王以外駒用画像
* PImage ouImage: 王駒用画像

### メソッド一覧
* void settings(): ウィンドウサイズ設定
* void setup(): フォント・画像読み込みと GameManager 初期化
* void draw(): started フラグでタイトル or ゲーム画面を切り替え描画
* void mousePressed(): started フラグでクリック処理をタイトル or GameManager に委譲

## Piece.pde
### 属性（変数）一覧
* String name: コマの種類コード（例 "FU","OU"）
* boolean isPromoted: 成り状態かの判定
* boolean isMine: 自分のコマかどうかの判定
* int x, y: 盤上の座標

### メソッド一覧
* void move(int x, int y): 座標を更新し駒を移動
* List<PVector> getMoveablePoints(Board board): 移動可能マスを取得
* boolean tryPromote(): 自動成り判定と成駒化
* String promoteType(String t): 成駒コードを返す
* String demoteType(String t): 成駒を素駒に戻す
* void drawAt(float px, float py, float dia): 画像で駒を描画

## Board.pde
### 属性（変数）一覧
* int N: 盤のマス数（9）
* float x0, y0, cell: 描画用原点・セルサイズ
* Piece[][] grid: 9×9 の駒配置配列

### メソッド一覧
* void draw(): 盤線と駒を描画
* void showMoves(Piece p): 移動／捕獲可能マスを緑ハイライト＋敵駒再描画
* void highlightCell(int row, int col): 選択セルをオレンジ枠で強調
* boolean inBoard(float mx, float my): マウス座標が盤内か判定
* PVector cellFromMouse(float mx, float my): マウス座標→盤上インデックス変換
* Piece getPiece(int row, int col): 指定座標の駒を返す

## Player.pde
### 属性（変数）一覧
* int id: 0=先手 (S), 1=後手 (G)
* List<Piece> hand: 持ち駒リスト

### メソッド一覧
* Player(int id): id と空の hand を初期化
* void drawHand(float x, float y, float size): 持ち駒を画面外に描画

## GameManager.pde
### 属性（変数）一覧
* Board board: 盤面インスタンス
* Player S, G, current: 先手／後手／現在プレイヤー
* String state: ゲーム状態（"start","select","gameover"）
* Piece selectedPiece: 選択中の駒
* boolean fromHand: 手駒選択中フラグ
* int handIdx: 選択中の手駒インデックス
* List<PVector> possible: 移動／打ち可能マス一覧
* boolean gameOver: ゲーム終了フラグ

### メソッド一覧
* GameManager(): フィールドを初期化
* void setup(): 盤面初期化（initBoard呼び出し）＋状態を"select"に
* void initBoard(): 王固定、他駒を「元のマス」内でシャッフル配置
* void draw(): 盤面描画＋ハイライト＋手駒＋ターン表示＋勝利オーバーレイ
* void playTurn(): ターン中のクリック処理を mousePressedSelect に委譲
* void mousePressedSelect(): 盤／持ち駒の選択・移動・打ち込み処理
* void endTurn(): 王チェック→gameOver設定 or ターン切替
* void clearSelection(): 選択状態と possible リストをクリア
* List<PVector> getDrops(Player pl): 手駒打ち可能マス一覧
* void checkKingCapture(): 王の有無チェック（ゲーム終了判定）
* void nextTurn(): current 切替＋選択クリア；state="select"