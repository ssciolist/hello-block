import Chart from 'chart.js';

let residential = document.getElementById("resConstruction");
let resChart = new Chart(residential, {
    type: 'line',
    data: {
        labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
        datasets: [{
            label: 'Planned construction value',
            data: [12, 19, 3, 5, 2, 3],
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
          fontSize: 25,
          fontFamily: 'Helvetica',
        },
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true,
                },
                scaleLabel: {
                  display: true,
                  labelString: "Thousands of dollars"
                }
            }]
        }
    }
});

let commercial = document.getElementById("commConstruction");
let commChart = new Chart(commercial, {
    type: 'line',
    data: {
        labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
        datasets: [{
            label: 'Total value of planned construction',
            data: [12, 19, 3, 5, 2, 3],
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
        fontSize: 25,
        fontFamily: 'Helvetica',
      },
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                },
                scaleLabel: {
                  display: true,
                  labelString: "Thousands of dollars"
                }
            }]
        }
    }
});
