# activerecord-importというGemを利用

users = []
10000.times do |i|
  # usersに10000件新規ユーザーの情報を格納する
  users << User.new(name: "dummy-#{i+1}", ticket_count: 0)
end
# importメソッドの引数に配列を渡して、まとめてレコードを作成する。
User.import users
# ticket_countをint型で許容できる最大の値にする
User.find(500).update(ticket_count: 2147483647)
