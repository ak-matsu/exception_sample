namespace :distribute_ticket do
  desc "全ユーザーのticket_countを10増加させる"
  task rescue: :environment do
    User.find_each do |user|
      # incrementメソッド、カラム名と数字を引数に取り、
      #引数の数だけカラムの値を増加させます。
      #今回は、「ticket_countカラムの値を10増加させる」という意味です。
    
      begin #エラーが起こるものを囲む
        user.increment!(:ticket_count, 10)
      rescue => e
        Rails.logger.debug e.message
      end
    end
  end

  #raiseは例外処理を発生させる文法 raise 発生させたい例外クラス, 'エラーメッセージ'
  desc "全ユーザーの中にticket_countが10枚追加されると最大値より大きくなるレコードがある場合に例外を発生させる"
  task raise: :environment do
    User.find_each do |user|
      begin
        if user.ticket_count > 2147483647 - 10
          raise RangeError, "#{user.id}は、チケット取得可能枚数の上限を超えてしまいます！"
        end
      rescue => e
        Rails.logger.debug e.message
      end
    end
  end

  desc "全ユーザーのticket_countをトランザクションで10増加させる"
  task transact: :environment do
    ActiveRecord::Base.transaction do
      User.find_each do |user|
        user.increment!(:ticket_count, 10)
      end
    end
  end
end
