<%@ Application Language="VB" %>

<script runat="server">

	Sub Application_Start(ByVal sender As [Object], ByVal e As EventArgs)
		AddHandler SiteMap.SiteMapResolve, AddressOf Me.AppendQueryString
		If (Roles.RoleExists("Administrators") = False) Then
			Roles.CreateRole("Administrators")
		End If
		If (Roles.RoleExists("Friends") = False) Then
			Roles.CreateRole("Friends")
        End If
        
        Application("Hits") = 0
        Application("Sessions") = 0
        Application("TerminatedSessions") = 0
        
    End Sub
    
    'The BeginRequest event is fired for every hit to every page in the site
    Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)
 
        Application.Lock()
        Application("Hits") = CType(Application("Hits"), Integer) + 1
        Application.UnLock()
    End Sub
 
    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        Application.Lock()
        Application("Sessions") = CType(Application("Sessions"), Integer) + 1
        Application.UnLock()
    End Sub
 
    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        Application.Lock()
        Application("TerminatedSessions") = CType(Application("TerminatedSessions"), Integer) + 1
        Application.UnLock()
    End Sub
    
    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        'Write out our statistics to a log file
        '...code omitted...
    End Sub
        


    Function AppendQueryString(ByVal o As [Object], ByVal e As SiteMapResolveEventArgs) As SiteMapNode
        If (Not (SiteMap.CurrentNode) Is Nothing) Then
            Dim temp As SiteMapNode
            temp = SiteMap.CurrentNode.Clone(True)
            Dim u As Uri = New Uri(e.Context.Request.Url.ToString)
            temp.Url = (temp.Url + u.Query)
            If (Not (temp.ParentNode) Is Nothing) Then
                temp.ParentNode.Url = (temp.ParentNode.Url + u.Query)
            End If
            Return temp
        Else
            Return Nothing
        End If
    End Function

</script>