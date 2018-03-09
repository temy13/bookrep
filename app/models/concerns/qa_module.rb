module QAModule
  extend ActiveSupport::Concern

  # def name_or_hide
  #   name = self.is_anonymous ? " " : self.user.name + "さん"
  #   name.length < LENGTH ? name : name[0...LENGTH] + "..."
  # end

  LENGTH = 8

  def name_or_anonymous
    name = self.is_anonymous ? "匿名" : self.user.name + "さん"
    name.length < LENGTH ? name : name[0...LENGTH] + "..."
  end

  def name_or_anonymous_post
    name = self.is_anonymous ? "匿名の投稿" : self.user.name + "さん"
    name.length < LENGTH ? name : name[0...LENGTH] + "..."
  end


end
