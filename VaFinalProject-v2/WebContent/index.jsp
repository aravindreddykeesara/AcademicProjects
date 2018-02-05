 <!DOCTYPE html>
<html>
  <head>    
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
     <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>    
  <link rel="stylesheet" href="styles/index.css" type="text/css"/>

     </head>
     <title>
      Va test
    </title>
   <body>  

    <nav class="navbar navbar-inverse">
    <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand " href="#">Project Demonstration</a>
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a id="Homepagereload">Home</a></li>
     
    </ul>
  </div>
</nav>


    <div class=" text-center">
   <h2> Visual Analytics - Term Project Fall 2017 </h2>
   <h4>Visualizing The Daimler Truck data from oct 6th to 0ct 10th 2017</h4> 
   <h4> Task : Visualize the number of defects per Department</h4>
   </div>

       <div class="container text-center" style="border:3px solid #cecece;">
        
                    <div id = "page">
                    <h3> Departments  <p style =" text-align: right;"> Dept.Selected : <span  id = "bubbleItemNote"> ALL </span>  </p></h3>
                    <div id="mainBubble"><svg class="mainBubbleSVG"></svg>
                   </div>
               
        </div>
        <br>
        <br>
        <div class="container text-center" >
                  <div class="row">
                       <div class="col-sm-4 col-md-push-7">
							        <div class="dropdown">
                                        <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">Month
                                           <span class="caret"></span></button>
                                           <ul class="dropdown-menu">
                                              <li><a href="#">Jan</a></li>
                                              <li><a href="#">Feb</a></li>
                                              <li><a href="#">Mar</a></li>
                                              <li><a href="#">Apr</a></li>
                                              <li><a href="#">May</a></li>
                                          </ul>
                                    </div>
                          </div>
                         <div class="col-sm-4  col-md-push-5">
              						   <div class="dropdown">
                                          <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown"> Year
                                            <span class="caret"></span></button>
                                            <ul class="dropdown-menu">
                                                 <li><a href="#">2014</a></li>
                                                 <li><a href="#">2015</a></li>
                                                 <li><a href="#">2016</a></li>
                                                 <li><a href="#">2017</a></li>
                                            </ul>
                                     </div>
                              </div>
                        </div> 
                 </div>

      <br>
      <br>
        <div class="container " >
              <div class="row">
                       <div class="col-sm-3">
                            <svg id="visualisation"></svg>
                       </div>
                       <div class="col-sm-6">
 
                            <div id="lineChart"></div>
                      </div>          
              </div>
                  <br>
             <div class="row">
                      <div class="col-sm-12">
                          <div id="barChart"></div>  
                     </div>
            </div>
      </div>
    </div>

