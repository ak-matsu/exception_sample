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
end