import React from 'react';
import { Link } from 'react-router-dom';
import { GiHamburgerMenu } from 'react-icons/gi';
// Importa la imagen del logo
import logo from '../images/realiza-logo-blanco.png';

const Header = ({ showNav, setShowNav }) => {
    return (
        <header className="flex items-center justify-between p-4 bg-[#2F74BA] text-white shadow-md">
            <div className="flex items-center">
                <GiHamburgerMenu
                    className="mr-4 cursor-pointer text-[#DDEAF3]"
                    onClick={() => setShowNav(!showNav)}
                />
                <div className="flex items-center">
                    <img src={logo} alt="Logo Realizapp" className="h-10 w-auto" />
                </div>
                <Link to="/" className="text-xl font-bold text-[#DDEAF3]">
                    Realizapp
                </Link>
            </div>

        </header>
    );
};

export default Header;
