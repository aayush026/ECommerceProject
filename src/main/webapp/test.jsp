<%@page import="org.hibernate.SessionFactory"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="myCart.learn.helper.FactoryProviderHelper" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>SessionFactory Test</title>
    <%@include file="component/common_css_js.jsp" %>
</head>
<body>
    <h1>Hello World</h1>
    <h1>Creating Session Factory Object</h1>

    <%
        try {
            // Attempt to get the SessionFactory
            SessionFactory sessionFactory = FactoryProviderHelper.getSessionFactory();
            
            // Print SessionFactory reference value
            out.println("SessionFactory created successfully! Reference 1: " + sessionFactory+"<br>");
            out.println("SessionFactory created successfully! Reference 2: " + sessionFactory+"<br>");
            out.println("SessionFactory created successfully! Reference 3: " + sessionFactory+"<br>");
            
        } catch (Exception e) {
            // Handle any exceptions (print stack trace or log)
            out.println("Error creating SessionFactory: " + e.getMessage());

            // Use a PrintWriter to wrap the JspWriter
            PrintWriter writer = new PrintWriter(out);
            e.printStackTrace(writer);
        }
    %>

</body>
</html>
