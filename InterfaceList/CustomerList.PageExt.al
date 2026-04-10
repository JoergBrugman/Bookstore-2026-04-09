namespace GetUse.Academy.Bookstore.InterfaceList;
using Microsoft.Sales.Customer;

pageextension 50104 "Customer List" extends "Customer List"
{
    actions
    {
        addlast(processing)
        {
            action(CustomerCheckPipeline)
            {
                Caption = 'Customer Check Pipeline';
                ApplicationArea = All;
                Image = Process;
                ToolTip = 'Executes the Customer Check Pipeline action.';

                trigger OnAction()
                var
                    CheckPipeline: Codeunit "Check Pipeline";
                begin
                    CheckPipeline.ProcessPipeline(Rec);
                end;
            }
        }
    }
}