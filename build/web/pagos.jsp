<%-- 
    Document   : pagos
    Created on : 19/09/2022, 06:24:17 PM
    Author     : sebmi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
        <title>Pagos</title>
        <style>
            
        </style>
    </head>
    <body>
        <div class="container-fluid" ng-app="pagos" ng-controller="pagosController as p">

            <div class="row">
                <div class="col-6">
                    <h3>Formulario</h3>

                    <div class="row">
                        <div class="col-6">
                            <label >Id Pago</label>
                            <input type="text" class="form-control" ng-model="p.idPago">
                        </div>
                        <div class="col-6">
                            <label >Id Categoria</label>
                            <input type="text" class="form-control" ng-model="p.idCategoria">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label >Fecha</label>
                            <input type="text" class="form-control" ng-model="p.fecha">
                        </div>
                        <div class="col-6">
                            <label >-</label>  
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-3">
                            <button type="button" class="btn btn-success" ng-click="p.guardar()">Guardar</button>
                        </div>
                        <div class="col-3">
                            <button type="button" class="btn btn-primary" ng-click="p.consultar()">Consultar</button>
                        </div>
                        <div class="col-3">
                            <button type="button" class="btn btn-warning" ng-click="p.actualizar()">Actualizar</button>
                        </div>
                        <div class="col-3">
                            <button type="button" class="btn btn-danger" ng-click="p.eliminar()">Eliminar</button>
                        </div>
                    </div>
                </div>

                <div class="col-6">
                    <h3>Tabla</h3>
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Id Pago</th>
                                <th scope="col">Id Categoria</th>
                                <th scope="col">Fecha</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="px in p.pagos">
                                <td>{{px.idPago}}</td>
                                <td>{{px.idCategoria}}</td>
                                <td>{{px.fecha}}</td>                              
                            </tr>

                        </tbody>
                    </table>
                    
                </div>
            </div>

        </div>
        <script>
            var app = angular.module('pagos',[]);
            app.controller('pagosController',['$http', controladorPagos]);
            function controladorPagos($http){
                var p = this;

                p.consultar = function(){
                    var parametros={
                        proceso:'listar'
                    };
                    $http({
                        method:'POST',
                        url:'peticionesPago.jsp',
                        params:parametros
                    }).then(function(resp){
                        p.pagos=resp.data.pagos;                   
                    });    
                };
                
                p.guardar = function(){
                    var parametros={
                        proceso:'guardar',
                        idPago:p.idPago,
                        idCategoria:p.idCategoria,
                        fecha:p.fecha
                    };
                    $http({
                        method:'POST',
                        url:'peticionesPago.jsp',
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
                
                p.actualizar = function(){
                    var parametros={
                        proceso:'actualizar',
                        idPago:p.idPago,
                        idCategoria:p.idCategoria,
                        fecha:p.fecha
                    };
                    $http({
                        method:'POST',
                        url:'peticionesPago.jsp',
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
                
                p.eliminar= function(){
                    var parametros={
                        proceso:'eliminar',
                        idPago:p.idPago
                    };
                    $http({
                        method:'POST',
                        url:'peticionesPago.jsp',
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
