<%@ Page Language="VB" MasterPageFile="~/Default.master" AutoEventWireup="false" CodeFile="Manage.aspx.vb" Inherits="Manage" title="GallowayTech | Manage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">

   <div class="shim column"></div>

   <div class="page" id="admin-albums">

      <div id="sidebar">
          <h3>Choose an area to manage</h3>
      </div>

      <div id="content">
          <table width="90%"><tr>
             <td align="center"><asp:ImageButton ID="ImageButton1" runat="server" 
                  AlternateText="SiteContent"
                  ImageUrl="../Images/button_sitecontent.gif" 
                  PostBackUrl="Content.aspx" /><br />
                  Manage Content</td>
             <td align="center"><asp:ImageButton ID="ImageButton2" runat="server" 
                  AlternateText="ManageUsers"
                  ImageUrl="../Images/button_manageusers.gif"  
                  PostBackUrl="Users.aspx" /><br />
                  Manage Users</td>
             <td align="center"><asp:ImageButton ID="ImageButton3" runat="server" 
                  AlternateText="Albums"
                  ImageUrl="../Images/button_albums.gif"  
                  PostBackUrl="Albums.aspx" /><br />
                  Manage Photos</td>
            </tr></table>
      </div>
      
   </div>

</asp:Content>

