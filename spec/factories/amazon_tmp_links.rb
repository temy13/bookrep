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

FactoryBot.define do
  factory :amazon_tmp_link do
    title "MyString"
    node_id 1
    click_count 1
  end
end
