# class ImageWorker
# 　　include Sidekiq::Worker
#
#   require 'RMagick'
#
#   # include RMagick
#   include Magick
#
#   LENGTH=8
#
#   def perform(q_id)
#     question = Question.find(q_id)
#     path = generate_image(question)
#     question.image = File.open(path)
#     question.save
#   end
#
#   def generate_image(question)
#     image = ImageList.new('public/images/question_image_blank.png').first
#     draw = Draw.new
#     draw.font = 'lib/hannotate-sc-regular.otf'
#     #draw.font = 'lib/rounded-mgenplus-1p-regular.ttf'
#     draw.pointsize = 48
#     draw.gravity = CenterGravity
#     content = question.content.scan(/.{1,#{22}}/).take(6).join("\n")
#     draw.annotate(image, 1000, 450, 100, 25, content)
#     name = question.is_anonymous ? "匿名の投稿" : question.user.name + "さん"
#     name = name.length < LENGTH ? name : name[0...LENGTH] + "..."
#     draw.fill = "#FFFFFF"
#     draw.pointsize = 48
#     draw.annotate(image, 420, 100, 760, 520, name)
#     t = Time.new
#
#     path = "tmp/images/q_" + question.id.to_s + "_" + t.strftime("%Y%m%d") + ".jpg"
#     image.write(path)
#     path
#   end
#
# end
#
#
# end
