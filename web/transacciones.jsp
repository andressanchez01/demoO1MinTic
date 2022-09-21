<%-- 
    Document   : transacciones
    Created on : 13/09/2022, 06:38:10 AM
    Author     : sebmi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
        <title>Transacciones</title>
        <style>
            
        </style>
    </head>
    <body>

        <div class="container-fluid" ng-app="transacciones" ng-controller="transaccionesController as t">
            
            <div class="row">
                <div class="col-6">
                    <h3>Formulario</h3>
                    
                    <div class="row">
                        <div class="col-6">
                            <label >Id Reporte</label>
                            <input type="text" class="form-control" ng-model="t.idReporte">
                        </div>
                        <div class="col-6">
                            <label >Id Cliente</label>
                            <input type="text" class="form-control" ng-model="t.idCliente">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label >Id Orden</label>
                            <input type="text" class="form-control" ng-model="t.idOrden">
                        </div>
                        <div class="col-6">
                            <label >Id Pago</label>
                            <input type="text" class="form-control" ng-model="t.idPago">    
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label >Id Producto</label>
                            <input type="text" class="form-control" ng-model="t.idProducto">
                        </div>
                        <div class="col-6">-</div>
                    </div>
                    
                    <div class="row">
                        <div class="col-3">
                            <button type="button" class="btn btn-success" ng-click="t.guardar()">Guardar</button>
                        </div>
                        <div class="col-3">
                            <button type="button" class="btn btn-primary" ng-click="t.consultar()">Consultar</button>
                        </div>
                        <div class="col-3">
                            <button type="button" class="btn btn-warning" ng-click="t.actualizar()">Actualizar</button>
                        </div>
                        <div class="col-3">
                            <button type="button" class="btn btn-danger" ng-click="t.eliminar()">Eliminar</button>
                        </div>
                    </div>
                </div>

                <div class="col-6">
                    <h3>Tabla</h3>
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Id Reporte</th>
                                <th scope="col">Id Cliente</th>
                                <th scope="col">Id Orden</th>
                                <th scope="col">Id Pago</th>
                                <th scope="col">Id Producto</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="tx in t.transacciones">
                                <td>{{tx.idReporte}}</td>
                                <td>{{tx.idCliente}}</td>
                                <td>{{tx.idOrden}}</td>
                                <td>{{tx.idPago}}</td>
                                <td>{{tx.idProducto}}</td>
                            </tr>
                            
                        </tbody>
                    </table>

                </div>
            </div>
            
        </div>
        <script>
            var app=angular.module('transacciones',[]);
            app.controller('transaccionesController',['$http',controladorTransacciones]);
            function controladorTransacciones($http){
                var t=this;
                
                t.consultar=function(){
                    var parametros={
                        proceso:'listar'
                    };
                    $http({
                        method:'POST',
                        url:'peticionesTransaccion.jsp',
                        params:parametros
                    }).then(function(resp){
                        t.transacciones=resp.data.transacciones;
                        
                    });
                };
            
                t.guardar=function(){
                    var parametros={
                        proceso:'guardar',
                        idReporte:t.idReporte,
                        idCliente:t.idCliente,
                        idOrden:t.idOrden,
                        idPago:t.idPago,
                        idProducto:t.idProducto
                    };
                    $http({
                        method:'POST',
                        url:'peticionesTransaccion.jsp',
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
                
                t.actualizar=function(){
                    var parametros={
                        proceso:'actualizar',
                        idReporte:t.idReporte,
                        idCliente:t.idCliente,
                        idOrden:t.idOrden,
                        idPago:t.idPago,
                        idProducto:t.idProducto
                    };
                    $http({
                        method:'POST',
                        url:'peticionesTransaccion.jsp',
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
                t.eliminar=function(){
                    var parametros={
                        proceso:'eliminar',
                        idReporte:t.idReporte
                    };
                    $http({
                        method:'POST',
                        url:'peticionesTransaccion.jsp',
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
