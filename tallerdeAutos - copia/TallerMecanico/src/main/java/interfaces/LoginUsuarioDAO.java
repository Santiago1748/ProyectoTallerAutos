package interfaces;

import entidad.Usuario;

public interface LoginUsuarioDAO {
	public Usuario validarLogin(String usu, String pwd);
	

}
