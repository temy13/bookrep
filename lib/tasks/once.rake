namespace :once do
  if ENV['PWD'].present?
    require  ENV['PWD'] + "/app/controllers/concerns/generate_images"
  else
    require "/app/controllers/concerns/generate_images"
  end
  include GenerateImages

  task :image => :environment do
    @questions = Question.all.select{|q| q.image.blank?}
    @questions.each{|question|
      path = generate_image(question)
      question.image = File.open(path)
      question.save
    }
  end

  task :states => :environment do
    @dummies = User.where(id: 0..22)
    @dummies.each{|u|
      next if u.blank?
      u.states= :dummy
      u.save
    }
    admins = ["__Alice0002", "__Bob0001", "Charlie0001", "sunglassed_dog", "_ymc", "temyV", "tachyon_m", "temycs", "temyv2", "bookreptokyo"]
    admins.each{|name|
      u = User.where(screen_name: name).first
      next if u.blank?
      u.states= :admin
      u.save
    }
    emails = ["temy.test0000@gmail.com", "temy.poporofier00@gmail.com"]
    emails.each{|email|
      u = User.where(email: email).first
      next if u.blank?
      u.states= :admin
      u.save
    }
  end

  task :slack_test => :environment do
    notifier = Slack::Notifier.new(ENV["SLACK_QUESTIONS"])
    notifier.ping("ごめんなさいテストです　質問生成ではありません")
  end


end
