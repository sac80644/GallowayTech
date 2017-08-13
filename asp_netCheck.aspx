<%@ Page Language="VB" AutoEventWireup="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
</head>
<body>

 <% Response.Write("Windows Account which runs ASP.NET is: " & Environment.UserName.ToString)%>
    <br />
 <% Response.Write(".NET Version for this ASP.NET site is: " & Environment.Version.ToString)%>

</body>
</html>