</body>


  <script>
   

   $("#Homepagereload").click(function(e){

     window.location.reload();

   });


   var w = window.innerWidth*0.68*0.8;
   var h = Math.ceil(w*0.7);
   var oR = 0;
   var nTop = 0;
    
   var svgContainer = d3.select("#mainBubble")
      .style("height", h+"px");
    
   var svg = d3.select("#mainBubble").append("svg")
        .attr("class", "mainBubbleSVG")
        .attr("width", w)
        .attr("height",h)
        .on("mouseleave", function() {return resetBubbles();});
         
     
 
 
    d3.json("groupName_data.json", function(error, root) {
        console.log(error);
     
        var bubbleObj = svg.selectAll(".topBubble")
                .data(root.children)
            .enter().append("g")
                .attr("id", function(d,i) {return "topBubbleAndText_" + i});
             
        console.log(root);  
        nTop = root.children.length;
        oR = w/(1+3*nTop);  
 
    h = Math.ceil(w/nTop*2);
    svgContainer.style("height",h+"px");
         
        var colVals = d3.scale.category10();
         
        bubbleObj.append("circle")
            .attr("class", "topBubble")
            .attr("id", function(d,i) {return "topBubble" + i;})
            .attr("r", function(d) { return oR; })
            .attr("cx", function(d, i) {return oR*(3*(1+i)-1);})
            .attr("cy", (h+oR)/3)
            .style("fill", function(d,i) { return colVals(i); }) // #1f77b4
        .style("opacity",0.3)
            .on("mouseover", function(d,i) {return activateBubble(d,i);});
         
             
        bubbleObj.append("text")
            .attr("class", "topBubbleText")
            .attr("x", function(d, i) {return oR*(3*(1+i)-1);})
            .attr("y", (h+oR)/3)
        .style("fill", function(d,i) { return colVals(i); }) // #1f77b4
            .attr("font-size", 30)
            .attr("text-anchor", "middle")
        .attr("dominant-baseline", "middle")
        .attr("alignment-baseline", "middle")
            .text(function(d) {return d.name})      
            .on("mouseover", function(d,i) {return activateBubble(d,i);});
         
         
        for(var iB = 0; iB < nTop; iB++)
        {
            var childBubbles = svg.selectAll(".childBubble" + iB)
                .data(root.children[iB].children)
                .enter().append("g");


                 
        var nSubBubble = Math.floor(root.children[iB].children.length/2.0);   
             
            childBubbles.append("circle")
                .attr("class", "childBubble" + iB)
                .attr("id", function(d,i) {return "childBubble_" + iB + "sub_" + i;})
                .attr("r",  function(d) {return oR/3.0;})
                .attr("cx", function(d,i) {return (oR*(3*(iB+1)-1) + oR*1.5*Math.cos((i-1)*45/180*3.1415926));})
                .attr("cy", function(d,i) {return ((h+oR)/3 + oR*1.5*Math.sin((i-1)*45/180*3.1415926));})
                .attr("cursor","pointer")
                .style("opacity",0.5)
                .style("fill", "#eee")
                .on("click", function(d,i) {
                    updateBarChart(d.groupName,d.groupColor);
                    updateLineChart(d.groupName,d.groupColor);
               })
            .on("mouseover", function(d,i) {
              var noteText = "";
              if (d.note == null || d.note == "") {
                noteText = d.groupName;
              } else {
                noteText = d.note;
              }
              d3.select("#bubbleItemNote").text(noteText);
              })
            .append("svg:title")
            .text(function(d) { return d.groupName; });   
 
            childBubbles.append("text")
                .attr("class", "childBubbleText" + iB)
                .attr("x", function(d,i) {return (oR*(3*(iB+1)-1) + oR*1.5*Math.cos((i-1)*45/180*3.1415926));})
                .attr("y", function(d,i) {return ((h+oR)/3 +        oR*1.5*Math.sin((i-1)*45/180*3.1415926));})
                .style("opacity",0.5)
                .attr("text-anchor", "middle")
            .style("fill", function(d,i) { return colVals(iB); })
                .attr("font-size", 6)
                .attr("cursor","pointer")
                .attr("dominant-baseline", "middle")
            .attr("alignment-baseline", "middle")
                .text(function(d) {return d.name})      
                .on("click", function(d,i) {
                 
                updateBarChart(d.groupName,d.groupColor);

                   updateLineChart(d.groupName,d.groupColor);



                }); 
 
        }
 
         
        }); 
 
    resetBubbles = function () {
      w = window.innerWidth*0.68*0.95;
      oR = w/(1+3*nTop);
       
      h = Math.ceil(w/nTop*2);
      svgContainer.style("height",h+"px");
 
      mainNote.attr("y",h-15);
           
      svg.attr("width", w);
      svg.attr("height",h);       
       
     
      var t = svg.transition()
          .duration(650);
         
        t.selectAll(".topBubble")
            .attr("r", function(d) { return oR; })
            .attr("cx", function(d, i) {return oR*(3*(1+i)-1);})
            .attr("cy", (h+oR)/3);
 
        t.selectAll(".topBubbleText")
        .attr("font-size", 30)
            .attr("x", function(d, i) {return oR*(3*(1+i)-1);})
            .attr("y", (h+oR)/3);
     
      for(var k = 0; k < nTop; k++) 
      {
        t.selectAll(".childBubbleText" + k)
                .attr("x", function(d,i) {return (oR*(3*(k+1)-1) + oR*1.5*Math.cos((i-1)*45/180*3.1415926));})
                .attr("y", function(d,i) {return ((h+oR)/3 +        oR*1.5*Math.sin((i-1)*45/180*3.1415926));})
            .attr("font-size", 6)
                .style("opacity",0.5);
 
        t.selectAll(".childBubble" + k)
                .attr("r",  function(d) {return oR/3.0;})
            .style("opacity",0.5)
                .attr("cx", function(d,i) {return (oR*(3*(k+1)-1) + oR*1.5*Math.cos((i-1)*45/180*3.1415926));})
                .attr("cy", function(d,i) {return ((h+oR)/3 +        oR*1.5*Math.sin((i-1)*45/180*3.1415926));});
                     
      }   
    }
         
         
        function activateBubble(d,i) {
            // increase this bubble and decrease others
            var t = svg.transition()
                .duration(d3.event.altKey ? 7500 : 350);
     
            t.selectAll(".topBubble")
                .attr("cx", function(d,ii){
                    if(i == ii) {
                        // Nothing to change
                        return oR*(3*(1+ii)-1) - 0.6*oR*(ii-1);
                    } else {
                        // Push away a little bit
                        if(ii < i){
                            // left side
                            return oR*0.6*(3*(1+ii)-1);
                        } else {
                            // right side
                            return oR*(nTop*3+1) - oR*0.6*(3*(nTop-ii)-1);
                        }
                    }               
                })
                .attr("r", function(d, ii) { 
                    if(i == ii)
                        return oR*1.8;
                    else
                        return oR*0.8;
                    });
                     
            t.selectAll(".topBubbleText")
                .attr("x", function(d,ii){
                    if(i == ii) {
                        // Nothing to change
                        return oR*(3*(1+ii)-1) - 0.6*oR*(ii-1);
                    } else {
                        // Push away a little bit
                        if(ii < i){
                            // left side
                            return oR*0.6*(3*(1+ii)-1);
                        } else {
                            // right side
                            return oR*(nTop*3+1) - oR*0.6*(3*(nTop-ii)-1);
                        }
                    }               
                })          
                .attr("font-size", function(d,ii){
                    if(i == ii)
                        return 30*1.5;
                    else
                        return 30*0.6;              
                });
     
            var signSide = -1;
            for(var k = 0; k < nTop; k++) 
            {
                signSide = 1;
                if(k < nTop/2) signSide = 1;
                t.selectAll(".childBubbleText" + k)
                    .attr("x", function(d,i) {return (oR*(3*(k+1)-1) - 0.6*oR*(k-1) + signSide*oR*2.5*Math.cos((i-1)*45/180*3.1415926));})
                    .attr("y", function(d,i) {return ((h+oR)/3 + signSide*oR*2.5*Math.sin((i-1)*45/180*3.1415926));})
                    .attr("font-size", function(){
                            return (k==i)?12:6;
                        })
                    .style("opacity",function(){
                            return (k==i)?1:0;
                        });
                     
                t.selectAll(".childBubble" + k)
                    .attr("cx", function(d,i) {return (oR*(3*(k+1)-1) - 0.6*oR*(k-1) + signSide*oR*2.5*Math.cos((i-1)*45/180*3.1415926));})
                    .attr("cy", function(d,i) {return ((h+oR)/3 + signSide*oR*2.5*Math.sin((i-1)*45/180*3.1415926));})
                    .attr("r", function(){
                            return (k==i)?(oR*0.55):(oR/3.0);               
                    })
                    .style("opacity", function(){
                            return (k==i)?1:0;                  
                        }); 
            }                   
        }
     
    window.onresize = resetBubbles;








 /*
  * formats
  */



