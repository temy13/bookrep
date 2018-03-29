# == Schema Information
#
# Table name: amazon_tmp_links
#
#  id          :integer          not null, primary key
#  title       :string
#  node_id     :integer
#  click_count :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# NOTICE:: click_count not use
class AmazonTmpLink < ApplicationRecord
  def url
    "https://www.amazon.co.jp/gp/browse.html/?ie=UTF8&node=" + node_id.to_s + "&tag=" + ENV["AMAZON_ASSOCIATE_ID"]
  end
end
