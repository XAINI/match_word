class DThree
  constructor: (@$eml)->
    @bind_event()

  bind_event: ->
    @$eml.on "click",".body .click-me",->
      str = ["I burn in China","I like Italy's clothes","I want to go Canada"]
      char_value = "BackStreetBoy"
      p_value = d3.select(".body").select(".second-value").remove()
      # p_value.data(char_value)
      #   .text( (d, i)->
      #     d
      #   )
      p_value.style("color","red").style("font-size","22px").style("font-family","微软雅黑")

    @$eml.on "click", ".body .display-svg", ->
      width = 300
      height = 300
      dataset = [2.5,2.1,1.70,1.30,0.9,0.1,3]
      rect_height = 25

      # 生成比例尺
      linear = d3.scale.linear()
        .domain([0,d3.max(dataset)])
        .range([0,250])

      # 生成画布
      svg = d3.select(".body")
        .append("svg")
        .attr("width", width)
        .attr("height",height)

      # 画图
      svg.selectAll("rect")
        .data(dataset)
        .enter()
        .append("rect")
        .attr("x",20)
        .attr("y",(d,i)->
          i * rect_height
        )
        .attr("width",(d)->
          linear(d)
        )
        .attr("height",rect_height - 2)
        .attr("fill","steelblue")

      # 生成坐标轴
      axis = d3.svg.axis()
        .scale(linear)
        .orient("bottom")
        .ticks(9)

      # 设置坐标
      # axis(svg.append(g)) 与下面这个表达式相等
      svg.append("g")
        .attr("class","axis")
        .attr("transform","translate(20,180)")
        .call(axis)

    @$eml.on "click",".body .display-rect", ->
      width = 400
      height = 400

      svg = d3.select(".body")
        .append("svg")
        .attr("width", width)
        .attr("height", height)

      padding = {left:30, right:30, top:20, bottom:20}

      dataset = [10, 20, 30, 40, 33, 24, 12, 5]
      
      x_scale = d3.scale.ordinal()
        .domain(d3.range(dataset.length))
        .rangeRoundBands([0, width - padding.left - padding.right])

      y_scale = d3.scale.linear()
        .domain([0, d3.max(dataset)])
        .range([height - padding.top - padding.bottom, 0])

      x_axis = d3.svg.axis()
        .scale(x_scale)
        .orient("bottom")

      y_axis = d3.svg.axis()
        .scale(y_scale)
        .orient("left")

      rect_padding = 4

      rects = svg.selectAll(".my-rect")
        .data(dataset)
        .enter()
        .append("rect")
        .attr("class","my-rect")
        .attr("transform","translate(#{padding.left},#{padding.top})")
        .attr("x",(d,i)->
          x_scale(i) + rect_padding / 2
        )
        .attr("y",(d)->
          y_scale(d)
        )
        .attr("width", x_scale.rangeBand() - rect_padding)
        .attr("height", (d)->
          height - padding.top - padding.bottom - y_scale(d)
        )
        .attr("fill","steelblue")

      texts = svg.selectAll(".my-text")
        .data(dataset)
        .enter()
        .append("text")
        .attr("class","my-text")
        .attr("transform","translate(#{padding.left},#{padding.top})")
        .attr("x",(d,i)->
          x_scale(i) + rect_padding / 2
        )
        .attr("y",(d)->
          y_scale(d)
        )
        .attr("dx", ->
          (x_scale.rangeBand() - rect_padding) / 2
        )
        .attr("dy", (d)->
          20
        )
        .text((d)->
          d
        )

      svg.append("g")
        .attr("class", "axis")
        .attr("transform","translate(#{padding.left},#{height - padding.bottom})")
        .call(x_axis)
        
      svg.append("g")
        .attr("class","axis")     
        .attr("transform","translate(#{padding.left},#{padding.top})")
        .call(y_axis)




jQuery(document).on "ready page:load", ->
  if jQuery(".practice-d-three").length > 0
    new DThree jQuery(".practice-d-three") 
