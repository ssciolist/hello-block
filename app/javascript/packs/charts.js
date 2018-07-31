import Chart from 'chart.js';

$(document).ready(function(){
  drawResChart();
  drawCommChart();
  drawTopHoodChart();
})


let residential = document.getElementById("resConstruction");

function drawResChart() {
  return fetch(`https://hello-block.herokuapp.com/api/v1/building_permits/summarize?class=RESCON&years=2015,2016,2017,2018&group=years`)
  .then((response) => response.json())
  .then((rawData) => {
    resChart.data.datasets[0].data = [rawData['2015'], rawData['2016'], rawData['2017'], rawData['2018']]
    resChart.update()
  })
}

let resChart = new Chart(residential, {
    type: 'line',
    data: {
        labels: ["2015", "2016", "2017", "2018 (so far)"],
        datasets: [{
            label: 'Planned construction value',
            data: [],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        title: {
          display: true,
          text: 'Residential Construction Planned in Denver',
          fontSize: 18,
          fontFamily: 'Helvetica',
        },
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true,
                },
                scaleLabel: {
                  display: true,
                  labelString: "Dollars"
                }
            }]
        }
    }
});


let commercial = document.getElementById("commConstruction");

function drawCommChart() {
  return fetch(`https://hello-block.herokuapp.com/api/v1/building_permits/summarize?class=COMMCON&years=2015,2016,2017,2018&group=years`)
  .then((response) => response.json())
  .then((rawData) => {
    commChart.data.datasets[0].data = [rawData['2015'], rawData['2016'], rawData['2017'], rawData['2018']]
    commChart.update()
  })
}

let commChart = new Chart(commercial, {
    type: 'line',
    data: {
        labels: ["2015", "2016", "2017", "2018 (so far)"],
        datasets: [{
            label: 'Total value of planned construction',
            data: [],
            backgroundColor: [
                'rgba(54, 162, 235, 0.2)'
            ],
            borderColor: [
                'rgba(54, 162, 235, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
      responsive: true,
      title: {
        display: true,
        text: 'Commercial Construction Planned in Denver',
        fontSize: 18,
        fontFamily: 'Helvetica',
      },
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:false
                },
                scaleLabel: {
                  display: true,
                  labelString: "Dollars"
                }
            }]
        }
    }
});

let topHoods = document.getElementById("topHoods");


// This would be the fetch call to get dynamic data
function drawTopHoodChart() {
  return fetch(`http://localhost:3000/api/v1/building_permits/neighborhoods/annual_percentage?years=2015,2016,2017,2018`)
  .then((response) => response.json())
  .then((rawData) => {
    stackedBar.data.labels = Object.keys(rawData).slice(0,9)
    stackedBar.data.datasets[0].data = Object.values(rawData).slice(0,9)
    stackedBar.update()
  })
}

var stackedBar = new Chart(topHoods, {
    type: 'horizontalBar',
    data: {
      labels: [],
      datasets: [{
          label: "Average annual growth rate (percent)",
          backgroundColor: "#3e95cd",
          data: []
        }]
      },
    options: {
      maintainAspectRatio: false,
    }
});
