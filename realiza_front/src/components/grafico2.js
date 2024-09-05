import React from 'react';
import { Pie } from 'react-chartjs-2';
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from 'chart.js';
import { data2, options2 } from '../data/data'; // Importar data2 y options2 desde data.js

// Registrar los componentes necesarios
ChartJS.register(ArcElement, Tooltip, Legend);

const Grafico2 = () => {
  const donutData = {
    ...data2,
    datasets: data2.datasets.map(dataset => ({
      ...dataset,
      // Cambia el valor de `type` a `doughnut`
      type: 'doughnut'
    })),
  };

  return (
    <div className="relative">
      <h1 className="text-l text-gray-800 mb-4 text-center mt-2">Huella de Carbono por Alcance resumen Global</h1>
      <div className="w-full h-80 flex items-center justify-center">
        <Pie data={donutData} options={options2} />
      </div>

    </div>
  );
};

export default Grafico2;
