import React from 'react';
import { datoglobal } from '../data/data'; // Importa los datos

const DatoGlobal = () => {
  // Extraemos el dato global del objeto de datos
  const totalEmisiones = datoglobal.datasets[0].data[0];

  return (
    <div className="w-full h-80 flex items-center justify-center">
      <div className="w-full max-w-[400px] h-full text-center">
        <h1 className="text-xl text-gray-800 mb-4 mt-2">
          Huella de Carbono total Global
        </h1>
        <div className="text-5xl font-bold text-blue-700">
          {totalEmisiones} tCO2e
        </div>
      </div>
    </div>
  );
};

export default DatoGlobal;
