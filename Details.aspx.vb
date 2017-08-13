Partial Class Details_aspx
    Inherits System.Web.UI.Page

	Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Page.MaintainScrollPositionOnPostBack = True
		If (IsPostBack = False) Then
			Dim i As Integer = [Convert].ToInt32(Request.QueryString("Page"))
			If (i >= 0) Then
				FormView1.PageIndex = i
			End If
		End If
	End Sub

End Class