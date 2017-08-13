Public Class Album

	Private _id As Integer
	Private _count As Integer
	Private _caption As String
	Private _ispublic As Boolean

	Public Sub New(ByVal id As Integer, ByVal count As Integer, ByVal caption As String, ByVal ispublic As Boolean)
		MyBase.New()
		_id = id
		_count = count
		_caption = caption
		_ispublic = ispublic
	End Sub

	Public ReadOnly Property AlbumID() As Integer
		Get
			Return _id
		End Get
	End Property

	Public ReadOnly Property Count() As Integer
		Get
			Return _count
		End Get
	End Property

	Public ReadOnly Property Caption() As String
		Get
			Return _caption
		End Get
	End Property

	Public ReadOnly Property IsPublic() As Boolean
		Get
			Return _ispublic
		End Get
	End Property

End Class
