import React, { useState } from 'react';
import Grafico1 from '../components/grafico1';
import Grafico2 from '../components/grafico2';
import Grafico3 from '../components/grafico3';
import Grafico4 from '../components/grafico4';
import DatosHistoricos from '../components/datoshistoricos';
import CargaDeInformacion from '../components/cargadeinformacion';
import DatoGlobal from '../components/datoglobal';
import { FaChartLine, FaHistory, FaFileImport, FaChevronDown, FaChevronUp } from 'react-icons/fa'; // Importar íconos
import DatoporSede from '../components/datoporsede';

const PanelInformacion = () => {
  const [isDashboardOpen, setIsDashboardOpen] = useState(false);
  const [isDatosHistoricosOpen, setIsDatosHistoricosOpen] = useState(false);
  const [isCargaInformacionOpen, setIsCargaInformacionOpen] = useState(false);

  return (
    <div className="p-6 space-y-6">
      <h1 className="text-3xl font-bold mb-4">Panel de Información</h1> {/* Título principal */}
      <div>
        <h2
          className="text-2xl font-semibold flex items-center space-x-2 cursor-pointer"
          onClick={() => setIsDashboardOpen(!isDashboardOpen)}
        >
          <FaChartLine className="text-blue-500" /> {/* icono */}
          <span>Dashboard Huella de Carbono</span>
          {isDashboardOpen ? <FaChevronUp className="ml-2" /> : <FaChevronDown className="ml-2" />} {/* Menú desplegable */}
        </h2>
        {isDashboardOpen && (
          <>
            <h3 className="text-xl mt-4 mb-2">Datos globales</h3>
            <div className="grid grid-cols-3 gap-4 mt-4">
              <div className="bg-white rounded-lg shadow-lg p-4">
                <DatoGlobal />
              </div>
              <div className="bg-white rounded-lg shadow-lg p-4">
                <Grafico1 />
              </div>
              <div className="bg-white rounded-lg shadow-lg p-4">
                <Grafico2 />
              </div>
            </div>
            <h3 className="text-xl mt-4 mb-2">Datos por sede</h3>
            <div className="mb-4">
                <select className="block w-full p-2 border rounded text-black">
                    <option value="">Selecciona una sede</option>
                    <option value="sede1">Sede 1</option>
                    <option value="sede2">Sede 2</option>
                    <option value="sede3">Sede 3</option>
                    <option value="sede4">Sede 4</option>
                </select>
            </div>
              <div className="grid grid-cols-3 gap-4 mt-4">
              <div className="bg-white rounded-lg shadow-lg p-4">
                <DatoporSede />
              </div>
              <div className="bg-white rounded-lg shadow-lg p-4 mt-4">
                <Grafico3 />
              </div>
              <div className="bg-white rounded-lg shadow-lg p-4">
                <Grafico4 />
              </div>
            </div>

          </>
        )}
      </div>

      <div>
        <h2
          className="text-2xl font-semibold flex items-center space-x-2 cursor-pointer"
          onClick={() => setIsDatosHistoricosOpen(!isDatosHistoricosOpen)}
        >
          <FaHistory className="text-green-500" /> {/* icono */}
          <span>Datos históricos</span>
          {isDatosHistoricosOpen ? <FaChevronUp className="ml-2" /> : <FaChevronDown className="ml-2" />} {/* Menú desplegable */}
        </h2>
        {isDatosHistoricosOpen && (
          <div className="bg-white rounded-lg shadow-lg p-4 mt-4">
            <DatosHistoricos />
          </div>
        )}
      </div>

      <div>
        <h2
          className="text-2xl font-semibold flex items-center space-x-2 cursor-pointer"
          onClick={() => setIsCargaInformacionOpen(!isCargaInformacionOpen)}
        >
          <FaFileImport className="text-red-500" /> {/* icono */}
          <span>Carga de información</span>
          {isCargaInformacionOpen ? <FaChevronUp className="ml-2" /> : <FaChevronDown className="ml-2" />} {/* Menú desplegable */}
        </h2>
        {isCargaInformacionOpen && (
          <div className="bg-white rounded-lg shadow-lg p-4 mt-4">
            <CargaDeInformacion />
          </div>
        )}
      </div>
    </div>
  );
};

export default PanelInformacion;
