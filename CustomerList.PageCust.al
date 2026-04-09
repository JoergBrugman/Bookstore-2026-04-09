namespace GetUse.Academy.Bookstore;

using Microsoft.Sales.Customer;

pagecustomization "Customer List" customizes "Customer List"
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