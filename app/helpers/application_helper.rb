module ApplicationHelper
  def get_title
    @page_title.blank? ? "ブクリプ:読書好きのQ&Aコミュニティ/新しい本に出会おう" : @page_title
  end
  def get_seo_keywords
    @seo_keywords.blank? ? "ブクリプ,bookrep" : @seo_keywords
  end
  def get_seo_contents
    @seo_contents.blank? ? "" : @seo_contents
  end


end
