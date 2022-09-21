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
 * @author sebmi
 */
public class ordencompra {
    
    private int idOrden;
    private int idCliente;
    private String fecha;

    public ordencompra() {
    }

    public ordencompra(int idOrden, int idCliente, String fecha) {
        this.idOrden = idOrden;
        this.idCliente = idCliente;
        this.fecha = fecha;
    }

    public int getIdOrden() {
        return idOrden;
    }

    public void setIdOrden(int idOrden) {
        this.idOrden = idOrden;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    @Override
    public String toString() {
        return "ordencompra{" + "idOrden=" + idOrden + ", idCliente=" + idCliente + ", fecha=" + fecha + '}';
    }
    
    public List<ordencompra> consultarOrden(){
        List<ordencompra> ordenes = new ArrayList<>();
        ConexionBD conexion = new ConexionBD();
        String sql ="SELECT * FROM ordencompra;";
        ResultSet rs = conexion.consultarBD(sql);
        try{
            ordencompra oc;
            while (rs.next()) {
                oc = new ordencompra();
                oc.setIdOrden(rs.getInt("idOrden"));
                oc.setIdCliente(rs.getInt("idCliente"));
                oc.setFecha(rs.getString("fecha"));
                ordenes.add(oc);
            }
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }finally{
            conexion.cerrarConexion();
        }  
        return ordenes;    
    }
    
    public boolean guardarOrden(){
        boolean exito = false;
        ConexionBD conexion = new ConexionBD();
        String sql = "INSERT INTO ordencompra (idOrden, idCliente, fecha) VALUES("+idOrden+", "+idCliente+", "+fecha+");";
        
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
    
    public boolean actualizarOrden(){
        boolean exito = false;
        ConexionBD conexion = new ConexionBD();
        String sql = "UPDATE ordencompra SET idCliente="+idCliente+", fecha="+fecha+" WHERE idOrden="+idOrden+";";
        
        if(conexion.setAutoCommitBD(false)){
            if(conexion.insertarBD(sql)){
                exito = true;
                conexion.commitBD();
                conexion.cerrarConexion();
            }else {
                conexion.cerrarConexion();
                    }
        }
        return exito;
        
    }
    
    public boolean eliminarOrden(){
        boolean exito = false;
        ConexionBD conexion = new ConexionBD();
        String sql = "DELETE FROM ordencompra WHERE idOrden="+idOrden+";";
        
        if(conexion.setAutoCommitBD(false)){
            if(conexion.insertarBD(sql)){
                exito = true;
                conexion.commitBD();
                conexion.cerrarConexion();
            }else {
                conexion.cerrarConexion();
                    }
        }
        return exito;
        
    }

}
