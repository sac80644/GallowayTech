<%@ Page Language="VB" MasterPageFile="~/Default.master" AutoEventWireup="false" CodeFile="Login.aspx.vb" Inherits="Login" title="GallowayTech | Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Main" Runat="Server">

<div class="shim column"></div>

    <div class="page" id="admin-albums">

        <div id="sidebar">
          <h3>Login for administation purposes only.</h3>
        </div>
    
        <div id="content">
          
        <asp:LoginView ID="LoginArea" runat="server">
            <LoggedInTemplate>
                <h4>
                    <asp:LoginName ID="LoginName1" runat="server" FormatString="Welcome&#9;{0}!" />
                </h4>
            </LoggedInTemplate>
            <AnonymousTemplate>
                <asp:Login ID="Login1" runat="server">
                    <LayoutTemplate>
                        <div class="login">
                            <h4>
                                Login to Site</h4>
                            <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" CssClass="label">User Name</asp:Label>
                            <asp:TextBox ID="UserName" runat="server" AccessKey="u" CssClass="textbox"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                ErrorMessage="User Name is required." ToolTip="User Name&#9;is required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" CssClass="label">Password</asp:Label>
                            <asp:TextBox ID="Password" runat="server" AccessKey="p" CssClass="textbox" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                ToolTip="Password is&#9;required." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                            <div>
                                <asp:CheckBox ID="RememberMe" runat="server" Text="Remember me&#9;next time" /></div>
                            <asp:ImageButton ID="LoginButton" runat="server" AlternateText="login" CommandName="Login"
                                CssClass="button" SkinID="login" />
                             <a class="button" href="register.aspx">
                                <asp:Image ID="Image1" runat="server" AlternateText="create&#9;a new account" SkinID="create" Visible="False" /></a>
                            <p>
                                <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal></p>
                        </div>
                    </LayoutTemplate>
                </asp:Login>
            </AnonymousTemplate>
        </asp:LoginView>
        </div>
    
    </div>
    
</asp:Content>

