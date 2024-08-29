import React from 'react';

const Recursos = () => {
  return (
    <div className="p-6 space-y-6">
      <h1 className="text-3xl font-bold mb-4">Recursos</h1>
      
      {/* Subtítulo y párrafo introductorio */}
      <section>
        <h2 className="text-2xl font-semibold mb-2">Bienvenido a la Sección de Recursos</h2>
        <p className="text-gray-700">
          En esta sección encontrarás una variedad de materiales y herramientas que pueden ayudarte a comprender y mejorar tu experiencia en sostenibilidad y acción climática. Nuestro objetivo es proporcionar recursos útiles y accesibles para todos.
        </p>
      </section>

      {/* Subtítulo y contenido de recurso 1 */}
      <section>
        <h2 className="text-2xl font-semibold mb-2">Guías y Manuales</h2>
        <p className="text-gray-700">
          Aquí puedes encontrar guías y manuales detallados que cubren diferentes aspectos de la sostenibilidad. Estos documentos están diseñados para proporcionar instrucciones paso a paso y consejos prácticos para implementar prácticas sostenibles en tu organización.
        </p>
        <ul className="list-disc list-inside text-gray-700">
          <li><a href="#" className="text-blue-500 hover:underline">Guía de Implementación de Energías Renovables</a></li>
          <li><a href="#" className="text-blue-500 hover:underline">Manual de Eficiencia Energética</a></li>
          <li><a href="#" className="text-blue-500 hover:underline">Guía para la Reducción de Residuos</a></li>
        </ul>
      </section>

      {/* Subtítulo y contenido de recurso 2 */}
      <section>
        <h2 className="text-2xl font-semibold mb-2">Videos y Webinars</h2>
        <p className="text-gray-700">
          Explora nuestra colección de videos y webinars que abordan varios temas relacionados con la sostenibilidad. Estos recursos visuales te ayudarán a entender conceptos complejos de manera más sencilla y atractiva.
        </p>
        <ul className="list-disc list-inside text-gray-700">
          <li><a href="#" className="text-blue-500 hover:underline">Webinar sobre Economía Circular</a></li>
          <li><a href="#" className="text-blue-500 hover:underline">Video: La Importancia del Reciclaje</a></li>
          <li><a href="#" className="text-blue-500 hover:underline">Seminario en Línea: Cambio Climático y su Impacto</a></li>
        </ul>
      </section>

      {/* Subtítulo y contenido de recurso 3 */}
      <section>
        <h2 className="text-2xl font-semibold mb-2">Artículos y Publicaciones</h2>
        <p className="text-gray-700">
          Lee artículos y publicaciones de expertos en el campo de la sostenibilidad. Estos documentos te proporcionarán conocimientos y perspectivas valiosas sobre las últimas tendencias y avances en la acción climática.
        </p>
        <ul className="list-disc list-inside text-gray-700">
          <li><a href="#" className="text-blue-500 hover:underline">Artículo: Innovaciones en Energía Verde</a></li>
          <li><a href="#" className="text-blue-500 hover:underline">Publicación: Políticas de Sostenibilidad en el Siglo XXI</a></li>
          <li><a href="#" className="text-blue-500 hover:underline">Artículo: Cómo Reducir tu Huella de Carbono</a></li>
        </ul>
      </section>

      {/* Subtítulo y contenido de recurso 4 */}
      <section>
        <h2 className="text-2xl font-semibold mb-2">Herramientas Interactivas</h2>
        <p className="text-gray-700">
          Utiliza nuestras herramientas interactivas para calcular tu huella de carbono, simular escenarios de reducción de emisiones, y mucho más. Estas herramientas están diseñadas para ayudarte a tomar decisiones informadas y efectivas.
        </p>
        <ul className="list-disc list-inside text-gray-700">
          <li><a href="#" className="text-blue-500 hover:underline">Calculadora de Huella de Carbono</a></li>
          <li><a href="#" className="text-blue-500 hover:underline">Simulador de Energía Renovable</a></li>
          <li><a href="#" className="text-blue-500 hover:underline">Herramienta de Evaluación de Eficiencia</a></li>
        </ul>
      </section>

      {/* Subtítulo y contenido de recurso 5 */}
      <section>
        <h2 className="text-2xl font-semibold mb-2">Enlaces Útiles</h2>
        <p className="text-gray-700">
          Descubre una lista de enlaces útiles a sitios web, organizaciones y plataformas que ofrecen información y recursos adicionales sobre sostenibilidad y acción climática.
        </p>
        <ul className="list-disc list-inside text-gray-700">
          <li><a href="https://www.un.org/es/climatechange" className="text-blue-500 hover:underline">Naciones Unidas: Cambio Climático</a></li>
          <li><a href="https://www.greenpeace.org/international/" className="text-blue-500 hover:underline">Greenpeace Internacional</a></li>
          <li><a href="https://www.worldwildlife.org/" className="text-blue-500 hover:underline">World Wildlife Fund</a></li>
        </ul>
      </section>
    </div>
  );
};

export default Recursos;
