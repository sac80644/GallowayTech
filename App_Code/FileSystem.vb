Imports Microsoft.VisualBasic
Imports System.IO

Public Class FileSystem
    Private Const VirtualImageRoot = "~/Downloads/Software/"
    Public Sub PopulateTree(ByRef Tree As TreeView)
        'Populate the tree based on the subfolders of the specified VirtualImageRoot
        Dim rootFolder As New DirectoryInfo(HttpContext.Current.Server.MapPath(VirtualImageRoot))
        Dim root As TreeNode = AddNodeAndDescendents(rootFolder, Nothing)

        'Add the root to the TreeView
        Tree.Nodes.Add(root)
    End Sub

    Private Function AddNodeAndDescendents(ByVal folder As DirectoryInfo, ByVal parentNode As TreeNode) As TreeNode
        'Add the TreeNode, displaying the folder's name and storing the full path to the folder as the value...
        Dim virtualFolderPath As String
        If parentNode Is Nothing Then
            virtualFolderPath = VirtualImageRoot
        Else
            virtualFolderPath = parentNode.Value & folder.Name & "/"
        End If

        Dim node As New TreeNode(folder.Name, virtualFolderPath)

        'Recurse through this folder's subfolders
        Dim subFolders As DirectoryInfo() = folder.GetDirectories()
        For Each subFolder As DirectoryInfo In subFolders
            Dim child As TreeNode = AddNodeAndDescendents(subFolder, node)
            node.ChildNodes.Add(child)
        Next

        Return node     'Return the new TreeNode
    End Function


    Public Sub GetFilesInFolder(ByVal virtualFolderPath As String, ByVal _DataList As DataList)
        'Security check: make sure folderPath starts with VirtualImageRoot and doesn't include any ".."
        If Not virtualFolderPath.StartsWith(VirtualImageRoot) OrElse virtualFolderPath.IndexOf("..") >= 0 Then
            Throw New ApplicationException("Attempting to view a folder outside of the public image folder!")
        End If

        'Get information about the files in the specified folder
        Dim folder As New DirectoryInfo(HttpContext.Current.Server.MapPath(virtualFolderPath))
        Dim fileList As FileInfo() = folder.GetFiles()

        _DataList.DataSource = fileList
        _DataList.DataBind()
    End Sub
End Class