var   formatAsPercentage = d3.format("%"),
    formatAsPercentage1Dec = d3.format(".1%"),
    formatAsInteger = d3.format(","),
    fsec = d3.time.format("%S s"),
    fmin = d3.time.format("%M m"),
    fhou = d3.time.format("%H h"),
    fwee = d3.time.format("%a"),
    fdat = d3.time.format("%d d"),
    fmon = d3.time.format("%b")
    ;



/*
 * bar chart
 */




var datasetBarChart = [

{ group: "All", category: "Oct 6th", measure: 1202  }, 
{ group: "All", category: "Oct 7th", measure: 1102 }, 
{ group: "All", category: "Oct 8th", measure: 982 }, 
{ group: "All", category: "Oct 9th", measure: 1116 }, 
{ group: "All", category: "Oct 10th", measure: 1024 }, 

{ group: "CIW.shift0", category: "Oct 6th", measure: 42 }, 
{ group: "CIW.shift0", category: "Oct 7th", measure: 44 }, 
{ group: "CIW.shift0", category: "Oct 8th", measure: 44 }, 
{ group: "CIW.shift0", category: "Oct 9th", measure: 49 }, 
{ group: "CIW.shift0", category: "Oct 10th", measure: 50 }, 

{ group: "CIW.shift7", category: "Oct 6th", measure: 0 }, 
{ group: "CIW.shift7", category: "Oct 7th", measure: 1 }, 
{ group: "CIW.shift7", category: "Oct 8th", measure: 0 }, 
{ group: "CIW.shift7", category: "Oct 9th", measure: 0 }, 
{ group: "CIW.shift7", category: "Oct 10th", measure: 0 },

{ group: "FCB.shift0", category: "Oct 6th", measure: 102 },
{ group: "FCB.shift0", category: "Oct 7th", measure: 109},
{ group: "FCB.shift0", category: "Oct 8th", measure: 53 },
{ group: "FCB.shift0", category: "Oct 9th", measure: 119},
{ group: "FCB.shift0", category: "Oct 10th", measure: 82},

{ group: "PNT.shift0", category: "Oct 6th", measure: 0},
{ group: "PNT.shift0", category: "Oct 7th", measure: 0},
{ group: "PNT.shift0", category: "Oct 8th", measure: 9},
{ group: "PNT.shift0", category: "Oct 9th", measure: 10},
{ group: "PNT.shift0", category: "Oct 10th", measure: 15},

{ group: "PCH.shift0", category: "Oct 6th", measure: 141},
{ group: "PCH.shift0", category: "Oct 7th", measure: 152},
{ group: "PCH.shift0", category: "Oct 8th", measure: 134},
{ group: "PCH.shift0", category: "Oct 9th", measure: 162},
{ group: "PCH.shift0", category: "Oct 10th", measure: 164},

{ group: "PCH.shift1", category: "Oct 6th", measure: 38},
{ group: "PCH.shift1", category: "Oct 7th", measure: 35},
{ group: "PCH.shift1", category: "Oct 8th", measure: 53},
{ group: "PCH.shift1", category: "Oct 9th", measure: 39},
{ group: "PCH.shift1", category: "Oct 10th", measure: 1},

{ group: "FCH.shift0", category: "Oct 6th", measure: 354},
{ group: "FCH.shift0", category: "Oct 7th", measure: 261},
{ group: "FCH.shift0", category: "Oct 8th", measure: 266},
{ group: "FCH.shift0", category: "Oct 9th", measure: 223},
{ group: "FCH.shift0", category: "Oct 10th", measure: 141},

{ group: "FCH.shift1", category: "Oct 6th", measure: 234},
{ group: "FCH.shift1", category: "Oct 7th", measure: 193},
{ group: "FCH.shift1", category: "Oct 8th", measure: 153},
{ group: "FCH.shift1", category: "Oct 9th", measure: 225},
{ group: "FCH.shift1", category: "Oct 10th", measure: 328},

{ group: "FCH.shift5", category: "Oct 6th", measure: 0},
{ group: "FCH.shift5", category: "Oct 7th", measure: 0},
{ group: "FCH.shift5", category: "Oct 8th", measure: 0},
{ group: "FCH.shift5", category: "Oct 9th", measure: 7},
{ group: "FCH.shift5", category: "Oct 10th", measure: 0},

{ group: "OFF.shift0", category: "Oct 6th", measure: 45},
{ group: "OFF.shift0", category: "Oct 7th", measure: 69},
{ group: "OFF.shift0", category: "Oct 8th", measure: 85},
{ group: "OFF.shift0", category: "Oct 9th", measure: 61},
{ group: "OFF.shift0", category: "Oct 10th", measure: 48},

{ group: "OFF.shift2", category: "Oct 6th", measure: 245},
{ group: "OFF.shift2", category: "Oct 7th", measure: 238},
{ group: "OFF.shift2", category: "Oct 8th", measure: 194},
{ group: "OFF.shift2", category: "Oct 9th", measure: 231},
{ group: "OFF.shift2", category: "Oct 10th", measure: 209},

{ group: "OFF.shift6", category: "Oct 6th", measure: 1},
{ group: "OFF.shift6", category: "Oct 7th", measure: 0},
{ group: "OFF.shift6", category: "Oct 8th", measure: 0},
{ group: "OFF.shift6", category: "Oct 9th", measure: 0},
{ group: "OFF.shift6", category: "Oct 10th", measure: 0}

]
;

