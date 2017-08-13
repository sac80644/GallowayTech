Partial Class Default_aspx
    Inherits System.Web.UI.Page

	Public Sub Randomize(ByVal sender As Object, ByVal e As EventArgs)
		Dim r As Random = New Random
		FormView1.PageIndex = r.Next(FormView1.PageCount)
	End Sub

End Class