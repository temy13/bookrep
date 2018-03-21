namespace :once do
  require ENV['PWD'] + "/app/controllers/concerns/generate_images"
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
      u.states= :dummy if u.present?
    }
    admins = ["__Alice0002", "__Bob0001", "Charlie0001", "sunglassed_dog", "_ymc", "temyV", "tachyon_m", "temycs"]
    admins.each{|name|
      u = User.where(screen_name: name).first
      u.states= :admin if u.present?
    }
    emails = ["temy.test0000@gmail.com", "temy.poporofier00@gmail.com"]
    emails.each{|email|
      u = User.where(email: email).first
      u.states= :admin if u.present?
    }


  end
end
