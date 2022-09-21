<%-- 
    Document   : Archivo de peticiones
    Created on : dd/mm/yyyy, hh:mm: AM/PM
    Author     : nombre autor
--%>

<%@page import="logica.Cliente"%>
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

    // Validaci�n de par�metros utilizados en todos los procesos.
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        // ------------------------------------------------------------------------------------- //
        // -----------------------------------INICIO PROCESOS----------------------------------- //
        // ------------------------------------------------------------------------------------- //
        if (proceso.equals("guardar")) {

            //Solicitud de par�metros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            // creaci�n de objeto y llamado a m�todo guardar           
            
        
            String nombreCliente = request.getParameter("nombreCliente");
            String correoCliente = request.getParameter("correoCliente");
            String direccionCliente = request.getParameter("direccionCliente");
            String telefonoCliente = request.getParameter("telefonoCliente");
            int idCliente =Integer.parseInt(request.getParameter("idCliente"));
            
            Cliente c = new Cliente(nombreCliente,correoCliente,direccionCliente,telefonoCliente,idCliente);
            
            if (c.guardarCliente()) { 
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("eliminar")) {
        //Solicitud de par�metros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creaci�n de objeto y llamado a m�todo eliminar
            int idCliente =Integer.parseInt(request.getParameter("idCliente"));
            Cliente c = new Cliente();
            c.setIdCliente(idCliente);
            
            if (c.eliminarCliente()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("listar")) {
        //Solicitud de par�metros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
           //creaci�n de objeto y llamado al metodo listar
            try {
                Cliente c = new Cliente();
                List<Cliente> lista = c.consultarClientes();
                respuesta += "\"" + proceso + "\": true,\"clientes\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"clientes\":[]";
                Logger.getLogger(Cliente.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("actualizar")) {
            //creaci�n de objeto y llamado al metodo actualizar
            String nombreCliente = request.getParameter("nombreCliente");
            String correoCliente = request.getParameter("correoCliente");
            String direccionCliente = request.getParameter("direccionCliente");
            String telefonoCliente = request.getParameter("telefonoCliente");
            int idCliente =Integer.parseInt(request.getParameter("idCliente"));
            
            Cliente c = new Cliente(nombreCliente,correoCliente,direccionCliente,telefonoCliente,idCliente);
               
            if (c.actualizarCliente()) {                     
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
                + " son inv�lidos. Corrijalos y vuelva a intentar por favor.\"";
    }    
    // Responder como objeto JSON codificaci�n ISO 8859-1.
    respuesta += "}";
    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);
%>

