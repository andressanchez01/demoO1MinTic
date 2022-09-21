<%-- 
    Document   : cliente
    Created on : 13/09/2022, 06:42:43 AM
    Author     : andre
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
        <title>Clientes</title>
        <style>
         /*   div{
                border:solid 2px;
            }*/
        </style>
    </head>
    <body>
        <div class="container-fluid" ng-app="clientes" ng-controller="clientesController as c">
            <div class="row">
                <div class="col-6">
                    <h3>Formulario</h3>

                    <div class="row">
                        <div class="col-6">
                            <label >Id Cliente:</label>
                            <input type="text" class="form-control" ng-model="c.idCliente">
                        </div>
                        <div class="col-6">
                            <label >Nombre Cliente:</label>
                            <input type="text" class="form-control" ng-model="c.nombreCliente">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label >Correo Cliente</label>
                            <input type="text" class="form-control" ng-model="c.correoCliente">
                        </div>
                        <div class="col-6">-</div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label >Direccion Cliente</label>
                            <input type="text" class="form-control" ng-model="c.direccionCliente">
                        </div>
                        <div class="col-6">-</div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label >Telefono Cliente</label>
                            <input type="text" class="form-control" ng-model="c.telefonoCliente">
                        </div>
                        <div class="col-6">-</div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-3">
                            <button type="button" class="btn btn-success" ng-click="c.guardar()">Guardar</button>
                        </div>
                        <div class="col-3">
                            <button type="button" class="btn btn-primary" ng-click="c.consultar()">Consultar</button>
                        </div>
                        <div class="col-3">
                            <button type="button" class="btn btn-warning" ng-click="c.actualizar()">Actualizar</button>
                        </div>
                        <div class="col-3">
                            <button type="button" class="btn btn-danger" ng-click="c.eliminar()">Eliminar</button>
                        </div>
                    </div>
                </div>

                <div class="col-6">
                    <h3>Tabla</h3>
                    <table class="table">
                        <thead>
                            <tr>                                
                                <th scope="col">Id Cliente</th>
                                <th scope="col">Nombre Cliente</th>
                                <th scope="col">Correo Cliente</th>
                                <th scope="col">Direccion Cliente</th>
                                <th scope="col">Telefono Cliente</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="ax in c.clientes">                               
                                <td>{{ax.idCliente}}</td>
                                <td>{{ax.nombreCliente}}</td>
                                <td>{{ax.correoCliente}}</td>
                                <td>{{ax.direccionCliente}}</td>
                                <td>{{ax.telefonoCliente}}</td>
                            </tr>
                            
                        </tbody>
                    </table>
<!--                    {{a.idAutor}}
                    {{a.nombre}}
                    {{a.nacionalidad}}-->
                </div>
            </div>
        </div>
         <script>
            var app=angular.module('clientes',[]);
            app.controller('clientesController',['$http',controladorClientes]);
            function controladorClientes($http){
                var c=this;
                
                c.consultar=function(){
                    var parametros={
                        proceso:'listar'
                    };
                    $http({
                        method:'POST',
                        url:'peticionesCliente.jsp',
                        params:parametros
                    }).then(function(resp){
                        c.clientes=resp.data.clientes;
                    });
                };
                
                c.guardar=function(){
                    var parametros={
                        proceso:'guardar',
                        nombreCliente:c.nombreCliente,
                        correoCliente:c.correoCliente,
                        direccionCliente:c.direccionCliente,
                        telefonoCliente:c.telefonoCliente,
                        idCliente:c.idCliente
                    };
                    $http({
                        method:'POST',
                        url:'peticionesCliente.jsp',
                        params:parametros
                    }).then(function(resp){
                        if(resp.data.ok===true){
                            if(resp.data.guardar===true){
                                alert('Guardó');
                            }else{
                                alert('No Guardó');
                            }
                            
                        }else{
                            alert(resp.data.errorMsg);
                        }
                    });
                };
                c.actualizar=function(){
                    var parametros={
                        proceso:'actualizar',
                        nombreCliente:c.nombreCliente,
                        correoCliente:c.correoCliente,
                        direccionCliente:c.direccionCliente,
                        telefonoCliente:c.telefonoCliente,
                        idCliente:c.idCliente
                    };
                    $http({
                        method:'POST',
                        url:'peticionesCliente.jsp',
                        params:parametros
                    }).then(function(resp){
                        if(resp.data.ok===true){
                            if(resp.data.actualizar===true){
                                alert('Actualizó');
                            }else{
                                alert('No Actualizó');
                            }
                            
                        }else{
                            alert(resp.data.errorMsg);
                        }
                    });
                };
                c.eliminar=function(){
                     var parametros={
                        proceso:'eliminar',
                        idCliente:c.idCliente
                    };
                    $http({
                        method:'POST',
                        url:'peticionesCliente.jsp',
                        params:parametros
                    }).then(function(resp){
                        if(resp.data.ok===true){
                            if(resp.data.eliminar===true){
                                alert('Eliminó');
                            }else{
                                alert('No Eliminó');
                            }
                            
                        }else{
                            alert(resp.data.errorMsg);
                        }
                    });
                };
            }
        </script>
    </body>
</html>
