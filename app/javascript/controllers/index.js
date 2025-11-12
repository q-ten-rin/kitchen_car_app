import { application } from "./application"

// controllers フォルダ内のコントローラを自動読み込み
import { eagerLoadControllersFrom } from "@hotwired/stimulus"

// フォルダ内のコントローラをまとめてロード
eagerLoadControllersFrom("./controllers", application)
