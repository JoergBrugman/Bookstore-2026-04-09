namespace GetUse.Academy.Bookstore.Demo.This;

codeunit 50102 "This-Demo Client"
{
    procedure ThisClientProcedure(ThisDemoCodeunit: Codeunit "This-Demo")
    begin
        Message('In Client-CU: %1', ThisDemoCodeunit.GetStateVar());
        ThisDemoCodeunit.SetStateVar('Level 3 (Client)');
        Message('In Client-CU: %1', ThisDemoCodeunit.GetStateVar());
    end;
}