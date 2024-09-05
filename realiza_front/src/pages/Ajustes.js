import React from 'react';

const Ajustes = () => {
  return (
    <div className="p-6 space-y-6">
      <h1 className="text-3xl font-bold mb-4">Ajustes</h1>

      {/* Subtítulo y párrafo introductorio */}
      <section>
        <h2 className="text-2xl font-semibold mb-2">Personalización de la Aplicación</h2>
        <p className="text-gray-700">
          Aquí puedes modificar diferentes aspectos de tu experiencia de usuario, desde notificaciones hasta temas visuales, para que la aplicación se adapte mejor a tus necesidades.
        </p>
      </section>

      {/* Subtítulo y contenido de ajuste 1 */}
      <section>
        <h2 className="text-2xl font-semibold mb-2">Configuración de Notificaciones</h2>
        <p className="text-gray-700">
          Ajusta cómo y cuándo deseas recibir notificaciones de la aplicación. Puedes elegir entre diferentes tipos de alertas y métodos de notificación.
        </p>
        <ul className="list-disc list-inside text-gray-700">
          <li><a href="#" className="text-blue-500 hover:underline">Activar/Desactivar Notificaciones</a></li>
          <li><a href="#" className="text-blue-500 hover:underline">Configurar Alertas por Correo Electrónico</a></li>
          <li><a href="#" className="text-blue-500 hover:underline">Configurar Alertas SMS</a></li>
        </ul>
      </section>

      {/* Subtítulo y contenido de ajuste 2 */}
      <section>
        <h2 className="text-2xl font-semibold mb-2">Preferencias de Idioma</h2>
        <p className="text-gray-700">
          Selecciona el idioma que prefieras para la interfaz de la aplicación. Esta configuración afectará la visualización del contenido y las notificaciones.
        </p>
        <ul className="list-disc list-inside text-gray-700">
          <li><a href="#" className="text-blue-500 hover:underline">Cambiar a Español</a></li>
          <li><a href="#" className="text-blue-500 hover:underline">Cambiar a Inglés</a></li>
          <li><a href="#" className="text-blue-500 hover:underline">Cambiar a Francés</a></li>
        </ul>
      </section>

      {/* Subtítulo y contenido de ajuste 3 */}
      <section>
        <h2 className="text-2xl font-semibold mb-2">Temas y Apariencia</h2>
        <p className="text-gray-700">
          Personaliza el aspecto visual de la aplicación. Puedes elegir entre diferentes temas de color y modos de visualización para mejorar tu experiencia.
        </p>
        <ul className="list-disc list-inside text-gray-700">
          <li><a href="#" className="text-blue-500 hover:underline">Cambiar a Modo Oscuro</a></li>
          <li><a href="#" className="text-blue-500 hover:underline">Cambiar a Modo Claro</a></li>
          <li><a href="#" className="text-blue-500 hover:underline">Seleccionar Tema Personalizado</a></li>
        </ul>
      </section>

      {/* Subtítulo y contenido de ajuste 4 */}
      <section>
        <h2 className="text-2xl font-semibold mb-2">Seguridad y Privacidad</h2>
        <p className="text-gray-700">
          Administra tus ajustes de seguridad y privacidad para proteger tus datos personales y controlar quién puede ver tu información.
        </p>
        <ul className="list-disc list-inside text-gray-700">
          <li><a href="#" className="text-blue-500 hover:underline">Gestionar Contraseñas</a></li>
          <li><a href="#" className="text-blue-500 hover:underline">Configuración de Privacidad</a></li>
          <li><a href="#" className="text-blue-500 hover:underline">Verificación en Dos Pasos</a></li>
        </ul>
      </section>

      {/* Subtítulo y contenido de ajuste 5 */}
      <section>
        <h2 className="text-2xl font-semibold mb-2">Integraciones</h2>
        <p className="text-gray-700">
          Conecta la aplicación con otros servicios y herramientas para mejorar tu productividad y automatizar tareas.
        </p>
        <ul className="list-disc list-inside text-gray-700">
          <li><a href="#" className="text-blue-500 hover:underline">Conectar con Google Calendar</a></li>
          <li><a href="#" className="text-blue-500 hover:underline">Integrar con Slack</a></li>
          <li><a href="#" className="text-blue-500 hover:underline">Sincronizar con Dropbox</a></li>
        </ul>
      </section>
    </div>
  );
};

export default Ajustes;
