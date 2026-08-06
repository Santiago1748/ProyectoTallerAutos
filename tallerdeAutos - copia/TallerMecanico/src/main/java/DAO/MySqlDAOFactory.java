package DAO;

import interfaces.LoginUsuarioDAO;

import model.MySqlLoginUsuarioDAO;

public class MySqlDAOFactory extends DAOFactory {


	public LoginUsuarioDAO getLoginUsuarioDAO() {
		
		return new MySqlLoginUsuarioDAO();
		
	}

}
