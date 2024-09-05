import React from 'react';
import { Pie } from 'react-chartjs-2';
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from 'chart.js';
import { data4, options4 } from '../data/data'; // Importar data2 y options2 desde data.js

// Registrar los componentes necesarios
ChartJS.register(ArcElement, Tooltip, Legend);

const Grafico4 = () => {
  const donutData = {
    ...data4,
    datasets: data4.datasets.map(dataset => ({
      ...dataset,
      // Cambia el valor de `type` a `doughnut`
      type: 'doughnut'
    })),
  };

  return (
    <div className="relative">
      <h1 className="text-l text-gray-800 mb-4 text-center mt-2">Huella de Carbono por Alcance resumen Global</h1>
      <div className="w-full h-80 flex items-center justify-center">
        <Pie data={donutData} options={options4} />
      </div>

    </div>
  );
};

export default Grafico4;
