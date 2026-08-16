package entidad;

public class Rol {
	
	public int id;
	public String codigo;
	public String cargo ;
	public String nombre;
	public boolean estado;
	
	
	public Rol() {
		
	}


	public Rol(int id, String cargo, String nombre, String codigo, boolean estado) {
		
		this.id = id;
		this.cargo = cargo;
		this.nombre = nombre;
		this.codigo = codigo;
		this.estado = estado;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getCargo() {
		return cargo;
	}


	public void setCargo(String cargo) {
		this.cargo = cargo;
	}


	public String getNombre() {
		return nombre;
	}


	public void setNombre(String nombre) {
		this.nombre = nombre;
	}


	public String getCodigo() {
		return codigo;
	}


	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}


	public boolean isEstado() {
		return estado;
	}


	public void setEstado(boolean estado) {
		this.estado = estado;
	}
	
	
	
}
