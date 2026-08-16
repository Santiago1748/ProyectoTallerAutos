package DAO;

import interfaces.LoginUsuarioDAO;
import interfaces.RolDAO;
import model.MySqlLoginUsuarioDAO;
import model.MySqlRolDAO;

public class MySqlDAOFactory extends DAOFactory {


	public LoginUsuarioDAO getLoginUsuarioDAO() {
		
		return new MySqlLoginUsuarioDAO();
		
		
	}
	
	public RolDAO  getRolDAO() {
		return new MySqlRolDAO();
		
	}

}
