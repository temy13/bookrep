# == Schema Information
#
# Table name: title_queries
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  query      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TitleQuery < ApplicationRecord
  belongs_to :user, optional: true

end
