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
    admins = ["__Alice0002", "__Bob0001", "Charlie0001", "sunglassed_dog", "_ymc", "__ykkmp","temyV", "tachyon_m", "temycs", "temyv2", "bookreptokyo"]
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

  task :answer_bot => :environment do
    return if User.answer_bots.present?
    user = User.new(name:"メカリプ博士(公式)", profile:"メカリプ博士ですワン！\n\r質問を投稿してくれたら、世界中の本からオススメを探すワン！", email:"botdog@qwertyuiop.com", password:"uq8dj5y47erhsfiOHwrirwj")
    user.icon_path = "/assets/icons/botdog"
    user.states = User.states[:answer_bot]
    user.save

  end

  task :vapid do
    # One-time, on the server
    vapid_key = Webpush.generate_key

    p vapid_key.public_key
    p vapid_key.private_key

  end

end
