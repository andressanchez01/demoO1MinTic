/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package logica;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import persistencia.ConexionBD;

/**
 *
 * @author andre
 */
public class Cliente {
    private String nombreCliente;
    private String correoCliente;
    private String direccionCliente;
    private String telefonoCliente;
    private int idCliente;
    
public Cliente() {
}

public Cliente(String nombreCliente, String correoCliente, String direccionCliente, String telefonoCliente, int idCliente) {
    this.nombreCliente = nombreCliente;
    this.correoCliente = correoCliente;
    this.direccionCliente = direccionCliente;
    this.telefonoCliente = telefonoCliente;
    this.idCliente = idCliente;
}

public String getNombreCliente() {
    return nombreCliente;
}

public void setNombreCliente(String nombreCliente) {
    this.nombreCliente = nombreCliente;
}

public String getCorreoCliente() {
    return correoCliente;
}

public void setCorreoCliente(String correoCliente) {
    this.correoCliente = correoCliente;
}

public String getDireccionCliente() {
    return direccionCliente;
}

public void setDireccionCliente(String direccionCliente) {
    this.direccionCliente = direccionCliente;
}

public String getTelefonoCliente() {
    return telefonoCliente;
}

public void setTelefonoCliente(String telefonoCliente) {
    this.telefonoCliente = telefonoCliente;
}

public int getIdCliente() {
    return idCliente;
}

public void setIdCliente(int idCliente) {
    this.idCliente = idCliente;
}

@Override
public String toString() {
    return "Cliente{" + "nombreCliente=" + nombreCliente + ", correoCliente=" + correoCliente + ", direccionCliente=" + direccionCliente + ", telefonoCliente=" + telefonoCliente + ", idCliente=" + idCliente + '}';
}

public List<Cliente> consultarClientes(){
    List<Cliente> clientes = new ArrayList<>();
    ConexionBD conexion = new ConexionBD();
    String sql="SELECT * FROM clientes;";
    ResultSet rs = conexion.consultarBD(sql);
    try{
        Cliente c;
        while(rs.next()){
            c = new Cliente();
            c.setNombreCliente(rs.getString("nombreCliente"));
            c.setCorreoCliente(rs.getString("correoCliente"));
            c.setDireccionCliente(rs.getString("direccionCliente"));
            c.setTelefonoCliente(rs.getString("telefonoCliente"));
            c.setIdCliente(rs.getInt("idCliente"));
            clientes.add(c);
        }
    }catch(SQLException ex){
        System.out.println(ex.getMessage());
    }finally{
        conexion.cerrarConexion();
    }
    return clientes;
    } 
public boolean guardarCliente(){
    boolean exito = false;
    ConexionBD conexion = new ConexionBD();
    String sql="INSERT INTO clientes (nombreCliente, idCliente, correoCliente, direccionCliente, telefonoCliente) VALUES('"+nombreCliente+"', '"+idCliente+"', '"+correoCliente+"', '"+direccionCliente+"', '"+telefonoCliente+"');";
    if(conexion.setAutoCommitBD(false)){
        if(conexion.insertarBD(sql)){
            exito = true;
            conexion.commitBD();
            conexion.cerrarConexion();
        }else{
            conexion.rollbackBD();
            conexion.cerrarConexion();
        }
    }else{
        conexion.cerrarConexion();
    }
    return exito;
}
public boolean actualizarCliente(){
    boolean exito = false;
    ConexionBD conexion = new ConexionBD();
    String sql="UPDATE clientes SET nombreCliente='"+nombreCliente+"', correoCliente='"+correoCliente+"', direccionCliente='"+direccionCliente+"', telefonoCliente='"+telefonoCliente+"' WHERE  idCliente='"+idCliente+"';";
    if(conexion.setAutoCommitBD(false)){
        if(conexion.actualizarBD(sql)){
            exito = true;
            conexion.commitBD();
            conexion.cerrarConexion();
        }else{
            conexion.rollbackBD();
            conexion.cerrarConexion();
        }
    }else{
        conexion.cerrarConexion();
    }
    return exito;
}
public boolean eliminarCliente(){
    boolean exito = false;
    ConexionBD conexion = new ConexionBD();
    String sql="DELETE FROM clientes WHERE idCliente='"+idCliente+"' ;";
    if(conexion.setAutoCommitBD(false)){
        if(conexion.borrarBD(sql)){
            exito = true;
            conexion.commitBD();
            conexion.cerrarConexion();
        }else{
            conexion.rollbackBD();
            conexion.cerrarConexion();
        }
    }else{
        conexion.cerrarConexion();
    }
    return exito;
}
}
