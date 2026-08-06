package DAO;

import interfaces.LoginUsuarioDAO;


public abstract class DAOFactory {
	public static final int MYSQL = 1;
	public static final int SQLSERVER = 2;
	public static final int ORACLE = 3;
	
	public abstract LoginUsuarioDAO getLoginUsuarioDAO();
	
	public static MySqlDAOFactory getDAOFactory(int tipo) {
		switch (tipo) {
		case MYSQL:
			return new MySqlDAOFactory();
			default:
				return null;
		
		}
		
		
	}

}
