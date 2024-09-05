import React from 'react';
import { datoporsede } from '../data/data'; // Importa los datos

const DatoporSede = () => {
  // Extraemos el dato global del objeto de datos
  const totalEmisiones = datoporsede.datasets[0].data[0];

  return (
    <div className="w-full h-80 flex items-center justify-center">
      <div className="w-full max-w-[400px] h-full text-center">
        <h1 className="text-xl text-gray-800 mb-4 mt-2">
          Huella de Carbono total por sede
        </h1>
        <div className="text-5xl font-bold text-blue-700">
          {totalEmisiones} tCO2e
        </div>
      </div>
    </div>
  );
};

export default DatoporSede;
