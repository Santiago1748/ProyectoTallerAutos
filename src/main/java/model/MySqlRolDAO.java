package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import entidad.Rol;
import interfaces.RolDAO;
import util.MySqlConexion;

public class MySqlRolDAO implements RolDAO {

	
	public List<Rol> listarRol() {
		List<Rol> listadoRoles = new ArrayList<Rol>() ;
		Connection cn = null;
		PreparedStatement psm = null;
		ResultSet rs = null;
		
		try {
			cn = MySqlConexion.getConexion();
			String sql = "call usp_listar_rol()";
			psm = cn.prepareCall(sql);
			rs = psm.executeQuery();
			
			while(rs.next()){
				Rol rol = new Rol();
				rol.setId( rs.getInt("id"));
				rol.setCargo(rs.getString("cargo"));
				rol.setCodigo(rs.getString("codigo"));
				rol.setNombre(rs.getString("nombre"));
				rol.setEstado(rs.getBoolean("estado"));
				
				listadoRoles.add(rol);	
			}
			 System.out.println(">>> [MySqlRolDAO.listarRol] Total roles: " + listadoRoles.size());   //
			
			 
		} catch (Exception e) {
			 System.err.println(">>> [MySqlRolDAO.listarRol] ERROR: " + e.getMessage());   // <-- CAMBIO 3: agregar esta línea dentro del catch
		     
			e.printStackTrace();
		}finally {
			try {
				
				if(rs != null)rs.close();
				if(psm != null)psm.close();
				if(cn != null)cn.close();
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}	
		return listadoRoles;
	}

}
