# CampingData

Django 露營用品電商平台

## 專案簡介

這是一個使用 Django 框架開發的露營用品線上購物網站，提供完整的電商功能。

## 主要功能

- 🛍️ 商品管理與展示（10大分類）
- 🛒 購物車系統
- 📦 訂單管理
- 👤 會員系統（註冊、登入、個人中心）
- ❤️ 我的最愛功能
- 📝 商品評論
- 🔍 商品搜尋與篩選

## 技術棧

- **後端框架**: Django 3.2.9
- **資料庫**: Firebase Firestore（完全使用 Firebase，不使用 MySQL）
- **前端**: Bootstrap 5, jQuery, Slick
- **語言**: Python 3.11+
- **時區**: Asia/Taipei

## 安裝與執行

### 環境需求
- Python 3.11+
- Firebase 專案與服務帳號憑證
- pip

### 安裝步驟

1. **克隆專案**
```bash
git clone https://github.com/rurumi02-boop/CampingData.git
cd CampingData
```

2. **安裝依賴**
```bash
pip install -r requirements.txt
```

3. **設定 Firebase**
   - 前往 [Firebase Console](https://console.firebase.google.com/)
   - 創建或選擇專案
   - 前往「專案設定」→「服務帳號」
   - 點擊「產生新的私密金鑰」
   - 下載 JSON 檔案並重命名為 `firebase-credentials.json`
   - 將檔案放在專案根目錄（`C:\CampingData\firebase-credentials.json`）

4. **啟動開發伺服器**
```bash
python manage.py runserver
```

> **注意**：此專案使用 Firebase Firestore，不需要執行 `migrate` 或創建 MySQL 資料庫。所有資料都儲存在 Firebase 中。

## 專案結構

```
CampingData/
├── CampingData/          # Django 專案設定
├── myapp/                # 主要應用程式
│   ├── models.py         # 資料模型
│   ├── views.py          # 視圖函數
│   ├── urls.py           # URL 路由
│   └── templates/        # 模板文件
├── static/               # 靜態文件
├── product_images/       # 商品圖片
└── manage.py            # Django 管理腳本
```

## 資料模型

所有資料都儲存在 Firebase Firestore 中，使用以下集合（Collections）：

- `users` - 使用者資料
- `products` - 商品資料
- `categories` - 分類資料
- `brands` - 品牌資料
- `orders` - 訂單資料
- `order_items` - 訂單項目
- `wishlist` - 我的最愛
- `reviews` - 商品評論

> **注意**：Django 的模型定義（`myapp/models.py`）僅作為參考，實際資料操作都通過 `myapp/firebase_service.py` 中的 Firebase 服務層進行。

## Firebase 設定

詳細的 Firebase 設定和遷移說明，請參考：
- `FIREBASE_MIGRATION.md` - Firebase 遷移完整說明
- `網頁功能測試步驟指南.md` - 功能測試指南

## 授權

此專案僅供學習使用。
