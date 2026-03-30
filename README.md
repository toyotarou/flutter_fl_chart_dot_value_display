# flutter_fl_chart_dot_value_display

最終更新日：2025-02-12

## 概要

**`fl_chart` の折れ線グラフで、各データ点の値をドット上に表示・非表示できる Flutter サンプルアプリ**です。

カスタム `FlDotPainter`（`MyCustomDotPainter`）を実装し、ボタン操作で全ドットの Y 値ラベルを一括トグルする仕組みを提供します。

---

## 主な機能

- **折れ線グラフ表示**：`fl_chart` の `LineChart` を使い、6 点のデータをなめらかな曲線で描画
- **カスタムドットペインター**：`FlDotPainter` を継承した `MyCustomDotPainter` で、ドットの描画と Y 値ラベルの表示を Canvas に直接描画
- **値表示のトグル**：「値を表示」/「値を隠す」ボタンで全データ点の値ラベルを一括切り替え
- **アニメーション対応**：`lerp` メソッドを実装しており、表示切り替え時にアニメーションが適用される

---

## 画面構成

```
ChartPage（Scaffold）
├── AppBar（'LineChart with Value Toggle'）
└── Column
    ├── ElevatedButton（「値を表示」/「値を隠す」）
    └── Expanded
        └── LineChart
            └── LineChartBarData
                └── FlDotData → MyCustomDotPainter（ドット + 値ラベル）
```

---

## ファイル構成

```
lib/
└── main.dart    # エントリーポイント・全クラス定義
```

---

## 主要クラス

### `ChartPage` / `_ChartPageState`

メイン画面。`_showAllValues` フラグで値ラベルの表示状態を管理し、ボタン押下時に `setState` で切り替えます。

| フィールド         | 型             | 説明                          |
|------------------|---------------|------------------------------|
| `_showAllValues` | `bool`        | 値ラベルの表示・非表示フラグ    |
| `_spots`         | `List<FlSpot>`| グラフのデータ点（6 点）        |

### `MyCustomDotPainter`

`FlDotPainter` を継承したカスタムドット描画クラス。

| フィールド   | 型       | 説明                                       |
|------------|---------|-------------------------------------------|
| `radius`   | `double`| ドットの半径                               |
| `color`    | `Color` | ドットの色                                 |
| `showText` | `bool`  | 値ラベルの表示フラグ                        |
| `text`     | `String`| 表示する値（`spot.y.toString()`）           |

`draw` メソッドで円を描いた後、`showText` が `true` の場合は `TextPainter` を使ってドットの真上に値を描画します。

---

## 依存パッケージ

### dependencies

| パッケージ         | バージョン   | 用途                              |
|------------------|-------------|----------------------------------|
| `flutter`        | SDK         | UI フレームワーク                  |
| `cupertino_icons`| `^1.0.8`    | iOS スタイルアイコン               |
| `fl_chart`       | `^0.69.0`   | チャート描画                       |

### dev_dependencies

| パッケージ       | バージョン   | 用途           |
|----------------|-------------|---------------|
| `flutter_test` | SDK         | テスト         |
| `flutter_lints`| `^4.0.0`    | Lint ルール    |

---

## 環境

| 項目         | バージョン  |
|-------------|-----------|
| Dart SDK    | `^3.5.0`  |

---

## セットアップ

```bash
# リポジトリのクローン
git clone https://github.com/toyotarou/flutter_fl_chart_dot_value_display.git
cd flutter_fl_chart_dot_value_display

# パッケージの取得
flutter pub get

# アプリの実行
flutter run
```

---

## 対応プラットフォーム

- Android
- iOS
- Web
- macOS
- Linux
- Windows
