namespace :daily do
  task :numbers => :environment do
    now = Time.now
    d = Time.now.since(-1.day)
    users = User.normals.size
    today_login_users = User.where(last_sign_in_at: d..now).normals.size
    today_created_questions = Question.includes(:user).where(created_at: d..now).select{|q| q.user.normal?}.size
    today_created_answers = Answer.includes(:user).where(created_at: d..now).select{|a| a.user.normal?}.size
  end
end
