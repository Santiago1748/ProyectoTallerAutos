package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import entidad.Usuario;
import interfaces.LoginUsuarioDAO;
import util.MySqlConexion;

public class MySqlLoginUsuarioDAO implements LoginUsuarioDAO{

	
	public Usuario validarLogin(String usu, String pwd) {
		Usuario user = null;
		Connection cn = null;
		PreparedStatement psm = null;
		ResultSet rs = null;
		
		try {
			cn = MySqlConexion.getConexion();
			String sql = "call usp_validalogin(?,?)";
			psm = cn.prepareCall(sql);
			psm.setString(1, usu);
			psm.setString(2, pwd);
			
			rs= psm.executeQuery();
			
			if(rs.next()) {
				
				user = new Usuario();
				user.setUsuario(rs.getString("usuario"));
				user.setPassword(rs.getString("password"));
		
			    user.setId_rol(rs.getInt("id_rol"));
				
			}
			
		}catch(Exception e) {
			
			e.printStackTrace();
			
			
		}finally {
			try {
				if(cn != null)cn.close();
				if(psm != null)psm.close();
				if(rs != null)rs.close();
			}catch(Exception e) {
				e.printStackTrace();
				
			}
		}
		return user;
	}
			

}
