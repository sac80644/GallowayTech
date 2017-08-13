Public Class Photo

	Private _id As Integer
	Private _albumid As Integer
	Private _caption As String

	Public Sub New(ByVal id As Integer, ByVal albumid As Integer, ByVal caption As String)
		MyBase.New()
		_id = id
		_albumid = albumid
		_caption = caption
	End Sub

	Public ReadOnly Property PhotoID() As Integer
		Get
			Return _id
		End Get
	End Property

	Public ReadOnly Property AlbumID() As Integer
		Get
			Return _albumid
		End Get
	End Property

	Public ReadOnly Property Caption() As String
		Get
			Return _caption
		End Get
	End Property

End Class