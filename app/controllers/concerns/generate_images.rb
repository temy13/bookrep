require 'RMagick'
module GenerateImages extend ActiveSupport::Concern

# include RMagick
include Magick

  def generate_image(question)
    image = ImageList.new('public/images/question_image_blank.png').first
    draw = Draw.new
    draw.font = 'lib/rounded-mgenplus-1p-regular.ttf'
    draw.pointsize = 64
    draw.gravity = CenterGravity
    draw.annotate(image, 1000, 450, 100, 25, question.content)
    name = question.is_anonymous ? "匿名の投稿" : question.user.name + "さん"
    name = name.length < 10 ? name : name[0...10] + "..."
    logger.debug name
    draw.fill = "#FFFFFF"
    draw.pointsize = 48
    draw.annotate(image, 420, 100, 800, 520, name)
    path = "tmp/images/q_" + question.id.to_s
    image.write(path)
    path
  end

end
