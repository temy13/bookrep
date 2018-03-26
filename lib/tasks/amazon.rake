namespace :amazon do
  task :item_ranking => :environment do |variable|
    res = Amazon::Ecs.item_search('ruby', {:response_group => 'Medium', :sort => 'salesrank', :country => 'jp'})
    res.items.each do |item|
      p item.get('ASIN')
      p item.get('ItemAttributes/Title')
    end
  end

  task :sell => :environment do
    res = Amazon::Ecs.browse_node_lookup('2275277051', {:country => 'jp'})
    # res.get_elements('//BrowseNodes//BrowseNode//Children').each do |item|
    res.get_elements('//BrowseNodes//BrowseNode').each do |item|
        p "==========================="
        p item
        p item.get("BrowseNodeId")
        p item.get("Name")
        # # p item.get('ASIN')
        # p item.get('Title')
        # p item.get('DetailPageURL')
        # p item.get('ProductGroup')
    end
  end


end
