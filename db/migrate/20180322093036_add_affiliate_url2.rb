class AddAffiliateUrl2 < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :rakuten_affiliate_url, :string
  end
end
