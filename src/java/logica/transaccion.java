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
public class transaccion {

    private int idReporte;
    private int idCliente;
    private int idOrden;
    private int idPago;
    private int idProducto;

    public transaccion() {
    }

    public transaccion(int idReporte, int idCliente, int idOrden, int idPago, int idProducto) {
        this.idReporte = idReporte;
        this.idCliente = idCliente;
        this.idOrden = idOrden;
        this.idPago = idPago;
        this.idProducto = idProducto;
    }

    public int getIdReporte() {
        return idReporte;
    }

    public void setIdReporte(int idReporte) {
        this.idReporte = idReporte;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public int getIdOrden() {
        return idOrden;
    }

    public void setIdOrden(int idOrden) {
        this.idOrden = idOrden;
    }

    public int getIdPago() {
        return idPago;
    }

    public void setIdPago(int idPago) {
        this.idPago = idPago;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    @Override
    public String toString() {
        return "transaccion{" + "idReporte=" + idReporte + ", idCliente=" + idCliente + ", idOrden=" + idOrden + ", idPago=" + idPago + ", idProducto=" + idProducto + '}';
    }

    public List<transaccion> consultarTransaccion() {
        List<transaccion> transacciones = new ArrayList<>();
        ConexionBD conexion = new ConexionBD();
        String sql = "SELECT * FROM transaccion;";
        ResultSet rs = conexion.consultarBD(sql);
        try {
            transaccion t;
            while (rs.next()) {
                t = new transaccion();
                t.setIdReporte(rs.getInt("idReporte"));
                t.setIdCliente(rs.getInt("idCliente"));
                t.setIdOrden(rs.getInt("idOrden"));
                t.setIdPago(rs.getInt("idPago"));
                t.setIdProducto(rs.getInt("idProducto"));
                transacciones.add(t);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } finally {
            conexion.cerrarConexion();
        }
        return transacciones;
    }

    public boolean guardarTransaccion() {
        boolean exito = false;
        ConexionBD conexion = new ConexionBD();
        String sql = "INSERT INTO transaccion (idReporte, idCliente, idOrden, idPago, idProducto) VALUES(" + idReporte + ", " + idCliente + ", " + idOrden + ", " + idPago + ", " + idProducto + ");";

        if (conexion.setAutoCommitBD(false)) {
            if (conexion.insertarBD(sql)) {
                exito = true;
                conexion.commitBD();
                conexion.cerrarConexion();
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
            }
        } else {
            conexion.cerrarConexion();
        }
        return exito;
    }

    public boolean actualizarTransaccion() {
        boolean exito = false;
        ConexionBD conexion = new ConexionBD();
        String sql = "UPDATE transaccion SET idCliente=" + idCliente + ", idOrden=" + idOrden + ", idPago=" + idPago + ", idProducto=" + idProducto + " WHERE idReporte=" + idReporte + ";";

        if (conexion.setAutoCommitBD(false)) {
            if (conexion.insertarBD(sql)) {
                exito = true;
                conexion.commitBD();
                conexion.cerrarConexion();
            } else {
                conexion.cerrarConexion();
            }
        }
        return exito;

    }

    public boolean eliminarTransaccion() {
        boolean exito = false;
        ConexionBD conexion = new ConexionBD();
        String sql = "DELETE FROM transaccion WHERE idReporte=" + idReporte + ";";

        if (conexion.setAutoCommitBD(false)) {
            if (conexion.insertarBD(sql)) {
                exito = true;
                conexion.commitBD();
                conexion.cerrarConexion();
            } else {
                conexion.cerrarConexion();
            }
        }
        return exito;

    }
}
