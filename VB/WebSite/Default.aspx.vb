Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web.UI
Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.Data

Partial Public Class _Default
	Inherits System.Web.UI.Page
	Protected Sub cblSuppliers_DataBound(ByVal sender As Object, ByVal e As EventArgs)
		Dim cbl As ASPxCheckBoxList = TryCast(sender, ASPxCheckBoxList)
		Dim container As GridViewEditItemTemplateContainer = TryCast(cbl.NamingContainer, GridViewEditItemTemplateContainer)

		Dim ean13Value As Object = DataBinder.Eval(container.DataItem, "EAN13")
		Dim ean13 As String = If((ean13Value Is Nothing), String.Empty, ean13Value.ToString())

		Dim idString() As String = ean13.Split(","c)
		Dim supplierID(idString.Length - 1) As Integer

		For i As Integer = 0 To idString.Length - 1
			If (Not Integer.TryParse(idString(i), supplierID(i))) Then
				Return
			End If
		Next i

		For Each Item As ListEditItem In cbl.Items
            If supplierID.Contains(CInt(Fix(Item.Value))) Then
                Item.Selected = True
            End If
		Next Item
	End Sub

	Protected Sub gridViewData_RowUpdating(ByVal sender As Object, ByVal e As ASPxDataUpdatingEventArgs)
		Dim grid As ASPxGridView = TryCast(sender, ASPxGridView)
		Dim cbl As ASPxCheckBoxList = TryCast(grid.FindEditRowCellTemplateControl(TryCast(grid.Columns("EAN13"), GridViewDataColumn), "cblSuppliers"), ASPxCheckBoxList)

		Dim ean13 As String = String.Empty
		If cbl.SelectedItems.Count > 0 Then
			For Each supplierID As Integer In cbl.SelectedValues
				ean13 &= supplierID.ToString() & ","c
			Next supplierID
			ean13 = ean13.Trim(","c)
		End If
		e.NewValues("EAN13") = ean13

		e.Cancel = True 'COMMENT THIS LINE TO ALLOW UPDATING
	End Sub
End Class
