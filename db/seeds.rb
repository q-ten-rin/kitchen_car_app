categories = [
  "クレープ",
  "たこ焼き",
  "ハンバーガー",
  "コーヒー",
  "カレー",
  "ラーメン",
  "スイーツ",
  "フード",
  "ドリンク",
  "その他"
]

categories.each do |name|
  Category.find_or_create_by!(name: name)
end
