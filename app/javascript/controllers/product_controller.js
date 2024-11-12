import { Controller } from "@hotwired/stimulus"
import {Chart, registerables } from 'chart.js'

Chart.register(...registerables)

// Connects to data-controller="product"
export default class extends Controller {
  static values = { history: Array }

  initialize() {
    const uniqueDataByDay = Object.values(
    this.historyValue.reduce((acc, entry) => {
        // Convertimos `updated_at` solo a la fecha para agrupar por día
        const date = new Date(entry.updated_at).toLocaleDateString();

        // Si el día no está en el acumulador o si el precio del nuevo registro es mayor, actualizamos
        if (!acc[date] || entry.price > acc[date].price) {
            acc[date] = entry;
        }

        return acc;
    }, {})
    );

    // Ahora `uniqueDataByDay` contiene solo un registro por día con el precio más alto de ese día
    const data = uniqueDataByDay.map(entry => entry.price);
    const labels = uniqueDataByDay.map(entry => new Date(entry.updated_at).toLocaleDateString());
    console.log(data, labels);

    const ctx = document.getElementById('productChart')

    new Chart(ctx, {
      type: 'line',
      data: {
        labels: labels,
        datasets: [{
          label: 'Precio $',
          data: data,
          borderWidth: 3,
          fill: true
        }]
      },
      options: {
        plugins: {
          legend: {
            display: false
          }
        },
        scales: {
          x: {
            grid: {
              display: false
            }
          },
          y: {
            border: {
              dash: [5, 5]
            },
            grid: {
              color: "#d4f3ef"
            },
            beginAtZero: true
          }
        }
      }
    })
  }
}