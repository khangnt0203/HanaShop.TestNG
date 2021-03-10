<%-- 
    Document   : carttest
    Created on : Jan 16, 2021, 10:06:35 AM
    Author     : USER
--%>

<%@page import="tungvs.dtos.UserDTO"%>
<%@page import="tungvs.dtos.ProductDTO"%>
<%@page import="tungvs.dtos.CartDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tungvs.daos.ProductDAO"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./css/cart.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    </head>
    <body style="background-color: #FFCAF2">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

        <c:choose>
            <c:when test="${empty sessionScope.LOGIN_USER}">
                <section class="shop text-center" >
                    <div class="shop__header">
                        <div class="row">
                            <div class="col-sm-4">
                                <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>
                            </div>
                            <div class="col-sm-4">
                                <h1 style="color: white;display: inline-block">SHOPPING CART</h1> 
                            </div>
                            <div class="col-sm-4">
                                <div style="float: right; display: block;color: white"><a href="MainController?btnAction=Logout" ><button class="btn btn-warning"><i class="fa fa-sign-in" aria-hidden="true"></i> Login</button></a></div>
                            </div>
                        </div>             
                    </div>
                </section>
                <div style="padding-top: 90px;">
                    <h1>Only USER can connect this page!!!</h1>
                </div>
            </c:when>
            <c:otherwise>
                <sql:setDataSource var="con"
                                   driver="com.microsoft.sqlserver.jdbc.SQLServerDriver"
                                   url="jdbc:sqlserver://SE140240\\SQLEXPRESS:1433; databaseName=HanaShop;"
                                   user="sa" password="123456" scope="page"
                                   />
                <section class="shop text-center" >
                    <div class="shop__header">
                        <div class="row">
                            <div class="col-sm-4">
                                <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>
                                <h4 style="color: greenyellow; float: left;margin-left: 10px">Welcome: ${sessionScope.LOGIN_USER.userId}</h4>  
                            </div>
                            <div class="col-sm-4"><h1 style="color: white">SHOPPING CART</h1> </div>
                            <div class="col-sm-4">
                                <div style="float: right; display: block;color: white"> 
                                    <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</button></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <div style="padding-top: 140px;"></div>
                <c:choose>
                    <c:when test="${empty sessionScope.CART}">
                        <div style="margin-left: 20px;">
                            <h1>Your cart is empty!</h1>          
                            <a href="home.jsp"><button class="btn btn-info">Continue Shopping</button></a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="tablePro">
                            <div class="table-responsive">
                                <table class="table table-striped" style="background-color: white">
                                    <thead>
                                        <tr>
                                            <th scope="col">No</th>
                                            <th>Image</th>
                                            <th>Category</th> 
                                            <th scope="col">Name</th>
                                            <th scope="col">Description</th>                            
                                            <th scope="col">Create Date</th>

                                            <th scope="col" class="text-center">Quantity</th>
                                            <th scope="col" class="text-right">Price</th>
                                            <th>Total</th>
                                            <th>Edit</th>
                                            <th>Remove</th>
                                            <th class="text-center">Note</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set value="${0}" var="count"/>
                                     
                                        <c:set value="${true}" var="check"/>
                                        <c:forEach var="product" items="${sessionScope.CART.cart}">
                                            <c:set value="${count + 1}" var="count"/>
                                            
                                        <form action="MainController">
                                            <tr>
                                                <td>${count}</td>
                                                <td><img src="./images/${product.value.image}" width="80" height="100"</td> 
                                                <td>${product.value.categoryName}</td>
                                                <td>${product.value.name}</td>
                                                <td>${product.value.description}</td>
                                                <td>${product.value.createDate}</td>  
                                                <td><input type="number" style="width: 100px"  name="txtQuantity" value="${product.value.quantity}" required="true"/> </td>

                                                <td class="text-right">${product.value.price} $</td>       
                                                <td>${product.value.total}$</td>
                                                <td class="text-right">                            
                                                    <input type="submit" value="Edit" name="btnAction" />
                                                    <input type="hidden" name="txtID" value="${product.value.proId}" />                        
                                                </td>

                                                <td class="text-right"><button value="Remove" name="btnAction" onclick="return confirm('Are you sure to remove ${product.value.quantity} items [${product.value.name}]?')" class="btn btn-sm btn-danger"><i class="fa fa-trash"></i> </button></td>
                                                <td>
                                                    <sql:query dataSource="${con}" var="rs">
                                                        select quantity from Product where proId='${product.value.proId}'
                                                    </sql:query>
                                                    <c:forEach items="${rs.rows}" var="row">
                                                        <c:set value="${row.quantity}" var="checkQuantity" />                                            
                                                    </c:forEach>
                                                    
                                                    <c:choose>
                                                        <c:when test="${checkQuantity < product.value.quantity}">
                                                            <c:set value="${false}" var="check"/>
                                                            <font color="red">We only have ${checkQuantity} items left!</font>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <font color="green">Valid</font>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </form>
                                    </c:forEach>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td><h3>Total</h3></td>
                                        <td class="text-right"><h3>${sessionScope.CART.totalPrice} $</h3></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>       
                            <div class="col mb-2">
                                <div class="row">
                                    <div class="col-sm-12  col-md-6">
                                        <a href="home.jsp" style="text-decoration: none"><button class="btn btn-lg btn-block btn-info text-uppercase">Continue Shopping</button></a>
                                    </div>
                                    <div class="col-sm-12 col-md-6 text-right">

                                        <c:if test="${check == true}">
                                            <form action="MainController">
                                                <button name="btnAction" value="Checkout" type="submit" class="btn btn-lg btn-block btn-success text-uppercase">Checkout</button>
                                            </form>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <c:if test="${not empty requestScope.QUANTITY_ERROR}">
                            <font color="red"><h2>${requestScope.QUANTITY_ERROR}</h2></font>
                            </c:if>
                        </c:otherwise>
                    </c:choose>

            </c:otherwise>
        </c:choose>
    </body>
</html>
