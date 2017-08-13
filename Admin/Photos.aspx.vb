Partial Class Admin_Photos_aspx
    Inherits System.Web.UI.Page

    Sub FormView1_ItemInserting(ByVal sender As Object, ByVal e As FormViewInsertEventArgs)
        If (CType(e.Values("BytesOriginal"), [Byte]()).Length = 0) Then
            e.Cancel = True
        End If
    End Sub
    Sub Button1_Click(ByVal sender As Object, ByVal e As ImageClickEventArgs)
        Dim d As IO.DirectoryInfo = New IO.DirectoryInfo(Server.MapPath("~/Upload"))
        Dim enumerator As System.Collections.IEnumerator = CType(d.GetFiles("*.jpg"), System.Collections.IEnumerable).GetEnumerator
        Do While enumerator.MoveNext
            Dim f As IO.FileInfo = CType(enumerator.Current, IO.FileInfo)
            Dim buffer() As Byte = New Byte((f.OpenRead.Length) - 1) {}
            f.OpenRead.Read(buffer, 0, CType(f.OpenRead.Length, Integer))
			PhotoManager.AddPhoto([Convert].ToInt32(Request.QueryString("AlbumID")), f.Name, buffer)
        Loop
        GridView1.DataBind()
    End Sub

End Class
