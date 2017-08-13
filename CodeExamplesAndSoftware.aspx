<%@ Page Language="VB" MasterPageFile="~/Default.master" AutoEventWireup="false" CodeFile="CodeExamplesAndSoftware.aspx.vb" Inherits="DevelopersCorner" title="GallowayTech | CodeExamplesAndSoftware" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">


	<div class="shim column"></div>

	<div class="page" id="home">
	
		<div id="sidebar">
		    <div id="software">
				<h4>Software</h4>
				I'll be posting software examples here, whole code projects 
				of simple stuff to things I use everyday...<br /><br />
                <asp:TreeView ID="TreeViewSoftware" runat="server" Width="184px">
                </asp:TreeView>
                
                <ul>
                
                <asp:DataList ID="FilesInFolder" runat="server" Width="100%" CellPadding="0">
                <ItemTemplate>
                    <%--<b><asp:Label runat="server" ID="FileNameLabel" Text='<%# System.IO.Path.GetFilenameWithoutExtension(Eval("Name")) %>'></asp:Label></b>--%>
                    <li>
                    <asp:HyperLink runat="server" ID="FileLink" Text='<%# System.IO.Path.GetFilenameWithoutExtension(Eval("Name")) %>' NavigateUrl='<%# TreeViewSoftware.SelectedValue & Eval("Name").ToString() %>' />
                    </li>
                </ItemTemplate>
                </asp:DataList>
                
                </ul>
			</div>
		</div>

        <div id="content">
        			
			<asp:FormView ID="FormViewTipsAndTricks" Width="100%" runat="server" DataSourceID="SqlDataSourceCodeExamplesAndSoftware">
			    <HeaderTemplate>
			    <asp:Label ID="LabelTipsAndTricks" runat="server">
			        <h4><%#Eval("ModuleTitle")%></h4>
			    </asp:Label>
			    </HeaderTemplate>
			    <ItemTemplate>
			    
			<asp:Repeater ID="RepeaterTipsAndTricks" runat="server" DataSourceID="SqlDataSourceCodeExamplesAndSoftware">
				<ItemTemplate>
			        <p><%#Eval("ModuleContent")%> - <%#Eval("DateCreated")%></p>
			        <hr />
			    </ItemTemplate>
			</asp:Repeater>
			    
			    </ItemTemplate>
			</asp:FormView>

        </div>
	</div>
    <asp:SqlDataSource ID="SqlDataSourceCodeExamplesAndSoftware" runat="server" ConnectionString="<%$ ConnectionStrings:Personal %>"
        SelectCommand="SELECT * FROM SiteContent sc&#13;&#10;INNER JOIN Modules m ON&#13;&#10;sc.ModuleID = m.ModuleID&#13;&#10;WHERE m.ModuleID = @ModuleID&#13;&#10;ORDER BY sc.DateCreated DESC" DeleteCommand="DELETE FROM [SiteContent] WHERE [ID] = @ID" InsertCommand="INSERT INTO [SiteContent] ([ModuleContent], [ModuleID], [DateCreated]) VALUES (@ModuleContent, @ModuleID, @DateCreated)" UpdateCommand="UPDATE [SiteContent] SET [ModuleContent] = @ModuleContent, [ModuleID] = @ModuleID, [DateCreated] = @DateCreated WHERE [ID] = @ID">
        <SelectParameters>
            <asp:Parameter DefaultValue="6" Name="ModuleID" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ModuleContent" Type="String" />
            <asp:Parameter Name="ModuleID" Type="Int32" />
            <asp:Parameter Name="DateCreated" Type="DateTime" />
            <asp:Parameter Name="ID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="ModuleContent" Type="String" />
            <asp:Parameter Name="ModuleID" Type="Int32" />
            <asp:Parameter Name="DateCreated" Type="DateTime" />
        </InsertParameters>
    </asp:SqlDataSource>

</asp:Content>

