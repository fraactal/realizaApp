import React from 'react';
import { Bar } from 'react-chartjs-2';
import { Chart as ChartJS, CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend } from 'chart.js';
import { data3, options3 } from '../data/data'; // Importa los datos

ChartJS.register(CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend);

const Grafico3 = () => {
  return (
    <div className="w-full h-80 flex items-center justify-center">
      <div className="w-full max-w-[400px] h-full">
        <h1 className="text-l text-gray-800 mb-4 text-center mt-2">
          Huella de Carbono por fuente de emisión resumen por sede
        </h1>
        <div className="w-full h-full">
          <Bar data={data3} options={options3} className="w-full h-full" />
        </div>
      </div>
    </div>
  );
};

export default Grafico3;