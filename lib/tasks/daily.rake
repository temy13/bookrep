namespace :daily do
  task :numbers => :environment do
    now = Time.now
    d = Time.now.since(-1.day)
    users = User.normals.size
    today_login_users = User.where(last_sign_in_at: d..now).normals.size
    notice_users = User.normals.select{|u| u.is_notice}.size
    today_created_questions = Question.includes(:user).where(created_at: d..now).select{|q| q.user.normal?}.size
    today_created_answers = Answer.includes(:user).where(created_at: d..now).select{|a| a.user.normal?}.size
    today_created_logs = BookClickLog.includes(:user).where(created_at: d..now).select{|l| l.user.blank? || l.user.normal?}.size
    questions = Question.includes(:user).select{|q| q.user.normal?}.size
    answers = Answer.includes(:user).select{|a| a.user.normal?}.size
    logs = BookClickLog.includes(:user).select{|l| l.user.blank? || l.user.normal?}.size
    p "Users: " + users.to_s
    p "Notice Users: " + notice_users.to_s
    p "Today Users: " + today_login_users.to_s
    p "Qs: " + questions.to_s
    p "Today Qs: " + today_created_questions.to_s
    p "As: " + answers.to_s
    p "Today As: " + today_created_answers.to_s
    p "ClickLogs: " + logs.to_s
    p "Today ClickLogs: " + today_created_logs.to_s

  end
end
