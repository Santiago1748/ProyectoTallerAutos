package model;
import java.util.ArrayList;
import java.util.List;

import com.mysql.cj.MysqlConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import entidad.Usuario;
import interfaces.UsuarioInterface;
import util.MySqlConexion;

public class UsuarioModel implements UsuarioInterface{

	
	public int regisUsuario(Usuario regUsu) {
	
		int value = 0;
	 
		Connection cn = null;
	
		PreparedStatement psm = null;
	 
	
		try{
		
	
			cn= MySqlConexion.getConexion();
	
			String  sql ="call SP_Insertar_Empleado(?,?,?,?,?,?,?,?,?,?,?,?)";
	
			psm = cn.prepareCall(sql);
		
			psm.setString(1, regUsu.getCodigo());
			psm.setString(2, regUsu.getUsuario());
			psm.setString(3, regUsu.getPassword());
			psm.setInt(4, regUsu.getId_rol());
			psm.setBoolean(5, regUsu.isEmpleado());
			psm.setString(6, regUsu.getApellidos());
			psm.setString(7, regUsu.getNombres());
			psm.setObject(8, regUsu.getFecha_nac());
			psm.setString(9, regUsu.getCelular());
			psm.setString(10, regUsu.getCorreo());
			psm.setDouble(11, regUsu.getSalario());
			psm.setBoolean(12, regUsu.isEstado());
		
	
		value = psm.executeUpdate();
		
		
		
	}catch(Exception e) {
		e.printStackTrace();
		
		
	}finally {
		
		try{
		 if(cn != null)cn.close();
		 if(psm != null)psm.close();
			
		}catch(Exception e) {
			
			e.printStackTrace();
			return -1;
		}
		
	}
		
		
		return value;
	}

	
	public List<Usuario> listarUsuarios() {
		List<Usuario> listaUsuarios = new ArrayList<Usuario>();
		Connection cn = null;
		PreparedStatement psm = null;
		ResultSet rs = null;
		
		try {
			cn = MySqlConexion.getConexion();
		
			String sql ="SELECT e.id, e.codigo, e.usuario, e.apellidos, e.nombres, e.celular,e.id_rol, e.estado, r.nombre AS nombre_rol " +
		             "FROM empleado e " +
		             "JOIN rol r ON e.id_rol = r.id"; //select id, codigo, usuario, apellidos, nombres, celular, id_rol, estado FROM empleado";//
			psm = cn.prepareStatement(sql);
			rs = psm.executeQuery();
			
			while(rs.next()) {
				Usuario usuario = new Usuario();
				usuario.setId(rs.getInt("id"));
				usuario.setCodigo(rs.getString("codigo"));
				usuario.setUsuario(rs.getString("usuario"));
				//usuario.setPassword(rs.getString("Password"));
				//usuario.setFec_ultimases((LocalDateTime)rs.getObject("ultima_sesion"));
				usuario.setId_rol(rs.getInt("id_rol"));
				//usuario.setFec_crea((LocalDateTime)rs.getObject("fecha_crea"));
				//usuario.setFec_modif((LocalDateTime)rs.getObject("fecha_modif"));
				//usuario.setEmpleado(rs.getBoolean("empleado"));
				usuario.setApellidos(rs.getString("apellidos"));
				usuario.setNombres(rs.getString("nombres"));
				//usuario.setFecha_nac((LocalDate)rs.getObject("fecha_nac"));
				usuario.setCelular(rs.getString("celular"));
				//usuario.setSalario(rs.getDouble("salario"));
				usuario.setNombre_rol(rs.getString("nombre_rol"));//que me traiga el nombre del rolen vez deid
				usuario.setEstado(rs.getBoolean("estado"));
				
				
				
				listaUsuarios.add(usuario);
			}
			
			System.out.println("=== DEBUG TOTAL FILAS: " + listaUsuarios.size());
			
		} catch (Exception e) {
			System.out.println("=== DEBUG EXCEPCION: " + e.getMessage());         
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(psm!=null) psm.close();
				if(cn!=null) cn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return listaUsuarios;
	}


	public int modifUsuario(Usuario modifUsu) {
		
		    int value = 0;
		    Connection cn = null;
		    PreparedStatement psm = null;

		    try {
		        cn = MySqlConexion.getConexion();
		        String sql = "call SP_Actualizar_Empleado(?,?,?,?,?,?,?,?,?,?,?,?,?)";
		        psm = cn.prepareCall(sql);

		        psm.setInt(1, modifUsu.getId());
		        psm.setString(2, modifUsu.getCodigo());
		        psm.setString(3, modifUsu.getUsuario());
		        String pass = modifUsu.getPassword();
		        psm.setString(4, (pass == null || pass.isEmpty()) ? null : pass);
		        psm.setInt(5, modifUsu.getId_rol());
		        psm.setBoolean(6, modifUsu.isEmpleado());
		        psm.setString(7, modifUsu.getApellidos());
		        psm.setString(8, modifUsu.getNombres());
		        psm.setObject(9, modifUsu.getFecha_nac());
		        psm.setString(10, modifUsu.getCelular());
		        psm.setString(11, modifUsu.getCorreo());
		        psm.setDouble(12, modifUsu.getSalario());
		        psm.setBoolean(13, modifUsu.isEstado());

		        value = psm.executeUpdate();

		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        try {
		            if (psm != null) psm.close();
		            if (cn != null) cn.close();
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		    }
		    return value;
		}


	public int elimUsuario(int id) {
		int value= 0;
		Connection cn = null;
	    PreparedStatement psm = null;
	    
	    try {
	        cn = MySqlConexion.getConexion();
	        String sql = "DELETE FROM empleado WHERE id = ?"; //cambiar pronto a=  "call usp_eliminarUsuario(?)"
	        psm = cn.prepareStatement(sql);
	        psm.setInt(1, id);
	        psm.executeUpdate();
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if(psm != null) psm.close();
	            if(cn != null) cn.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
		return value;
	}


	public int obPorid(int id) {
		// TODO Auto-generated method stub
		return 0;
	}


	
	public Usuario buscarUsuarioPorId(int id) {
		Usuario usuario = null;
	    Connection cn = null;
	    PreparedStatement psm = null;
	    ResultSet rs = null;
	    
	    try {
	        cn = MySqlConexion.getConexion();
	        // Aquí traes TODOS los campos porque estás viendo la ficha completa
	        String sql = "call usp_buscar_empleado_por_id(?)";
	                     
	        psm = cn.prepareCall(sql);
	        psm.setInt(1, id);
	        rs = psm.executeQuery();
	        
	        if(rs.next()) {
	        	usuario = new Usuario();
	        	usuario.setId(rs.getInt("id"));
	        	usuario.setCodigo(rs.getString("codigo"));
	        	usuario.setUsuario(rs.getString("usuario"));
	            // usuario.setPassword(rs.getString("Password")); // Omitido por seguridad en la vista
	        	usuario.setFec_ultimases((LocalDateTime)rs.getObject("ultima_sesion"));
	        	usuario.setId_rol(rs.getInt("id_rol"));
	        	usuario.setNombre_rol(rs.getString("nombre_rol"));//es el alias que se creó en el inner join
	        	usuario.setFec_crea((LocalDateTime)rs.getObject("fecha_crea"));
	        	usuario.setFec_modif((LocalDateTime)rs.getObject("fecha_modif"));
	        	usuario.setEmpleado(rs.getBoolean("empleado"));
	        	usuario.setApellidos(rs.getString("apellidos"));
	        	usuario.setNombres(rs.getString("nombres"));
	        	java.sql.Date fechaSql = rs.getDate("fecha_nacimiento");
	        	if (fechaSql != null) {
	        	    usuario.setFecha_nac(fechaSql.toLocalDate());
	        	}
	        	usuario.setCelular(rs.getString("celular"));
	        	usuario.setCorreo(rs.getString("correo"));
	        	usuario.setSalario(rs.getDouble("salario"));
	        	usuario.setEstado(rs.getBoolean("estado"));
	        }
	    } catch (Exception e) {
	    	System.err.println(">>> [UsuarioModel.buscarUsuarioPorId] ERROR: " + e.getMessage());
	        e.printStackTrace();
	    } finally {
	        try {
	        	if(cn != null)cn.close();
	        	if(psm != null)psm.close();
	        	if(rs != null)rs.close();
	        }catch(Exception e) {
	        	e.printStackTrace();
	        	
	        }
	    }
	    
	    return usuario;
	}

	



}
