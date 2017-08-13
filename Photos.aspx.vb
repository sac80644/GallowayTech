Partial Class Photos_aspx
    Inherits System.Web.UI.Page

	Sub DataList1_ItemDataBound(ByVal sender As Object, ByVal e As DataListItemEventArgs)
		If (e.Item.ItemType = ListItemType.Footer) Then
			If (DataList1.Items.Count = 0) Then
				Panel1.Visible = True
			End If
		End If
	End Sub

End Class