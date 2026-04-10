namespace GetUse.Academy.Bookstore.InterfaceList;
using Microsoft.Sales.Customer;

codeunit 50109 "Check Customer Blocked" implements "Check Step"
{
    procedure Execute(RecRef: RecordRef): Text
    var
        Customer: Record Customer;
    begin
        if RecRef.Number <> Database::Customer then
            exit;

        RecRef.SetTable(Customer);
        if Customer.Blocked <> "Customer Blocked"::" " then
            exit(StrSubstNo('100: Customer is blocked in level %1', Customer.Blocked));
    end;

    procedure GetSequence(): Integer
    begin
        exit(100);
    end;

    procedure IsEnabled(RecRef: RecordRef): Boolean
    begin
        exit(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Check Pipeline", OnRegisterCheckSteps, '', false, false)]
    local procedure "Check Pipeline_OnRegisterCheckSteps"(var Steps: List of [Interface "Check Step"]; RecRef: RecordRef)
    begin
        if RecRef.Number = Database::Customer then
            Steps.Add(this);
    end;
}