// set initial group value
var group = "All";

function datasetBarChosen(group) {
  var ds = [];
  for (x in datasetBarChart) {
     if(datasetBarChart[x].group==group){
      ds.push(datasetBarChart[x]);
     } 
    }
  return ds;
}


function dsBarChartBasics() {

    var margin = {top: 30, right: 5, bottom: 20, left: 50},
    width = 500 - margin.left - margin.right,
     height = 250 - margin.top - margin.bottom,
    colorBar = d3.scale.category20(),
    barPadding = 1
    ;
    
    return {
      margin : margin, 
      width : width, 
      height : height, 
      colorBar : colorBar, 
      barPadding : barPadding
    }     
    ;
}

function dsBarChart() {

  var firstDatasetBarChart = datasetBarChosen(group);           
  
  var basics = dsBarChartBasics();
  
  var margin = basics.margin,
    width = basics.width,
     height = basics.height,
    colorBar = basics.colorBar,
    barPadding = basics.barPadding
    ;
          
  var   xScale = d3.scale.linear()
            .domain([0, firstDatasetBarChart.length])
            .range([0, width])
            ;
            

  var yScale = d3.scale.linear()
       .domain([0, d3.max(firstDatasetBarChart, function(d) { return d.measure; })])
       .range([height, 0])
       ;
  
  //Create SVG element
  
  var svg = d3.select("#barChart")
      .append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
        .attr("id","barChartPlot")
        ;
  
  var plot = svg
        .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
        ;
              
  plot.selectAll("rect")
       .data(firstDatasetBarChart)
       .enter()
       .append("rect")
      .attr("x", function(d, i) {
          return xScale(i);
      })
       .attr("width", width / firstDatasetBarChart.length - barPadding)   
      .attr("y", function(d) {
          return yScale(d.measure);
      })  
      .attr("height", function(d) {
          return height-yScale(d.measure);
      })
      .attr("fill", "lightgrey")
      ;
  
    
  // Add y labels to plot 
  
  plot.selectAll("text")
  .data(firstDatasetBarChart)
  .enter()
  .append("text")
  .text(function(d) {
      return formatAsInteger(d3.round(d.measure));
  })
  .attr("text-anchor", "middle")
  .attr("x", function(d, i) {
      return (i * (width / firstDatasetBarChart.length)) + ((width / firstDatasetBarChart.length - barPadding) / 2);
  })
  .attr("y", function(d) {
      return yScale(d.measure) + 14;
  })
  .attr("class", "yAxis")
 
  ;
  
  // Add x labels to chart  
  
  var xLabels = svg
        .append("g")
        .attr("transform", "translate(" + margin.left + "," + (margin.top + height)  + ")")
        ;
  
  xLabels.selectAll("text.xAxis")
      .data(firstDatasetBarChart)
      .enter()
      .append("text")
      .text(function(d) { return d.category;})
      .attr("text-anchor", "middle")
               .attr("x", function(d, i) {
                  return (i * (width / firstDatasetBarChart.length)) + ((width / firstDatasetBarChart.length - barPadding) / 2);
               })
      .attr("y", 15)
      .attr("class", "xAxis")
      ;     
   
  // Title
  
  svg.append("text")
    .attr("x", (width + margin.left + margin.right)/2)
    .attr("y", 15)
    .attr("class","title")        
    .attr("text-anchor", "middle")
    .text("Overall Defects")
    ;
}

