// src/components/Navbar.js
import React from 'react';
import { Link } from 'react-router-dom';
import PropTypes from 'prop-types';
import 'bootstrap/dist/css/bootstrap.min.css';
import './NavBar.css'; // Asegúrate de tener estilos específicos para el navbar aquí si lo necesitas

function Navbar({ show }) {
  return (
    <div className={show ? 'sidenav active' : 'sidenav'}>
      <ul className="navbar-nav flex-column">
        <li className="nav-item">
          <Link className="nav-link" to="/">
            Home
          </Link>
        </li>
        <li className="nav-item">
          <Link className="nav-link" to="/setting">
            Setting
          </Link>
        </li>
        {/* Add more navigation links here */}
      </ul>
    </div>
  );
}

Navbar.propTypes = {
  show: PropTypes.bool.isRequired,
};

export default Navbar;
