namespace GetUse.Academy.Bookstore.InterfaceList;
using Microsoft.Sales.Customer;

codeunit 50111 "Check Customer Foreign Bill" implements "Check Step"
{
    procedure Execute(RecRef: RecordRef): Text
    var
        Customer: Record Customer;
    begin
        if RecRef.Number <> Database::Customer then
            exit;
        RecRef.SetTable(Customer);

        if Customer."Bill-to Customer No." <> '' then
            exit(StrSubstNo('200: Foreign Customer must not have  %1', Customer.FieldCaption("Bill-to Customer No.")));
    end;

    procedure GetSequence(): Integer
    begin
        exit(200);
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