dsBarChart();

 
/* updates bar chart on request */

function updateBarChart(group, colorChosen) {
  
    var currentDatasetBarChart = datasetBarChosen(group);
    
    var basics = dsBarChartBasics();
  
    var margin = basics.margin,
      width = basics.width,
       height = basics.height,
      colorBar = basics.colorBar,
      barPadding = basics.barPadding
      ;
    
    var   xScale = d3.scale.linear()
      .domain([0, currentDatasetBarChart.length])
      .range([0, width])
      ;
    
      
    var yScale = d3.scale.linear()
        .domain([0, d3.max(currentDatasetBarChart, function(d) { return d.measure; })])
        .range([height,0])
        ;
        
     var svg = d3.select("#barChart svg");
        
     var plot = d3.select("#barChartPlot")
      .datum(currentDatasetBarChart)
       ;
  
  
      plot.selectAll("rect")
        .data(currentDatasetBarChart)
        .transition()
      .duration(750)
      .attr("x", function(d, i) {
          return xScale(i);
      })
       .attr("width", width / currentDatasetBarChart.length - barPadding)   
      .attr("y", function(d) {
          return yScale(d.measure);
      })  
      .attr("height", function(d) {
          return height-yScale(d.measure);
      })
      .attr("fill", colorChosen)
      ;
    
    plot.selectAll("text.yAxis") // target the text element(s) which has a yAxis class defined
      .data(currentDatasetBarChart)
      .transition()
      .duration(750)
       .attr("text-anchor", "middle")
       .attr("x", function(d, i) {
          return (i * (width / currentDatasetBarChart.length)) + ((width / currentDatasetBarChart.length - barPadding) / 2);
       })
       .attr("y", function(d) {
          return yScale(d.measure) + 14;
       })
       .text(function(d) {
        return formatAsInteger(d3.round(d.measure));
       })
       .attr("class", "yAxis")           
    ;
    

    svg.selectAll("text.title") // target the text element(s) which has a title class defined
      .attr("x", (width + margin.left + margin.right)/2)
      .attr("y", 15)
      .attr("class","title")        
      .attr("text-anchor", "middle")
      .text(group + "'s Defects from oct 6th to 10th")
    ;
}






