<template>
  <div id="chart"></div>
</template>

<script>
export default {
  mounted: function() {
  
   var data = [
     { title: 'Blog', width: 30, description: 'I write stuff' },
     { title: 'About', width: 30, description: 'Interesting things about me' },
     { title: 'Projects', width: 30, description: 'Projects and collaborations' },
    ];
   var text = "";
   var width = 800;
   var height = 600;
   var thickness = 30;
   var duration = 0;
   var margin = 56
   var radius = Math.min(width - margin, height - margin) / 2;
  //  var color = d3.scaleOrdinal(d3.schemeCategory10);
   var anglesRange = Math.PI;

		 var arc = d3.arc()
    .innerRadius(radius - thickness)
    .outerRadius(radius)
    .cornerRadius(12)

     var arcOver = d3.arc()
    .innerRadius(radius - thickness)
    .outerRadius(radius * 1.1)
    .cornerRadius(20)

		var pie = d3.pie()
    .value(function(d) { return d.width; })
    .sort(null)
    .startAngle( anglesRange * -1)
    .endAngle( anglesRange)
    .padAngle(0.1)

		var svg = d3.select("#chart")
      .append('svg')
      .attr('class', 'pie')
      .attr('width', width)
      .attr('height', height)
	    .append("g")
	    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

    var g = svg.selectAll(".arc")
      .data(pie(data))
      .enter().append("g")
      .attr('class', 'arc')

   	var options = g.append("path")
    	.attr("d", arc)
      .style("fill", '#AFD275')
      .style('stroke', '#AFD275')
      .attr('id', (d, i) => {
        return `path${i}`
      })

    let labels = g.append("text")
      .attr('id', (d, i) => {
        return `label${i}`
      })
      .style('font-size', '16px')
    	.attr("transform", function(d) {
        var _d = arc.centroid(d);
        let rotation = d.endAngle < Math.PI ? (d.startAngle/2 + d.endAngle/2) * 180/Math.PI : (d.startAngle/2  + d.endAngle/2 + Math.PI) * 180/Math.PI ;
        return "translate(" + _d + ") rotate(" + rotation + ")";
      })
      .attr("dy", (d) => {
        if (d.endAngle < Math.PI) {
          return "5px"
        } else {
          return "4px"
        }
      })
      .style("text-anchor", "middle")
      .style('fill', 'white')
      .text(function(d) {
        return d.data.title;
      });

    let centerText

    options.on('mouseover', function(e, b, allOptions) {
      let option = d3.select(this);

      option.transition().duration(600)
        .style('fill', '#AFD275')
        .attr('d', arcOver)

      let label = d3.select(`#label${e.index}`)
      
      label.transition().duration(600)
        .style('font-size', '24px')
        .attr("dy", (d) => {
        if (d.endAngle < Math.PI) {
          return "-6px"
        } else {
          return "20px"
        }
      })

      if (centerText) { centerText.remove() }

      centerText = svg.append("text")
        .attr("text-anchor", "middle")
        .attr('class', 'donut-chart--label-center')
        .style('font-size', '24px')
        .attr('opacity', 0)
        .style('fill', '#AFD275')
        .text(e.data.description)

      centerText.transition().duration(600).attr('opacity', 1)
    })

    options.on('mouseleave', function(e, b, c) {
      let option = d3.select(this);

      option.transition().duration(600)
        .attr('d', arc)
        .style('fill', '#AFD275')

      let label = d3.select(`#label${e.index}`)
      
      label.transition().duration(600).style('fill', '#ffffff').style('font-size', '16px')
      .attr("dy", (d) => {
        if (d.endAngle < Math.PI) {
          return "5px"
        } else {
          return "4px"
        }
      })

      centerText.transition().duration(600).attr('opacity', 0)
    })
  },

  methods: {
    
  }
}
</script>

<style>
  path {
    cursor: pointer;
  }

  text {
    font-family: 'Roboto Slab', serif;
    font-weight: bold;
    cursor: pointer;
  }
</style>
