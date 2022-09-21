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
public class pago {
    
    private int idPago;
    private int idCategoria;
    private String fecha;

    public pago() {
    }

    public pago(int idPago, int idCategoria, String fecha) {
        this.idPago = idPago;
        this.idCategoria = idCategoria;
        this.fecha = fecha;
    }

    public int getIdPago() {
        return idPago;
    }

    public void setIdPago(int idPago) {
        this.idPago = idPago;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    @Override
    public String toString() {
        return "pago{" + "idPago=" + idPago + ", idCategoria=" + idCategoria + ", fecha=" + fecha + '}';
    }
    
    public List<pago> consultarPago(){
        List<pago> pagos = new ArrayList<>();
        ConexionBD conexion = new ConexionBD();
        String sql ="SELECT * FROM pago;";
        ResultSet rs = conexion.consultarBD(sql);
        try{
            pago p;
            while (rs.next()) {
                p = new pago();
                p.setIdPago(rs.getInt("idPago"));
                p.setIdCategoria(rs.getInt("idCategoria"));
                p.setFecha(rs.getString("fecha"));
                pagos.add(p);
            }
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }finally{
            conexion.cerrarConexion();
        }  
        return pagos;    
    }
    
    public boolean guardarPago(){
        boolean exito = false;
        ConexionBD conexion = new ConexionBD();
        String sql = "INSERT INTO pago (idPago, idCategoria, fecha) VALUES("+idPago+", "+idCategoria+", "+fecha+");";
        
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
    
    public boolean actualizarPago(){
        boolean exito = false;
        ConexionBD conexion = new ConexionBD();
        String sql = "UPDATE pago SET idCategoria="+idCategoria+", fecha="+fecha+" WHERE idPago="+idPago+";";
        
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
    
    public boolean eliminarPago(){
        boolean exito = false;
        ConexionBD conexion = new ConexionBD();
        String sql = "DELETE pago WHERE idPago="+idPago+";";
        
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