/*
 *line chart
 */

var datasetLineChart = [

{ group: "All", category: "Oct 6th", measure: 389  }, 
{ group: "All", category: "Oct 7th", measure: 306 }, 
{ group: "All", category: "Oct 8th", measure: 332 }, 
{ group: "All", category: "Oct 9th", measure: 387 }, 
{ group: "All", category: "Oct 10th", measure: 353 }, 

{ group: "CIW.shift0", category: "Oct 6th", measure: 11 }, 
{ group: "CIW.shift0", category: "Oct 7th", measure: 12 }, 
{ group: "CIW.shift0", category: "Oct 8th", measure: 14 }, 
{ group: "CIW.shift0", category: "Oct 9th", measure: 16 }, 
{ group: "CIW.shift0", category: "Oct 10th", measure: 16 }, 

{ group: "CIW.shift7", category: "Oct 6th", measure: 0 }, 
{ group: "CIW.shift7", category: "Oct 7th", measure: 1 }, 
{ group: "CIW.shift7", category: "Oct 8th", measure: 0 }, 
{ group: "CIW.shift7", category: "Oct 9th", measure: 0 }, 
{ group: "CIW.shift7", category: "Oct 10th", measure: 0 },

{ group: "FCB.shift0", category: "Oct 6th", measure: 65 },
{ group: "FCB.shift0", category: "Oct 7th", measure: 70},
{ group: "FCB.shift0", category: "Oct 8th", measure: 43 },
{ group: "FCB.shift0", category: "Oct 9th", measure: 77},
{ group: "FCB.shift0", category: "Oct 10th", measure: 55},

{ group: "PNT.shift0", category: "Oct 6th", measure: 0},
{ group: "PNT.shift0", category: "Oct 7th", measure: 0},
{ group: "PNT.shift0", category: "Oct 8th", measure: 5},
{ group: "PNT.shift0", category: "Oct 9th", measure: 8},
{ group: "PNT.shift0", category: "Oct 10th", measure: 10},

{ group: "PCH.shift0", category: "Oct 6th", measure: 55},
{ group: "PCH.shift0", category: "Oct 7th", measure: 51},
{ group: "PCH.shift0", category: "Oct 8th", measure: 53},
{ group: "PCH.shift0", category: "Oct 9th", measure: 52},
{ group: "PCH.shift0", category: "Oct 10th", measure: 57},

{ group: "PCH.shift1", category: "Oct 6th", measure: 30},
{ group: "PCH.shift1", category: "Oct 7th", measure: 24},
{ group: "PCH.shift1", category: "Oct 8th", measure: 28},
{ group: "PCH.shift1", category: "Oct 9th", measure: 27},
{ group: "PCH.shift1", category: "Oct 10th", measure: 1},

{ group: "FCH.shift0", category: "Oct 6th", measure: 59},
{ group: "FCH.shift0", category: "Oct 7th", measure: 48},
{ group: "FCH.shift0", category: "Oct 8th", measure: 41},
{ group: "FCH.shift0", category: "Oct 9th", measure: 51},
{ group: "FCH.shift0", category: "Oct 10th", measure: 43},

{ group: "FCH.shift1", category: "Oct 6th", measure: 88},
{ group: "FCH.shift1", category: "Oct 7th", measure: 73},
{ group: "FCH.shift1", category: "Oct 8th", measure: 75},
{ group: "FCH.shift1", category: "Oct 9th", measure: 75},
{ group: "FCH.shift1", category: "Oct 10th", measure: 89},

{ group: "FCH.shift5", category: "Oct 6th", measure: 0},
{ group: "FCH.shift5", category: "Oct 7th", measure: 0},
{ group: "FCH.shift5", category: "Oct 8th", measure: 0},
{ group: "FCH.shift5", category: "Oct 9th", measure: 2},
{ group: "FCH.shift5", category: "Oct 10th", measure: 0},

{ group: "OFF.shift0", category: "Oct 6th", measure: 14},
{ group: "OFF.shift0", category: "Oct 7th", measure: 18},
{ group: "OFF.shift0", category: "Oct 8th", measure: 19},
{ group: "OFF.shift0", category: "Oct 9th", measure: 18},
{ group: "OFF.shift0", category: "Oct 10th", measure: 15},

{ group: "OFF.shift2", category: "Oct 6th", measure: 66},
{ group: "OFF.shift2", category: "Oct 7th", measure: 9},
{ group: "OFF.shift2", category: "Oct 8th", measure: 54},
{ group: "OFF.shift2", category: "Oct 9th", measure: 61},
{ group: "OFF.shift2", category: "Oct 10th", measure: 67},

{ group: "OFF.shift6", category: "Oct 6th", measure: 1},
{ group: "OFF.shift6", category: "Oct 7th", measure: 0},
{ group: "OFF.shift6", category: "Oct 8th", measure: 0},
{ group: "OFF.shift6", category: "Oct 9th", measure: 0},
{ group: "OFF.shift6", category: "Oct 10th", measure: 0}
]
;
// set initial category value
var group = "All";

