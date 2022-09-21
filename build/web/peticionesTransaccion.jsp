<%-- 
    Document   : peticionesTransaccion
    Created on : 16/09/2022, 08:24:41 AM
    Author     : sebmi
--%>

<%@page import="logica.transaccion"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="application/json;charset=iso-8859-1" language="java" pageEncoding="iso-8859-1" session="true"%>

<%    // Iniciando respuesta JSON.
    String respuesta = "{";

    //Lista de procesos o tareas a realizar 
    List<String> tareas = Arrays.asList(new String[]{
        "guardar",
        "eliminar",
        "actualizar",
        "listar"
	
    });

    String proceso = "" + request.getParameter("proceso");

    // Validación de parámetros utilizados en todos los procesos.
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        // ------------------------------------------------------------------------------------- //
        // -----------------------------------INICIO PROCESOS----------------------------------- //
        // ------------------------------------------------------------------------------------- //
        if (proceso.equals("guardar")) {

            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            // creación de objeto y llamado a método guardar           
            
            int idReporte = Integer.parseInt(request.getParameter("idReporte"));
            int idCliente = Integer.parseInt(request.getParameter("idCliente"));
            int idOrden = Integer.parseInt(request.getParameter("idOrden"));
            int idPago = Integer.parseInt(request.getParameter("idPago"));
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));
            
            transaccion t = new transaccion (idReporte, idCliente, idOrden, idPago, idProducto);
            
            if (t.guardarTransaccion()) { 
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("eliminar")) {
        //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado a método eliminar
            
            int idReporte = Integer.parseInt(request.getParameter("idReporte"));
            transaccion t = new transaccion();
            t.setIdReporte(idReporte);
            
            if (t.eliminarTransaccion()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("listar")) {
        //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
           //creación de objeto y llamado al metodo listar
            try {
                transaccion a = new transaccion();
                List<transaccion> lista = a.consultarTransaccion();
                respuesta += "\"" + proceso + "\": true,\"transacciones\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"transacciones\":[]";
                Logger.getLogger(transaccion.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("actualizar")) {
            //creación de objeto y llamado al metodo actualizar
            int idReporte = Integer.parseInt(request.getParameter("idReporte"));
            int idCliente = Integer.parseInt(request.getParameter("idCliente"));
            int idOrden = Integer.parseInt(request.getParameter("idOrden"));
            int idPago = Integer.parseInt(request.getParameter("idPago"));
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));
            
            transaccion t = new transaccion (idReporte, idCliente, idOrden, idPago, idProducto);
            
            if (t.actualizarTransaccion()) {                     
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        }

        // ------------------------------------------------------------------------------------- //
        // -----------------------------------FIN PROCESOS-------------------------------------- //
        // ------------------------------------------------------------------------------------- //
        // Proceso desconocido.
    } else {
        respuesta += "\"ok\": false,";
        respuesta += "\"error\": \"INVALID\",";
        respuesta += "\"errorMsg\": \"Lo sentimos, los datos que ha enviado,"
                + " son inválidos. Corrijalos y vuelva a intentar por favor.\"";
    }    
    // Responder como objeto JSON codificación ISO 8859-1.
    respuesta += "}";
    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);
%>

