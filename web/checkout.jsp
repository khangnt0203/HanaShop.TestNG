<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : checkout
    Created on : Jan 17, 2021, 9:01:02 AM
    Author     : USER
--%>

<%@page import="tungvs.dtos.InvoiceErrorDTO"%>
<%@page import="tungvs.dtos.ProductDTO"%>
<%@page import="tungvs.dtos.CartDTO"%>
<%@page import="tungvs.dtos.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./css/checkout.css"> 
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    </head>
    <body style="background-color: #FFCAF2">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <c:choose>
            <c:when test="${empty sessionScope.CART}">
                <section class="shop text-center" >
                    <div class="shop__header">
                        <div class="row">
                            <div class="col-sm-4">
                                <a href="newjsp.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a> 
                            </div>
                            <div class="col-sm-4"><h1 style="color: white">CHECKOUT</h1> </div>
                            <div class="col-sm-4">
                                <div style="float: right; display: block;color: white"> 
                                    <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-in" aria-hidden="true"></i> Login</button></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <div style="padding-top: 90px;"></div>
                <div style="margin-left: 20px;">
                    <h1>You dont't have a cart to checkout! Login with user account, add item to CART and you con checkout ♥</h1>          
                    <a href="newjsp.jsp"><button class="btn btn-info">Continue Shopping</button></a>
                </div>
            </c:when>
            <c:otherwise>
                <c:set value="${0}" var="total"/>
                <c:forEach var="product" items="${sessionScope.CART.cart}">
                    <c:set value="${total + (product.value.quantity * product.value.price)}" var="total"/>
                </c:forEach>
                <c:choose>
                    <c:when test="${empty requestScope.ERROR}">
                        <section class="shop text-center" >
                            <div class="shop__header">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>
                                        <h2 style="color: greenyellow; float: left;margin-left: 10px">Welcome: ${sessionScope.LOGIN_USER.userId}</h2>  </br></br>                   
                                    </div>
                                    <div class="col-sm-4"><h1 style="color: white">CHECKOUT</h1> </div>
                                    <div class="col-sm-4">
                                        <div style="float: right; display: block;color: white"> 
                                            <a href="MainController?btnAction=View Cart"><button class="btn  btn-warning "><i class="fa fa-shopping-cart" aria-hidden="true"></i> Cart</button></a>
                                            <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</button></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <div style="padding-top: 140px;"></div>
                        <div class="row">
                            <div class="col-sm-4"></div>
                            <div class="col-sm-4">
                                <form action="MainController" style="border-radius: 10px;background-color: white;padding: 15px 15px">
                                    Address</br><input type="text" name="txtAddress" value="${param.txtAddress}" required="true"/><font color="red"></font></br>
                                    Number phone</br> <input type="number" name="txtPhone" value="${param.txtPhone}" required="true"/><font color="red"></font></br>
                                    Payment</br>
                                    <select name="txtPayment">
                                        <option selected="true">Cash upon delivery</option>
                                        <option>Momo</option>
                                        <option>Zalo Pay</option>
                                        <option>Credit Card</option>
                                    </select></br>
                                    <h2>Total: ${sessionScope.CART.totalPrice}$</h2>
                                    <input type="hidden" name="txtTotal" value="${sessionScope.CART.totalPrice}" />
                                    <button onclick="return confirm('Are you sure?')" name="btnAction" value="Confirm" type="submit" class="btn  btn-warning">Checkout</button>
                                    </br>
                                </form>
                                <c:if test="${not empty requestScope.ERROR_QUANTITY}">
                                    <h1 style="color: red">${requestScope.ERROR_QUANTITY}</h1>
                                </c:if>               
                            </div>
                            <div class="col-sm-4"></div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:set value="${requestScope.ERROR}" var="error"/>
                        <section class="shop text-center" >
                            <div class="shop__header">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <a href="home.jsp" style="float: left"><button class="btn  btn-warning "><i class="fa fa-home" aria-hidden="true"></i></button></a>
                                        <h2 style="color: greenyellow; float: left;margin-left: 10px">Welcome: ${sessionScope.LOGIN_USER.userId}</h2>  </br></br>                   
                                    </div>
                                    <div class="col-sm-4"><h1 style="color: white">CHECKOUT</h1> </div>
                                    <div class="col-sm-4">
                                        <div style="float: right; display: block;color: white"> 
                                            <a href="MainController?btnAction=View Cart"><button class="btn  btn-warning "><i class="fa fa-shopping-cart" aria-hidden="true"></i> Cart</button></a>
                                            <a href="MainController?btnAction=Logout"><button class="btn  btn-warning "><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</button></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <div style="padding-top: 140px;"></div>
                        <div class="row">
                            <div class="col-sm-4"></div>
                            <div class="col-sm-4">
                                <form action="MainController" style="border-radius: 10px;background-color: white;padding: 15px 15px">
                                    Address</br><input type="text" name="txtAddress" value="${param.txtAddress}" required="true"/><font color="red">${error.addressError}</font></br>
                                    Number phone</br> <input type="number" name="txtPhone" value="${param.txtPhone}" required="true"/><font color="red">${error.phoneError}</font></br>
                                    Payment</br>
                                    <select name="txtPayment">
                                        <option selected="true">Cash upon delivery</option>
                                        <option>Momo</option>
                                        <option>Zalo Pay</option>
                                        <option>Credit Card</option>
                                    </select></br>
                                    <h2>Total: ${sessionScope.CART.totalPrice}$</h2>
                                    <input type="hidden" name="txtTotal" value="${sessionScope.CART.totalPrice}" />
                                    <button onclick="return confirm('Are you sure?')" name="btnAction" value="Confirm" type="submit" class="btn  btn-warning">Checkout</button>
                                    </br>
                                </form>
                                <c:if test="${not empty requestScope.ERROR_QUANTITY}">
                                    <h1 style="color: red">${requestScope.ERROR_QUANTITY}</h1>
                                </c:if>               
                            </div>
                            <div class="col-sm-4"></div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </body>
</html>
