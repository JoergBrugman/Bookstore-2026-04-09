namespace GetUse.Academy.Bookstore.Demo.Resources;
using GetUse.Academy.Bookstore;
using Microsoft.Sales.Customer;

pageextension 50103 "Book List Resources Demo" extends "Book List"
{
    actions
    {
        addlast(Demo)
        {
            action(ResourceListDemo)
            {
                Caption = 'Resource List';
                ApplicationArea = All;
                Image = Process;
                ToolTip = 'Executes the Resource List action.';

                trigger OnAction()
                var
                    ResourceList: List of [Text];
                    Txt: Text;
                    TxtBuilder: TextBuilder;
                begin
                    ResourceList := NavApp.ListResources();
                    foreach Txt in ResourceList do
                        TxtBuilder.AppendLine(Txt);
                    Message(TxtBuilder.ToText());
                end;
            }
            action(ResourceCSV)
            {
                Caption = 'Read CSV';
                ApplicationArea = All;
                Image = Process;
                ToolTip = 'Executes the Read CSV action.';

                trigger OnAction()
                var
                    ResourceStr: InStream;
                    Txt: Text;
                    TxtBuilder: TextBuilder;
                begin
                    NavApp.GetResource('ProgrammingLanguages.csv', ResourceStr);
                    while not ResourceStr.EOS do begin
                        ResourceStr.ReadText(Txt);
                        TxtBuilder.AppendLine(Txt);
                    end;
                    Message(TxtBuilder.ToText());
                end;
            }
            action(ResourcePNGDem)
            {
                Caption = 'Read PNG to Customer';
                ApplicationArea = All;
                Image = Process;
                ToolTip = 'Executes the Read PNG to Customer action.';

                trigger OnAction()
                var
                    Customer: Record Customer;
                    ResourceStr: InStream;
                begin
                    NavApp.GetResource('Dynamics_365_Business_Central_logo.png', ResourceStr);

                    Customer.Init();
                    CUstomer."No." := '';
                    Customer.Insert(true);
                    Customer.Image.ImportStream(ResourceStr, 'Demo Picture');
                    Customer.Modify();
                    Page.Run(Page::"Customer Card", Customer);
                end;
            }
        }
    }
}