function datasetLineChartChosen(group) {
  var ds = [];
  for (x in datasetLineChart) {
     if(datasetLineChart[x].group==group){
      ds.push(datasetLineChart[x]);
     } 
    }
  return ds;
}

function dsLineChartBasics() {

  var margin = {top: 20, right: 10, bottom: 15, left: 50},
      width = 500 - margin.left - margin.right,
      height = 150 - margin.top - margin.bottom
      ;
    
    return {
      margin : margin, 
      width : width, 
      height : height
    }     
    ;
}


function dsLineChart() {

  var firstDatasetLineChart = datasetLineChartChosen(group);    
  
  var basics = dsLineChartBasics();
  
  var margin = basics.margin,
    width = basics.width,
     height = basics.height
    ;

  var xScale = d3.scale.linear()
      .domain([0, firstDatasetLineChart.length-1])
      .range([0, width])
      ;

  var yScale = d3.scale.linear()
      .domain([0, d3.max(firstDatasetLineChart, function(d) { return d.measure; })])
      .range([height, 0])
      ;
  
  var line = d3.svg.line()
      .x(function(d, i) { return xScale(i); })
      .y(function(d) { return yScale(d.measure); })
      ;
  
  var svg = d3.select("#lineChart").append("svg")
      .datum(firstDatasetLineChart)
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
      // create group and move it so that margins are respected (space for axis and title)
      
  var plot = svg
      .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
      .attr("id", "lineChartPlot")
      ;

  
 
  var totalnumberofCARs = d3.sum(firstDatasetLineChart, function(d) { return d.measure; })
  plot.append("text")
    .text(totalnumberofCARs)
    .attr("id","lineChartTitle2")
    .attr("x",width/2)
    .attr("y",height/2) 
    ;
 
  plot.append("path")
      .attr("class", "line")
      .attr("d", line)  
    .attr("stroke", "lightgrey")
      ;
    
  plot.selectAll(".dot")
      .data(firstDatasetLineChart)
       .enter().append("circle")
      .attr("class", "dot")
      .attr("fill", function (d) { return d.measure==d3.min(firstDatasetLineChart, function(d) { return d.measure; }) ? "red" : (d.measure==d3.max(firstDatasetLineChart, function(d) { return d.measure; }) ? "green" : "white") } )
      .attr("cx", line.x())
      .attr("cy", line.y())
      .attr("r", 3.5)
      .attr("stroke", "lightgrey")
      .append("title")
      .text(function(d) { return d.category + ": " + formatAsInteger(d.measure); })
      ;

  svg.append("text")
    .text("Number of Trucks with Defects")
    .attr("id","lineChartTitle1") 
    .attr("x",margin.left + ((width + margin.right)/2))
    .attr("y", 10)
    ;

 var vis = d3.select("#visualisation"),
    WIDTH = basics.width,
   HEIGHT = basics.height+36,
    MARGINS =  {top: 20, right: 10, bottom: 5, left: 150},
   
      
    yRange = d3.scale.linear().range([HEIGHT - MARGINS.top, MARGINS.bottom]).domain([d3.min(firstDatasetLineChart, function (d) {
      console.log("d.measure value" + d.measure);
        return d.measure;
      }),
      d3.max(firstDatasetLineChart, function (d) {
        return d.measure;
      })
    ]),


   
  
    yAxis = d3.svg.axis()
      .scale(yRange)
      .tickSize(5)
      .orient("left")
      .tickSubdivide(true);

   

   console.log("yrange value " + yRange);

   
   vis.append("svg:g")
   .attr("class", "y axis")
  .attr("transform", "translate(" + (MARGINS.left) + ",0)")
  .call(yAxis);






    

}

