namespace GetUse.Academy.Bookstore.Demo.This;
using GetUse.Academy.Bookstore;

pageextension 50102 "Book List This Demo" extends "Book List"
{
    actions
    {
        addlast(Processing)
        {
            group(Demo)
            {
                Caption = 'Demo';

                action(ThisDemo)
                {
                    Caption = 'This Demo';
                    ApplicationArea = All;
                    Image = Process;
                    ToolTip = 'Executes the This Demo action.';
                    RunObject = codeunit "This-Demo";
                }
            }
        }
    }
}