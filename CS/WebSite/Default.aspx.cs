using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using DevExpress.Web;
using DevExpress.Web.Data;

public partial class _Default : System.Web.UI.Page {
    protected void cblSuppliers_DataBound(object sender, EventArgs e) {
        ASPxCheckBoxList cbl = sender as ASPxCheckBoxList;
        GridViewEditItemTemplateContainer container = cbl.NamingContainer as GridViewEditItemTemplateContainer;

        object ean13Value = DataBinder.Eval(container.DataItem, "EAN13");
        string ean13 = (ean13Value == null) ? String.Empty : ean13Value.ToString();

        string[] idString = ean13.Split(',');
        int[] supplierID = new int[idString.Length];

        for(int i = 0; i < idString.Length; i++) {
            if(!int.TryParse(idString[i], out supplierID[i]))
                return;
        }

        foreach(ListEditItem Item in cbl.Items) {
            if(supplierID.Contains<int>((int)Item.Value)) {
                Item.Selected = true;
            }
        }
    }

    protected void gridViewData_RowUpdating(object sender, ASPxDataUpdatingEventArgs e) {
        ASPxGridView grid = sender as ASPxGridView;
        ASPxCheckBoxList cbl = grid.FindEditRowCellTemplateControl(grid.Columns["EAN13"] as GridViewDataColumn, "cblSuppliers") as ASPxCheckBoxList;

        string ean13 = String.Empty;
        if(cbl.SelectedItems.Count > 0) {
            foreach(int supplierID in cbl.SelectedValues) {
                ean13 += supplierID.ToString() + ',';
            }
            ean13 = ean13.Trim(',');
        }
        e.NewValues["EAN13"] = ean13;

        e.Cancel = true; //COMMENT THIS LINE TO ALLOW UPDATING
    }
}