dsLineChart();



 
/* updates bar chart on request */
function updateLineChart(group, colorChosen) {

  var currentDatasetLineChart = datasetLineChartChosen(group);   

  var basics = dsLineChartBasics();
  
  var margin = basics.margin,
    width = basics.width,
     height = basics.height
    ;

  var xScale = d3.scale.linear()
      .domain([0, currentDatasetLineChart.length-1])
      .range([0, width])
      ;

  var yScale = d3.scale.linear()
      .domain([0, d3.max(currentDatasetLineChart, function(d) { return d.measure; })])
      .range([height, 0])
      ;
  
  var line = d3.svg.line()
    .x(function(d, i) { return xScale(i); })
    .y(function(d) { return yScale(d.measure); })
    ;

   var plot = d3.select("#lineChartPlot")
    .datum(currentDatasetLineChart)
     ;
     
  /* descriptive titles as part of plot -- start */
  
  
  var totalnumberofCARs = d3.sum(currentDatasetLineChart, function(d) { return d.measure; })

  plot.select("text")
    .text(totalnumberofCARs)
    ;
  /* descriptive titles -- end */
     
  plot
  .select("path")
    .transition()
    .duration(750)          
     .attr("class", "line")
     .attr("d", line) 
     // add color
    .attr("stroke", colorChosen)
     ;
     
  var path = plot
    .selectAll(".dot")
     .data(currentDatasetLineChart)
     .transition()
    .duration(750)
     .attr("class", "dot")
     .attr("fill", function (d) { return d.measure==d3.min(currentDatasetLineChart, function(d) { return d.measure; }) ? "red" : (d.measure==d3.max(currentDatasetLineChart, function(d) {
         return d.measure; }) ? "green" : "white") } )
     .attr("cx", line.x())
     .attr("cy", line.y())
     .attr("r", 3.5)
     // add color
    .attr("stroke", colorChosen)
     ;

     if(d3.svg.axis()!=null){

      $("#visualisation").empty();
     }
     var vis = d3.select("#visualisation"),
    WIDTH = basics.width,
    HEIGHT = basics.height+36,
    MARGINS =  {top: 20, right: 10, bottom: 5, left: 150},
   
      
    yRange = d3.scale.linear().range([HEIGHT - MARGINS.top, MARGINS.bottom]).domain([d3.min(currentDatasetLineChart, function (d) {
      console.log("d.measure value" + d.measure);
        return d.measure;
      }),
      d3.max(currentDatasetLineChart, function (d) {
        return d.measure;
      })
    ]),

    yAxis = d3.svg.axis()
      .scale(yRange)
      .tickSize(5)
      .orient("left")
      .tickSubdivide(true);

   vis.append("svg:g")
   .attr("class", "y axis")
  .attr("transform", "translate(" + (MARGINS.left) + ",0)")
  .call(yAxis);

}

</script>
 </html>
 