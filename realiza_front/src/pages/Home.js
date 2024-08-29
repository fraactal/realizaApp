import React from 'react';

const Home = () => {
  return (
    <div className="container mx-auto p-6">
      <h1 className="text-4xl font-bold text-center mb-8">Bienvenido a Nuestra Página Principal</h1>
      
      <section className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">¿Quiénes Somos?</h2>
        <p className="text-lg text-gray-700">
          Somos una empresa dedicada a la sostenibilidad y al desarrollo de soluciones innovadoras
          para enfrentar los desafíos del cambio climático. Nuestra misión es transformar el modo
          en que las organizaciones operan, con un enfoque en reducir su impacto ambiental y
          fomentar prácticas sostenibles.
        </p>
      </section>

      <section className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">Nuestros Servicios</h2>
        <p className="text-lg text-gray-700">
          Ofrecemos una amplia gama de servicios que incluyen consultoría en sostenibilidad,
          auditorías de eficiencia energética, y capacitación en prácticas sostenibles. Estamos
          comprometidos a ayudar a nuestros clientes a alcanzar sus objetivos de sostenibilidad a
          través de estrategias personalizadas y soluciones prácticas.
        </p>
      </section>

      <section className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">Últimas Noticias</h2>
        <p className="text-lg text-gray-700">
          Manténgase al día con nuestras últimas iniciativas, eventos y noticias del sector. Nos
          esforzamos por estar a la vanguardia de las tendencias y desarrollos en el ámbito de la
          sostenibilidad, y compartimos nuestros conocimientos y experiencias a través de nuestro
          blog y redes sociales.
        </p>
      </section>

      <section className="mb-8">
        <h2 className="text-2xl font-semibold mb-4">Contáctanos</h2>
        <p className="text-lg text-gray-700">
          ¿Interesado en saber más sobre cómo podemos ayudarte a transformar tu organización hacia
          la sostenibilidad? No dudes en ponerte en contacto con nosotros. Nuestro equipo de
          expertos está listo para responder a tus preguntas y ofrecerte la asistencia que
          necesitas.
        </p>
      </section>
    </div>
  );
};

export default Home;
