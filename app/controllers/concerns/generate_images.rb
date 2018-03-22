require 'RMagick'
module GenerateImages extend ActiveSupport::Concern

# include RMagick
include Magick


  def generate_image(question)
    length = 8
    image = ImageList.new('public/images/question_image_blank.png').first
    draw = Draw.new
    draw.font = 'lib/hannotate-sc-regular.otf'
    #draw.font = 'lib/rounded-mgenplus-1p-regular.ttf'
    draw.pointsize = 48
    draw.gravity = CenterGravity
    content = question.content.scan(/.{1,#{22}}/).take(6).join("\n")
    draw.annotate(image, 1000, 450, 100, 25, content)
    name = question.is_anonymous ? "匿名の投稿" : question.user.name + "さん"
    name = name.length < length ? name : name[0...length-1] + "..."
    draw.fill = "#FFFFFF"
    draw.pointsize = 48
    draw.annotate(image, 420, 100, 760, 520, name)
    t = Time.new

    path = "tmp/images/q_" + question.id.to_s + "_" + t.strftime("%Y%m%d") + ".jpg"
    image.write(path)
    path
  end

end
