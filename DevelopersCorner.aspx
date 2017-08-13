<%@ Page Language="VB" MasterPageFile="~/Default.master" AutoEventWireup="false" CodeFile="DevelopersCorner.aspx.vb" Inherits="Manage" title="GallowayTech | DevelopersCorner" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">

   <div class="shim column"></div>

   <div class="page" id="admin-albums">

      <div id="sidebar">
          <h3>Developers Corner:</h3>
      </div>

      <div id="content">
          <table width="90%"><tr>
             <td align="center"><asp:ImageButton ID="ImageButton1" runat="server" 
                  AlternateText="CodeExamplesAndSoftware"
                  ImageUrl="~/Images/button_CodeExamplesAndSoftware.gif" 
                  PostBackUrl="CodeExamplesAndSoftware.aspx" /><br />
                  Code Examples And Software</td>
             <td align="center"><asp:ImageButton ID="ImageButton2" runat="server" 
                  AlternateText="TipsTrickAndLinks"
                  ImageUrl="~/Images/button_TipsTricksAndLinks.gif"  
                  PostBackUrl="TipsTricksAndLinks.aspx" /><br />
                  Tips, Tricks And Links</td>
            </tr></table>
      </div>
      
   </div>

</asp:Content>

