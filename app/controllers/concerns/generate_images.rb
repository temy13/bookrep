require 'RMagick'
module GenerateImages extend ActiveSupport::Concern

# include RMagick
include Magick

LENGTH=8

  def generate_image(question)
    image = ImageList.new('public/images/question_image_blank.png').first
    draw = Draw.new
    draw.font = 'lib/hannotate-sc-regular.otf'
    #draw.font = 'lib/rounded-mgenplus-1p-regular.ttf'
    draw.pointsize = 48
    draw.gravity = CenterGravity
    content = question.content.scan(/.{1,#{22}}/).take(6).join("\n")
    draw.annotate(image, 1000, 450, 100, 25, content)
    name = question.is_anonymous ? "匿名の投稿" : question.user.name + "さん"
    name = name.length < LENGTH ? name : name[0...LENGTH] + "..."
    draw.fill = "#FFFFFF"
    draw.pointsize = 48
    draw.annotate(image, 420, 100, 760, 520, name)
    path = "tmp/images/q_" + question.id.to_s + ".jpg"
    image.write(path)
    path
  end

end
