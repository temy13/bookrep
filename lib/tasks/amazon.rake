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
    d = DateTime.now
    a = [[],[],[],[],[],[]]
    # res.get_elements('//BrowseNodes//BrowseNode//Children').each do |item|
    res.get_elements('//BrowseNodes//BrowseNode').each do |item|
        name = item.get("Name")
        next unless name.include?("まで")
        next if name.include?("（終了）")
        (0..5).each do |n|
          tmp = (d + n.day).strftime("%-m/%d")
          next unless name.include?("(" +tmp +"まで)")
          a[n].push({
              "title": name,
              "node_id": item.get("BrowseNodeId").to_i
              }
            )
        end
        # p "==========================="
        p item
        # p item.get("BrowseNodeId")
        # p item.get("Name")
    end
    p a
    a.flatten.each_with_index do |obj, i|
        p obj
        link = AmazonTmpLink.find_or_create_by(:id => i+1)
        if link.blank?
          link = AmazonTmpLink.new(title: obj[:title], node_id: obj[:node_id])
        else
          link.title = obj[:title]
          link.node_id = obj[:node_id]
        end
        p link
        link.save
    end
  end


end
