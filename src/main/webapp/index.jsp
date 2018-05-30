<!--
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements.  See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to You under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License.  You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->
<%@page import="java.net.InetAddress" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Date" %>
<%@page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>TomEE Clustering with memcached music store</title>
</head>
<body>
<span style="font-size: large; color: #0000FF">
    Instance <%=InetAddress.getLocalHost()%> <br/><br/>
</span>

<hr/>

<span style="font-size: large; color: #CC0000">
    <br/>
    Session Id : <%=request.getSession().getId()%> <br/>
    Is it New Session : <%=request.getSession().isNew()%><br/>
    Session Creation Date : <%=new Date(request.getSession().getCreationTime())%><br/>
    Session Access Date : <%=new Date(request.getSession().getLastAccessedTime())%><br/><br/>
</span>

<b>Cart List </b><br/>
<hr/>


<ul>
    <%
        final String albumName = request.getParameter("albumName");
        List<String> listOfAlbums = (List<String>) request.getSession().getAttribute("Albums");
        if (listOfAlbums == null) {
            listOfAlbums = new ArrayList<>();
            request.getSession().setAttribute("Albums", listOfAlbums);
        }
        if (albumName != null) {
            listOfAlbums.add(albumName);
        }
        for (String book : listOfAlbums) {
            out.println("<li>" + book + "</li><br/>");
        }

    %>
</ul>
<hr/>
<form action="index.jsp" method="post">
    Album Name <input type="text" name="albumName"/>
    <input type="submit" value="Add to Cart"/>
</form>
<hr/>
</body>
</html>