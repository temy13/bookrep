# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->

  if ($('#analyze').exists())
    generate_piechart = (id, datas) ->
      svg = d3.select(id).append('svg').append('g')

      change = (data) ->
        slice = svg.select('.slices').selectAll('path.slice').data(pie(data), key)

        midAngle = (d) ->
          d.startAngle + (d.endAngle - (d.startAngle)) / 2

        slice.enter().insert('path').style('fill', (d) ->
          color d.data.label
        ).attr 'class', 'slice'
        slice.transition().duration(1000).attrTween 'd', (d) ->
          @_current = @_current or d
          interpolate = d3.interpolate(@_current, d)
          @_current = interpolate(0)
          (t) ->
            arc interpolate(t)
        slice.exit().remove()

        ### ------- TEXT LABELS -------###

        text = svg.select('.labels').selectAll('text').data(pie(data), key)
        text.enter().append('text').attr('dy', '.35em').text (d) ->
          d.data.label
        text.transition().duration(1000).attrTween('transform', (d) ->
          @_current = @_current or d
          interpolate = d3.interpolate(@_current, d)
          @_current = interpolate(0)
          (t) ->
            d2 = interpolate(t)
            pos = outerArc.centroid(d2)
            pos[0] = radius * (if midAngle(d2) < Math.PI then 1 else -1)
            'translate(' + pos + ')'
        ).styleTween 'text-anchor', (d) ->
          @_current = @_current or d
          interpolate = d3.interpolate(@_current, d)
          @_current = interpolate(0)
          (t) ->
            d2 = interpolate(t)
            if midAngle(d2) < Math.PI then 'start' else 'end'
        text.exit().remove()

        ### ------- SLICE TO TEXT POLYLINES -------###

        polyline = svg.select('.lines').selectAll('polyline').data(pie(data), key)
        polyline.enter().append 'polyline'
        polyline.transition().duration(1000).attrTween 'points', (d) ->
          @_current = @_current or d
          interpolate = d3.interpolate(@_current, d)
          @_current = interpolate(0)
          (t) ->
            d2 = interpolate(t)
            pos = outerArc.centroid(d2)
            pos[0] = radius * 0.95 * (if midAngle(d2) < Math.PI then 1 else -1)
            [
              arc.centroid(d2)
              outerArc.centroid(d2)
              pos
            ]
        polyline.exit().remove()
        return

      svg.append('g').attr 'class', 'slices'
      svg.append('g').attr 'class', 'labels'
      svg.append('g').attr 'class', 'lines'
      width = 600
      height = 200
      radius = Math.min(width, height) / 2
      pie = d3.layout.pie().sort(null).value((d) ->
        d.value
      )
      arc = d3.svg.arc().outerRadius(radius * 0.8).innerRadius(radius * 0.4)
      outerArc = d3.svg.arc().innerRadius(radius * 0.9).outerRadius(radius * 0.9)
      svg.attr 'transform', 'translate(' + width / 2 + ',' + height / 2 + ')'

      key = (d) ->
        d.data.label

      color = d3.scale.ordinal().domain([
        'Lorem ipsum'
        'dolor sit'
        'amet'
        'consectetur'
        'adipisicing'
        'elit'
        'sed'
        'do'
        'eiusmod'
        'tempor'
        'incididunt'
      ]).range([
        'rgba(0, 0, 0, 0.8)'
        'rgba(0, 0, 0, 0.6)'
        'rgba(0, 0, 0, 0.4)'
        'rgba(0, 0, 0, 0.2)'
      ])
      change datas
    generate_linechart = (id, v) ->
        margin =
          top: 40
          right: 40
          bottom: 40
          left: 40
        width = 600 - (margin.left) - (margin.right)
        height = 400 - (margin.top) - (margin.bottom)
        numbers = v.map((element, index, array) ->
          parseInt(element)
        )
        svg = d3.select(id).append('svg').attr('width', width + margin.left + margin.right).attr('height', height + margin.top + margin.bottom).append('g').attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')
        value = [0,1,2,3,4,5,6,7].map((e, index, array) ->
          {
            "label": e
            "value": numbers[e]
          }
        )
        xScale = d3.scale.linear().domain([
          0
          7
        ]).range([
          0
          width
        ])
        yScale = d3.scale.linear().domain([
          Math.min.apply(null, numbers) * 0.9
          Math.max.apply(null, numbers) * 1.1
        ]).range([
          height
          0
        ])
        colorCategoryScale = d3.scale.category10()
        xAxis = d3.svg.axis().scale(xScale).orient('bottom').tickSize(6, -height).tickFormat((d) ->
          d + '日前'
        )
        yAxis = d3.svg.axis().ticks(5).scale(yScale).orient('left').tickSize(6, -width)
        # lineの設定。
        line = d3.svg.line().x((d) ->
          xScale d['label']
        ).y((d) ->
          yScale d['value']
        ).interpolate('cardinal')
        # 線の形を決める。
        svg.selectAll('circle').data(value).enter().append('circle').attr('r', 5).attr('fill', (d) ->
          colorCategoryScale "up"#d['増減']
        ).attr('cx', (d) ->
          xScale d['label']
        ).attr 'cy', (d) ->
          yScale d['value']
        # line表示。
        svg.append('path').datum(value).attr('class', 'line').attr 'd', line
        # 上で作ったlineを入れて、ラインpathを作る。
        svg.append('g').attr('class', 'y axis').call(yAxis).append('text').attr('y', -10).attr('x', 10).style('text-anchor', 'end')#.text 'value(兆円)'
        svg.append('g').attr('class', 'x axis').attr('transform', 'translate(0,' + height + ')').call xAxis
        return

  if ($('#user-type').exists())
    datas = [
      {
        label: 'Twitter: ' + gon.twitter_user_size
        value: gon.twitter_user_size
      }
      {
        label: 'Email: ' + gon.mail_user_size
        value: gon.mail_user_size
      }
    ]
    generate_piechart("#user-type", datas)

  if ($('#user-notice').exists())
    datas = [
      {
        label: 'Notice ON: ' + gon.notice_user_size
        value: gon.notice_user_size
      }
      {
        label: 'Notice OFF: ' + gon.unnotice_user_size
        value: gon.unnotice_user_size
      }
    ]
    generate_piechart("#user-notice", datas)

  if ($('#log-allGET').exists())
    generate_linechart("#log-allGET", gon.all_get_numbers)

  if ($('#log-ipGET').exists())
    generate_linechart("#log-ipGET", gon.unique_ips)

  if ($('#log-userGET').exists())
    generate_linechart("#log-userGET", gon.unique_users)

  if ($('#log-ipDRate').exists())
    generate_linechart("#log-ipDRate", gon.ips_d_rate)
  if ($('#log-userDRate').exists())
    generate_linechart("#log-userDRate", gon.users_d_rate)


# ---
# generated by js2coffee 2.2.0
