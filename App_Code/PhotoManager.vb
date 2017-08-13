Imports System
Imports System.Collections
Imports System.Collections.Generic
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing
Imports System.Drawing.Drawing2D
Imports System.Drawing.Imaging
Imports System.IO

Public Class PhotoManager

	' Photo-Related Methods

	Public Overloads Shared Function GetPhoto(ByVal photoid As Integer, ByVal size As PhotoSize) As Stream
		Using connection As New SqlConnection(ConfigurationManager.ConnectionStrings("Personal").ConnectionString)
			Using command As New SqlCommand("GetPhoto", connection)
				command.CommandType = CommandType.StoredProcedure
				command.Parameters.Add(New SqlParameter("@PhotoID", photoid))
				command.Parameters.Add(New SqlParameter("@Size", CType(size, Integer)))
				Dim Filter As Boolean = Not (HttpContext.Current.User.IsInRole("Friends") Or HttpContext.Current.User.IsInRole("Administrators"))
				command.Parameters.Add(New SqlParameter("@IsPublic", Filter))
				connection.Open()
				Dim result As Object = command.ExecuteScalar
				Try
					Return New MemoryStream(CType(result, Byte()))
				Catch
					Return Nothing
				End Try
			End Using
		End Using
	End Function

	Public Overloads Shared Function GetPhoto(ByVal size As PhotoSize) As Stream
		Dim path As String = HttpContext.Current.Server.MapPath("~/Images/")
		If (size = PhotoSize.Small) Then
			path = (path + "placeholder-100.jpg")
		Else
			If (size = PhotoSize.Medium) Then
				path = (path + "placeholder-200.jpg")
			Else
				If (size = PhotoSize.Large) Then
					path = (path + "placeholder-600.jpg")
				Else
					path = (path + "placeholder-600.jpg")
				End If
			End If
		End If
		Return New FileStream(path, FileMode.Open, FileAccess.Read, FileShare.Read)
	End Function

	Public Shared Function GetFirstPhoto(ByVal albumid As Integer, ByVal size As PhotoSize) As Stream
		Using connection As New SqlConnection(ConfigurationManager.ConnectionStrings("Personal").ConnectionString)
			Using command As New SqlCommand("GetFirstPhoto", connection)
				command.CommandType = CommandType.StoredProcedure
				command.Parameters.Add(New SqlParameter("@AlbumID", albumid))
				command.Parameters.Add(New SqlParameter("@Size", CType(size, Integer)))
				Dim Filter As Boolean = Not (HttpContext.Current.User.IsInRole("Friends") Or HttpContext.Current.User.IsInRole("Administrators"))
				command.Parameters.Add(New SqlParameter("@IsPublic", Filter))
				connection.Open()
				Dim result As Object = command.ExecuteScalar
				Try
					Return New MemoryStream(CType(result, Byte()))
				Catch e As ArgumentNullException
					Return Nothing
				End Try
			End Using
		End Using
	End Function

	Public Shared Function GetPhotos(ByVal AlbumID As Integer) As Generic.List(Of Photo)
		Using connection As New SqlConnection(ConfigurationManager.ConnectionStrings("Personal").ConnectionString)
			Using command As New SqlCommand("GetPhotos", connection)
				command.CommandType = CommandType.StoredProcedure
				command.Parameters.Add(New SqlParameter("@AlbumID", AlbumID))
				Dim Filter As Boolean = Not (HttpContext.Current.User.IsInRole("Friends") Or HttpContext.Current.User.IsInRole("Administrators"))
				command.Parameters.Add(New SqlParameter("@IsPublic", Filter))
				connection.Open()
				Dim list As New Generic.List(Of Photo)()
				Using reader As SqlDataReader = command.ExecuteReader()
					Do While (reader.Read())
						Dim temp As New Photo(CInt(reader("PhotoID")), CInt(reader("AlbumID")), CStr(reader("Caption")))
						list.Add(temp)
					Loop
				End Using
				Return list
			End Using
		End Using
	End Function

	Public Shared Function GetPhotos() As Generic.List(Of Photo)
		Return GetPhotos(GetRandomAlbumID())
	End Function

	' Album-Related Methods

	Public Shared Sub AddPhoto(ByVal AlbumID As Integer, ByVal Caption As String, ByVal BytesOriginal() As Byte)
		Using connection As New SqlConnection(ConfigurationManager.ConnectionStrings("Personal").ConnectionString)
			Using command As New SqlCommand("AddPhoto", connection)
				command.CommandType = CommandType.StoredProcedure
				command.Parameters.Add(New SqlParameter("@AlbumID", AlbumID))
				command.Parameters.Add(New SqlParameter("@Caption", Caption))
				command.Parameters.Add(New SqlParameter("@BytesOriginal", BytesOriginal))
				command.Parameters.Add(New SqlParameter("@BytesFull", ResizeImageFile(BytesOriginal, 600)))
				command.Parameters.Add(New SqlParameter("@BytesPoster", ResizeImageFile(BytesOriginal, 198)))
				command.Parameters.Add(New SqlParameter("@BytesThumb", ResizeImageFile(BytesOriginal, 100)))
				connection.Open()
				command.ExecuteNonQuery()
			End Using
		End Using
	End Sub

	Public Shared Sub RemovePhoto(ByVal PhotoID As Integer)
		Using connection As New SqlConnection(ConfigurationManager.ConnectionStrings("Personal").ConnectionString)
			Using command As New SqlCommand("RemovePhoto", connection)
				command.CommandType = CommandType.StoredProcedure
				command.Parameters.Add(New SqlParameter("@PhotoID", PhotoID))
				connection.Open()
				command.ExecuteNonQuery()
			End Using
		End Using
	End Sub

	Public Shared Sub EditPhoto(ByVal Caption As String, ByVal PhotoID As Integer)
		Using connection As New SqlConnection(ConfigurationManager.ConnectionStrings("Personal").ConnectionString)
			Using command As New SqlCommand("EditPhoto", connection)
				command.CommandType = CommandType.StoredProcedure
				command.Parameters.Add(New SqlParameter("@Caption", Caption))
				command.Parameters.Add(New SqlParameter("@PhotoID", PhotoID))
				connection.Open()
				command.ExecuteNonQuery()
			End Using
		End Using
	End Sub

	Public Shared Function GetAlbums() As Generic.List(Of Album)
		Using connection As New SqlConnection(ConfigurationManager.ConnectionStrings("Personal").ConnectionString)
			Using command As New SqlCommand("GetAlbums", connection)
				command.CommandType = CommandType.StoredProcedure
				Dim Filter As Boolean = Not (HttpContext.Current.User.IsInRole("Friends") Or HttpContext.Current.User.IsInRole("Administrators"))
				command.Parameters.Add(New SqlParameter("@IsPublic", Filter))
				connection.Open()
				Dim list As New Generic.List(Of Album)()
				Using reader As SqlDataReader = command.ExecuteReader()
					Do While (reader.Read())
						Dim temp As New Album(CInt(reader("AlbumID")), CInt(reader("NumberOfPhotos")), CStr(reader("Caption")), CBool(reader("IsPublic")))
						list.Add(temp)
					Loop
				End Using
				Return list
			End Using
		End Using
	End Function

	Public Shared Sub AddAlbum(ByVal Caption As String, ByVal IsPublic As Boolean)
		Using connection As New SqlConnection(ConfigurationManager.ConnectionStrings("Personal").ConnectionString)
			Using command As New SqlCommand("AddAlbum", connection)
				command.CommandType = CommandType.StoredProcedure
				command.Parameters.Add(New SqlParameter("@Caption", Caption))
				command.Parameters.Add(New SqlParameter("@IsPublic", IsPublic))
				connection.Open()
				command.ExecuteNonQuery()
			End Using
		End Using
	End Sub

	Public Shared Sub RemoveAlbum(ByVal AlbumID As Integer)
		Using connection As New SqlConnection(ConfigurationManager.ConnectionStrings("Personal").ConnectionString)
			Using command As New SqlCommand("RemoveAlbum", connection)
				command.CommandType = CommandType.StoredProcedure
				command.Parameters.Add(New SqlParameter("@AlbumID", AlbumID))
				connection.Open()
				command.ExecuteNonQuery()
			End Using
		End Using
	End Sub

	Public Shared Sub EditAlbum(ByVal Caption As String, ByVal IsPublic As Boolean, ByVal AlbumID As Integer)
		Using connection As New SqlConnection(ConfigurationManager.ConnectionStrings("Personal").ConnectionString)
			Using command As New SqlCommand("EditAlbum", connection)
				command.CommandType = CommandType.StoredProcedure
				command.Parameters.Add(New SqlParameter("@Caption", Caption))
				command.Parameters.Add(New SqlParameter("@IsPublic", IsPublic))
				command.Parameters.Add(New SqlParameter("@AlbumID", AlbumID))
				connection.Open()
				command.ExecuteNonQuery()
			End Using
		End Using
	End Sub

	Public Shared Function GetRandomAlbumID() As Integer
		Using connection As New SqlConnection(ConfigurationManager.ConnectionStrings("Personal").ConnectionString)
			Using command As New SqlCommand("GetNonEmptyAlbums", connection)
				command.CommandType = CommandType.StoredProcedure
				connection.Open()
				Dim list As New Generic.List(Of Album)()
				Using reader As SqlDataReader = command.ExecuteReader
					Do While reader.Read
						Dim temp As New Album(CType(reader("AlbumID"), Integer), 0, "", False)
						list.Add(temp)
					Loop
				End Using
				Try
					Dim r As Random = New Random
					Return list(r.Next(list.Count)).AlbumID
				Catch e As ArgumentOutOfRangeException
					Return -1
				End Try
			End Using
		End Using
	End Function

	' Auxiliary Functions

	Private Shared Function ResizeImageFile(ByVal imageFile() As Byte, ByVal targetSize As Integer) As Byte()
		Using oldImage As System.Drawing.Image = System.Drawing.Image.FromStream(New MemoryStream(imageFile))
			Dim newSize As Size = CalculateDimensions(oldImage.Size, targetSize)
			Using newImage As Bitmap = New Bitmap(newSize.Width, newSize.Height, PixelFormat.Format24bppRgb)
				Using canvas As Graphics = Graphics.FromImage(newImage)
					canvas.SmoothingMode = SmoothingMode.AntiAlias
					canvas.InterpolationMode = InterpolationMode.HighQualityBicubic
					canvas.PixelOffsetMode = PixelOffsetMode.HighQuality
					canvas.DrawImage(oldImage, New Rectangle(New Point(0, 0), newSize))
					Dim m As New MemoryStream
					newImage.Save(m, ImageFormat.Jpeg)
					Return m.GetBuffer
				End Using
			End Using
		End Using
	End Function

	Private Shared Function CalculateDimensions(ByVal oldSize As Size, ByVal targetSize As Integer) As Size
		Dim newSize As Size
		If (oldSize.Height > oldSize.Width) Then
			newSize.Width = CType((oldSize.Width * CType((targetSize / CType(oldSize.Height, Single)), Single)), Integer)
			newSize.Height = targetSize
		Else
			newSize.Width = targetSize
			newSize.Height = CType((oldSize.Height * CType((targetSize / CType(oldSize.Width, Single)), Single)), Integer)
		End If
		Return newSize
	End Function

	Public Shared Function ListUploadDirectory() As ICollection
		Dim d As DirectoryInfo = New DirectoryInfo(System.Web.HttpContext.Current.Server.MapPath("~/Upload"))
		Return d.GetFileSystemInfos("*.jpg")
	End Function

End Class