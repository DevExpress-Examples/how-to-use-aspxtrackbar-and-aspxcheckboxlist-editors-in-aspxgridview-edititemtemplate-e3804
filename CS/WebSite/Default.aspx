<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v15.1, Version=15.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <dx:ASPxGridView ID="gridViewData" runat="server" AutoGenerateColumns="False" DataSourceID="accDSProducts"
            KeyFieldName="ProductID" OnRowUpdating="gridViewData_RowUpdating">
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowEditButton="True"/>
                <dx:GridViewDataTextColumn FieldName="ProductID" ReadOnly="True" VisibleIndex="1">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ProductName" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="UnitPrice" VisibleIndex="3">
                    <EditItemTemplate>
                        <dx:ASPxTrackBar ID="tkbrUnitPrice" runat="server" Width="100%" MinValue="0" MaxValue="200"
                            Step="0.25" SmallTickFrequency="5" LargeTickStartValue="0" LargeTickEndValue="200"
                            LargeTickInterval="25" ValueToolTipPosition="RightOrBottom" ScalePosition="LeftOrTop"
                            Value='<%# Bind("UnitPrice") %>'>
                        </dx:ASPxTrackBar>
                    </EditItemTemplate>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="EAN13" VisibleIndex="4">
                    <EditItemTemplate>
                        <dx:ASPxCheckBoxList ID="cblSuppliers" runat="server" DataSourceID="accDSSuppliers"
                            TextField="ContactName" ValueField="SupplierID" ValueType="System.Int32" Width="100%"
                            RepeatColumns="3" OnDataBound="cblSuppliers_DataBound">
                        </dx:ASPxCheckBoxList>
                    </EditItemTemplate>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsEditing EditFormColumnCount="1" />
        </dx:ASPxGridView>
        <asp:AccessDataSource ID="accDSProducts" runat="server" DataFile="~/App_Data/nwind.mdb"
            DeleteCommand="DELETE FROM [Products] WHERE [ProductID] = ?" InsertCommand="INSERT INTO [Products] ([ProductID], [ProductName], [UnitPrice], [EAN13]) VALUES (?, ?, ?, ?)"
            SelectCommand="SELECT [ProductID], [ProductName], [UnitPrice], [EAN13] FROM [Products]"
            UpdateCommand="UPDATE [Products] SET [ProductName] = ?, [UnitPrice] = ?, [EAN13] = ? WHERE [ProductID] = ?">
            <DeleteParameters>
                <asp:Parameter Name="ProductID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="ProductName" Type="String" />
                <asp:Parameter Name="UnitPrice" Type="Decimal" />
                <asp:Parameter Name="EAN13" Type="String" />
                <asp:Parameter Name="ProductID" Type="Int32" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="ProductID" Type="Int32" />
                <asp:Parameter Name="ProductName" Type="String" />
                <asp:Parameter Name="UnitPrice" Type="Decimal" />
                <asp:Parameter Name="EAN13" Type="String" />
            </InsertParameters>
        </asp:AccessDataSource>
        <asp:AccessDataSource ID="accDSSuppliers" runat="server" DataFile="~/App_Data/nwind.mdb"
            SelectCommand="SELECT [SupplierID], [ContactName] FROM [Suppliers]"></asp:AccessDataSource>
    </div>
    </form>
</body>
</html>
