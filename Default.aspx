<%@	Page Language="VB" MasterPageFile="~/Default.master" Title="GallowayTech | Home"
	CodeFile="Default.aspx.vb" Inherits="Default_aspx" %>

<asp:content id="Content1" contentplaceholderid="Main" runat="server">

	<div class="shim column"></div>

	<div class="page" id="home" style="left: 0px; top: 0px">
		<div id="sidebar">
			<asp:loginview id="LoginArea" runat="server" Visible="False">
				<AnonymousTemplate>
					<asp:login id="Login1" runat="server">
						<layouttemplate>
							<div class="login">
								<h4>Login to Site</h4>
								<asp:label runat="server" id="UserNameLabel" CssClass="label" associatedcontrolid="UserName">User Name</asp:label>
								<asp:textbox runat="server"	id="UserName" cssclass="textbox" accesskey="u" />
								<asp:requiredfieldvalidator	runat="server" id="UserNameRequired" controltovalidate="UserName" validationgroup="Login1" errormessage="User Name is required." tooltip="User Name	is required." >*</asp:requiredfieldvalidator>
								<asp:label runat="server" id="PasswordLabel" CssClass="label" associatedcontrolid="Password">Password</asp:label>
								<asp:textbox runat="server"	id="Password" textmode="Password" cssclass="textbox" accesskey="p" />
								<asp:requiredfieldvalidator	runat="server" id="PasswordRequired" controltovalidate="Password" validationgroup="Login1" tooltip="Password is	required." >*</asp:requiredfieldvalidator>
								<div><asp:checkbox runat="server" id="RememberMe" text="Remember me	next time"/></div>
								<asp:imagebutton runat="server"	id="LoginButton" CommandName="Login" AlternateText="login" skinid="login" CssClass="button"/>
								or
								<a href="register.aspx"	class="button"><asp:image id="Image1" runat="server"  AlternateText="create	a new account" skinid="create"/></a>
								<p><asp:literal	runat="server" id="FailureText"	enableviewstate="False"></asp:literal></p>
							</div>
						</layouttemplate>
					</asp:login>
				</anonymoustemplate>
				<LoggedInTemplate>
					<h4><asp:loginname id="LoginName1" runat="server" formatstring="Welcome&#9;{0}!" /></h4>
				</LoggedInTemplate>
			</asp:loginview>
			<hr />
			<asp:formview id="FormView1" runat="server" datasourceid="ObjectDataSource1" ondatabound="Randomize" cellpadding="0" borderwidth="0" enableviewstate="false">
				<ItemTemplate>
					<h4>Photo of the Day</h4>
					<table border="0" cellpadding="0" cellspacing="0" class="photo-frame">
						<tr>
							<td class="topx--"></td>
							<td class="top-x-"></td>
							<td class="top--x"></td>
						</tr>
						<tr>
							<td class="midx--"></td>
							<td><a href='Details.aspx?AlbumID=<%# Eval("AlbumID") %>&Page=<%# Container.DataItemIndex %>'>
								<img src="Handler.ashx?PhotoID=<%# Eval("PhotoID") %>&Size=M" class="photo_198" style="border:4px solid white" alt='Photo Number <%# Eval("PhotoID") %>' /></a></td>
							<td class="mid--x"></td>
						</tr>
						<tr>
							<td class="botx--"></td>
							<td class="bot-x-"></td>
							<td class="bot--x"></td>
						</tr>
					</table>
					<p></p>
					<p><a href='Download.aspx?AlbumID=<%# Eval("AlbumID") %>&Page=<%# Container.DataItemIndex %>'>
						<asp:image runat="Server" id="DownloadButton" AlternateText="download photo" skinid="download"/></a></p>
					<p>See <a href="Albums.aspx">more photos </a></p>
					<hr />
				</ItemTemplate>
			</asp:formview>
			
			<asp:FormView ID="FormViewPOW" runat="server" DataSourceID="SqlDataSourcePieceOfWork">
			    <HeaderTemplate>
			    <asp:Label ID="LabelPieceOfWorkHeader" runat="server">
			        <h4><%#Eval("ModuleTitle")%></h4>
			    </asp:Label>
			    </HeaderTemplate>
			    <ItemTemplate>
			        <p><%#Eval("ModuleContent")%></p>
			    </ItemTemplate>
			</asp:FormView>
			
		</div>
        <div id="content">
        
            <asp:FormView ID="FormViewWelcome" Width="100%" runat="server" DataSourceID="SqlDataSourceWelcome">
			    <HeaderTemplate>
			    <asp:Label ID="LabelWelcome" runat="server">
			        <h4><%#Eval("ModuleTitle")%></h4>
			    </asp:Label>
			    </HeaderTemplate>
			    <ItemTemplate>
			        <p><%#Eval("ModuleContent")%></p>
			        <hr   />
			    </ItemTemplate>
			</asp:FormView>
          
            <asp:FormView ID="FormViewWhatsnew" Width="100%" runat="server" DataSourceID="SqlDataSourceBriefPosts">
			    <HeaderTemplate>
			    <asp:Label ID="LabelWhatsNew" runat="server">
			        <h4><%#Eval("ModuleTitle")%></h4>
			    </asp:Label>
			    </HeaderTemplate>
			    <ItemTemplate>
			    
			<asp:Repeater ID="RepeaterWhatsNew" runat="server" DataSourceID="SqlDataSourceBriefPosts">
				<ItemTemplate>
			        <p><%#Eval("ModuleContent")%> - <%#Eval("DateCreated")%></p>
			        <hr />
			    </ItemTemplate>
			</asp:Repeater>
			    
			    </ItemTemplate>
			</asp:FormView>
			
			<asp:FormView ID="FormViewWhatsUp" Width="100%" runat="server" DataSourceID="SqlDataSourceWhatsUp">
			    <HeaderTemplate>
			    <asp:Label ID="LabelWhatsNew" runat="server">
			        <h4><%#Eval("ModuleTitle")%></h4>
			    </asp:Label>
			    </HeaderTemplate>
			    <ItemTemplate>
			    
			<asp:Repeater ID="RepeaterWhatsUp" runat="server" DataSourceID="SqlDataSourceWhatsUp">
				<ItemTemplate>
			        <p><%#Eval("ModuleContent")%> - <%#Eval("DateCreated")%></p>
			        <hr />
			    </ItemTemplate>
			</asp:Repeater>
			    
			    </ItemTemplate>
			</asp:FormView>
                              
        </div>
	</div>

	<asp:ObjectDataSource ID="ObjectDataSource1" Runat="server" TypeName="PhotoManager" 
		SelectMethod="GetPhotos">
	</asp:ObjectDataSource>
    <asp:SqlDataSource ID="SqlDataSourceWelcome" runat="server" ConnectionString="<%$ ConnectionStrings:Personal %>" SelectCommand="SELECT * FROM SiteContent sc&#13;&#10;INNER JOIN Modules m ON&#13;&#10;sc.ModuleID = m.ModuleID&#13;&#10;WHERE m.ModuleID = @ModuleID">
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="ModuleID" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceBriefPosts" runat="server" ConnectionString="<%$ ConnectionStrings:Personal %>"
        SelectCommand="SELECT * FROM SiteContent sc&#13;&#10;INNER JOIN Modules m ON&#13;&#10;sc.ModuleID = m.ModuleID&#13;&#10;WHERE m.ModuleID = @ModuleID&#13;&#10;ORDER BY DateCreated DESC">
        <SelectParameters>
            <asp:Parameter DefaultValue="2" Name="ModuleID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceWhatsUp" runat="server" ConnectionString="<%$ ConnectionStrings:Personal %>"
        SelectCommand="SELECT * FROM SiteContent sc&#13;&#10;INNER JOIN Modules m ON&#13;&#10;sc.ModuleID = m.ModuleID&#13;&#10;WHERE m.ModuleID = @ModuleID&#13;&#10;ORDER BY DateCreated DESC">
        <SelectParameters>
            <asp:Parameter DefaultValue="3" Name="ModuleID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePieceOfWork" runat="server" ConnectionString="<%$ ConnectionStrings:Personal %>"
        SelectCommand="SELECT * FROM SiteContent sc&#13;&#10;INNER JOIN Modules m ON&#13;&#10;sc.ModuleID = m.ModuleID&#13;&#10;WHERE m.ModuleID = @ModuleID">
        <SelectParameters>
            <asp:Parameter DefaultValue="4" Name="ModuleID" />
        </SelectParameters>
    </asp:SqlDataSource>
    
</asp:content>
