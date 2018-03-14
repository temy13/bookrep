module ApplicationHelper
  def get_title
    @page_title.blank? ? "ブクリプ:読書好きのQ&Aコミュニティ/新しい本に出会おう" : @page_title
  end
  def get_seo_keywords
    @seo_keywords.blank? ? "ブクリプ,bookrep" : @seo_keywords
  end
  def get_seo_contents
    @seo_contents.blank? ? "ブクリプは、読書好きのためのQ&Aコミュニティです。友達や読書家のおすすめ本を知りたい！新しいジャンルに挑戦したい！今の自分に合った作品を知りたい！ブクリプなら、スマホやPCで簡単に質問できます。" : @seo_contents
  end


end
