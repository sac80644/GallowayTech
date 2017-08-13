<%@ Page Language="VB" ValidateRequest="false" MasterPageFile="~/Default.master" AutoEventWireup="false" CodeFile="Content.aspx.vb" Inherits="Admin_Content" title="GallowayTech | Content" %>

<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Personal %>"
        DeleteCommand="DELETE FROM [SiteContent] WHERE [ID] = @ID" InsertCommand="INSERT INTO [SiteContent] ([ModuleContent], [ModuleID], [DateCreated]) VALUES (@ModuleContent, @ModuleID, @DateCreated)"
        SelectCommand="SELECT * FROM SiteContent sc&#13;&#10;INNER JOIN Modules m ON&#13;&#10;sc.ModuleID = m.ModuleID&#13;&#10;ORDER BY ID, DateCreated" UpdateCommand="UPDATE [SiteContent] SET [ModuleContent] = @ModuleContent, [ModuleID] = @ModuleID, [DateCreated] = @DateCreated WHERE [ID] = @ID">
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
    &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
    <asp:DetailsView ID="DetailsView1" runat="server"
        AllowPaging="True" AutoGenerateRows="False" DataKeyNames="ID" DataSourceID="SqlDataSource1"
        Height="400px" Width="750" HorizontalAlign="Center" CellPadding="10">
        <Fields>
            <asp:BoundField DataField="ModuleName" HeaderText="ModuleName" InsertVisible="False"/>
            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                SortExpression="ID" />
            <asp:TemplateField HeaderText="ModuleContent" SortExpression="ModuleContent">
                <EditItemTemplate>
<!--                    <asp:TextBox Width="450" Height="300" TextMode="MultiLine" ID="TextBox1" runat="server" Text='<%# Bind("ModuleContent") %>'></asp:TextBox>  -->
                    
                    <FCKeditorV2:FCKeditor ID="FCKeditor1" runat="server" Width="600" Height="450" Value='<%# Bind("ModuleContent") %>'></FCKeditorV2:FCKeditor>
                    
                </EditItemTemplate>
                <InsertItemTemplate>
<!--                    <asp:TextBox Width="450" Height="300" TextMode="MultiLine" ID="TextBox1" runat="server" Text='<%# Bind("ModuleContent") %>'></asp:TextBox>  -->

                    <FCKeditorV2:FCKeditor ID="FCKeditor1" runat="server" Width="600" Height="450" Value='<%# Bind("ModuleContent") %>'></FCKeditorV2:FCKeditor>

                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("ModuleContent") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ModuleID" HeaderText="ModuleID" SortExpression="ModuleID" />
            <asp:BoundField DataField="DateCreated" HeaderText="DateCreated" SortExpression="DateCreated" />
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:CommandField>
        </Fields>
        <PagerSettings Mode="NumericFirstLast" />
        <RowStyle Font-Size="Medium" HorizontalAlign="Left"/>
        <PagerStyle Font-Size="Medium" HorizontalAlign="Center" VerticalAlign="Middle" />
    </asp:DetailsView>
    &nbsp;

</asp:Content>

