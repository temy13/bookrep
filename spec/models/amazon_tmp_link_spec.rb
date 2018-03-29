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

require 'rails_helper'

RSpec.describe AmazonTmpLink, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
