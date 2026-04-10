namespace GetUse.Academy.Bookstore.InterfaceList;
using Microsoft.Sales.Customer;

codeunit 50112 "Check Customer Foreign Loc" implements "Check Step"
{
    procedure Execute(RecRef: RecordRef): Text
    var
        Customer: Record Customer;
    begin
        if RecRef.Number <> Database::Customer then
            exit;
        RecRef.SetTable(Customer);

        if Customer."Location Code" <> 'GELB' then
            exit(StrSubstNo('50: Foreign Customer should have location GELB and not %1', Customer."Location Code"));
    end;

    procedure GetSequence(): Integer
    begin
        exit(50);
    end;

    procedure IsEnabled(RecRef: RecordRef): Boolean
    var
        Customer: Record Customer;
    begin
        if RecRef.Number <> Database::Customer then
            exit;
        RecRef.SetTable(Customer);
        exit(Customer."Country/Region Code" <> '');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Check Pipeline", OnRegisterCheckSteps, '', false, false)]
    local procedure "Check Pipeline_OnRegisterCheckSteps"(var Steps: List of [Interface "Check Step"]; RecRef: RecordRef)
    begin
        if RecRef.Number = Database::Customer then
            Steps.Add(this);
    end;

}