<%-- 
    Document   : ordenes
    Created on : 20/09/2022, 06:20:59 PM
    Author     : sebmi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
        <title>Ordenes</title>
        <style>
           
        </style>
    </head>
    <body>

        <div class="container-fluid" ng-app="ordenes" ng-controller="ordenesController as o">

            <div class="row">
                <div class="col-6">
                    <h3>Formulario</h3>

                    <div class="row">
                        <div class="col-6">
                            <label >id Orden</label>
                            <input type="text" class="form-control" ng-model="o.idOrden">
                        </div>
                        <div class="col-6">
                            <label >Id Cliente</label>
                            <input type="text" class="form-control" ng-model="o.idCliente">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label >Fecha</label>
                            <input type="text" class="form-control" ng-model="o.fecha">
                        </div>
                        <div class="col-6">
                            <label >-</label>   
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-3">
                            <button type="button" class="btn btn-success" ng-click="o.guardar()">Guardar</button>
                        </div>
                        <div class="col-3">
                            <button type="button" class="btn btn-primary" ng-click="o.consultar()">Consultar</button>
                        </div>
                        <div class="col-3">
                            <button type="button" class="btn btn-warning" ng-click="o.actualizar()">Actualizar</button>
                        </div>
                        <div class="col-3">
                            <button type="button" class="btn btn-danger" ng-click="o.eliminar()">Eliminar</button>
                        </div>
                    </div>
                </div>

                <div class="col-6">
                    <h3>Tabla</h3>
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Id Orden</th>
                                <th scope="col">Id Cliente</th>
                                <th scope="col">Fecha</th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="ox in o.ordenes">
                                <td>{{ox.idOrden}}</td>
                                <td>{{ox.idCliente}}</td>
                                <td>{{ox.fecha}}</td>
                            </tr>                            
                        </tbody>
                    </table>

                </div>
            </div>

        </div>
        <script>
            var app = angular.module('ordenes', []);
            app.controller('ordenesController', ['$http', controladorOrdenes]);
            function controladorOrdenes($http) {
                var o = this;

                o.consultar=function(){
                    var parametros={
                        proceso:'listar'
                    };
                    $http({
                        method:'POST',
                        url:'peticionesOrden.jsp',
                        params:parametros
                    }).then(function(resp){
                        o.ordenes=resp.data.ordenes;

                    });
                };

                o.guardar=function(){
                    var parametros={
                        proceso:'guardar',
                        idOrden:o.idOrden,
                        idCliente:o.idCliente,
                        fecha:o.fecha
                    };
                    $http({
                        method:'POST',
                        url:'peticionesOrden.jsp',
                        params:parametros
                    }).then(function(resp){
                        if(resp.data.ok===true){
                            if(resp.data.guardar===true){
                                alert('Guardó');
                            }else{
                                alert('No guardó');
                            }
                            
                        }else{
                            alert(resp.data.errorMsg);
                        }
                    });  
                };

                o.actualizar=function(){
                    var parametros={
                        proceso:'actualizar',
                        idOrden:o.idOrden,
                        idCliente:o.idCliente,
                        fecha:o.fecha
                    };
                    $http({
                        method:'POST',
                        url:'peticionesOrden.jsp',
                        params:parametros
                    }).then(function(resp){
                        if(resp.data.ok===true){
                            if(resp.data.actualizar===true){
                                alert('Actualizó');
                            }else{
                                alert('No actualizó');
                            }
                            
                        }else{
                            alert(resp.data.errorMsg);
                        }
                    });  
                };
                
                o.eliminar=function(){
                    var parametros={
                        proceso:'eliminar',
                        idOrden:o.idOrden,
                        idCliente:o.idCliente,
                        fecha:o.fecha
                    };
                    $http({
                        method:'POST',
                        url:'peticionesOrden.jsp',
                        params:parametros
                    }).then(function(resp){
                        if(resp.data.ok===true){
                            if(resp.data.eliminar===true){
                                alert('Eliminó');
                            }else{
                                alert('No eliminó');
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
