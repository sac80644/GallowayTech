
Partial Class DevelopersCorner
    Inherits System.Web.UI.Page

    Dim _FileSystem As New FileSystem

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            _FileSystem.PopulateTree(Me.TreeViewSoftware)
        End If
    End Sub

    Protected Sub TreeViewSoftware_SelectedNodeChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TreeViewSoftware.SelectedNodeChanged
        'Refresh the DataList whenever a new node is selected
        _FileSystem.GetFilesInFolder(Me.TreeViewSoftware.SelectedValue, Me.FilesInFolder)
    End Sub
End Class
