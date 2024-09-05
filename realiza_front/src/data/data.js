// src/data/data.js

export const datoglobal = {
    labels: ['Total Huella de carbono'],
    datasets: [
      {
        label: 'Emisiones de GEI [tCO2e]',
        backgroundColor: '#2F74BA',
        borderColor: '#DDEAF3',
        borderWidth: 0,
        hoverBackgroundColor: '#DDEAF3',
        hoverBorderColor: 'rgba(75,192,192,1)',
        data: [18.640], // Este es el dato global que se mostrará
      },
    ],
};
  
export const datoporsede = {
  labels: ['Total Huella de carbono'],
  datasets: [
    {
      label: 'Emisiones de GEI [tCO2e]',
      backgroundColor: '#2F74BA',
      borderColor: '#DDEAF3',
      borderWidth: 0,
      hoverBackgroundColor: '#DDEAF3',
      hoverBorderColor: 'rgba(75,192,192,1)',
      data: [18.640], // Este es el dato global que se mostrará
    },
  ],
};


export const data1 = {
    labels: [
      'Fuente 1', 'Fuente 2', 'Fuente 3', 'Fuente 4',
      'Fuente 5', 'Fuente 6', 'Fuente 7', 'Fuente 8',
      'Fuente 9', 'Fuente 10', 'Fuente 11', 'Fuente 12'
    ],
    datasets: [
      {
        label: 'Emisiones de GEI [tCO2e] ',
        backgroundColor: '#2F74BA',
        borderColor: '#DDEAF3',
        borderWidth: 0,
        hoverBackgroundColor: '#DDEAF3',
        hoverBorderColor: 'rgba(75,192,192,1)',
        data: [
          7.64, 35.00, 46.00, 67.84,
          85.00, 304.49, 7641.00, 10393.00,
          202627.00, 490575.00, 690270.00, 1180845.00
        ],
      },
    ],
  };
  
  export const options1 = {
    indexAxis: 'y', // Configura el gráfico para ser horizontal
    scales: {
      x: {
        beginAtZero: true,
      },
      y: {
        beginAtZero: true,
        ticks: {
          autoSkip: false,
          maxRotation: 0,
          minRotation: 0
        }
      },
    },
  };
  

  export const data2 = {
    labels: ['Alcance 1', 'Alcance 2', 'Alcance 3'],
    datasets: [
      {
        label: 'Example Dataset',
        data: [10, 20, 30],
        backgroundColor: ['#2F74BA', '#688D2D', '#DDEAF3'],
        borderColor: ['#2F74BA', '#688D2D', '#DDEAF3'],
        borderWidth: 0,
      },
    ],
  };
  
  export const options2 = {
    responsive: true,
    plugins: {
      legend: {
        position: 'top',
      },
      tooltip: {
        callbacks: {
          label: function(context) {
            let label = context.dataset.label || '';
            if (context.label) {
              label += `: ${context.raw}`;
            }
            return label;
          }
        }
      }
    },
    elements: {
      arc: {
        borderWidth: 2,
      },
    },
  };
  

  export const data3 = {
    labels: [
      'Fuente 1', 'Fuente 2', 'Fuente 3', 'Fuente 4',
      'Fuente 5', 'Fuente 6', 'Fuente 7', 'Fuente 8',
      'Fuente 9', 'Fuente 10', 'Fuente 11', 'Fuente 12'
    ],
    datasets: [
      {
        label: 'Emisiones de GEI [tCO2e] ',
        backgroundColor: '#2F74BA',
        borderColor: '#DDEAF3',
        borderWidth: 0,
        hoverBackgroundColor: '#DDEAF3',
        hoverBorderColor: 'rgba(75,192,192,1)',
        data: [
          7.64, 35.00, 46.00, 67.84,
          85.00, 304.49, 7641.00, 10393.00,
          202627.00, 490575.00, 690270.00, 1180845.00
        ],
      },
    ],
  };
  
  export const options3 = {
    indexAxis: 'y', // Configura el gráfico para ser horizontal
    scales: {
      x: {
        beginAtZero: true,
      },
      y: {
        beginAtZero: true,
        ticks: {
          autoSkip: false,
          maxRotation: 0,
          minRotation: 0
        }
      },
    },
  };
  

  export const data4 = {
    labels: ['Alcance 1', 'Alcance 2', 'Alcance 3'],
    datasets: [
      {
        label: 'Example Dataset',
        data: [10, 20, 30],
        backgroundColor: ['#2F74BA', '#688D2D', '#DDEAF3'],
        borderColor: ['#2F74BA', '#688D2D', '#DDEAF3'],
        borderWidth: 0,
      },
    ],
  };
  
  export const options4 = {
    responsive: true,
    plugins: {
      legend: {
        position: 'top',
      },
      tooltip: {
        callbacks: {
          label: function(context) {
            let label = context.dataset.label || '';
            if (context.label) {
              label += `: ${context.raw}`;
            }
            return label;
          }
        }
      }
    },
    elements: {
      arc: {
        borderWidth: 2,
      },
    },
  };
  