/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package logica;

import java.util.List;

/**
 *
 * @author andre
 */
public class Demo {
    public static void main(String[] args){
        Cliente c = new Cliente();
//Guardar
       c.setIdCliente(123);
       c.setCorreoCliente("andres_sanchez01@hotmail.com");
       c.setDireccionCliente("Carrera 29c # 78-81");
       c.setNombreCliente("Andres Sanchez");
       c.setTelefonoCliente("3105506015");
       c.guardarCliente();

//Actualizar
//          c.setIdCliente("123");
//          c.setCorreoCliente("orlando_sanchez0@hotmail.com");
//          c.setDireccionCliente("Carrera 55c # 75-30");
//          c.setNombreCliente("Orlando Sanchez");
//          c.setTelefonoCliente("3015352513");
//          System.out.println(c.actualizarCliente());

//Eliminar
        // c.setIdCliente("123");
        // System.out.println(c.eliminarCliente());
         
          
        List<Cliente> clientes = c.consultarClientes();
        for(Cliente cl: clientes){
            System.out.println(cl.toString());
        }
    }
}
