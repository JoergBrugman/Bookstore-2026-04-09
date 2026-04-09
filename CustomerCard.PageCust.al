namespace GetUse.Academy.Bookstore;

using Microsoft.Sales.Customer;

pagecustomization "Customer Card" customizes "Customer Card"
{
    layout
    {
        modify("Location Code") { Visible = false; }
    }
    actions
    {
        movebefore(NewSalesInvoice; NewSalesOrder)
    }
}