<%@ Page Language="VB" MasterPageFile="~/Default.master" AutoEventWireup="false" CodeFile="Stats.aspx.vb" Inherits="Admin_Stats" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">

    <div class="shim gradient"></div>

    <div class="page" id="albums">
    
      <div id="sidebar">
          <h3>Choose an area to manage</h3>
      </div>
      
      <div id="content">
      
            <h4> Statistics for the Test Web Application </h4>
            Total hits: <% Response.Write(Application("Hits").ToString())%> <br />
            Total sessions: <% Response.Write(Application("Sessions").ToString())%> <br />
            Expired sessions: <% Response.Write(Application("TerminatedSessions").ToString())%> <br />
    
      </div>
    </div>
</asp:Content>