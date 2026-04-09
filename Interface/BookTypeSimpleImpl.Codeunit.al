namespace GetUse.Academy.Bookstore.Interface;

codeunit 50110 "Book Type Simple Impl."
{
    procedure StartDeployBook()
    begin
        Message('Aus Lager entnehmen');
    end;

    procedure StartDeliverBook()
    begin
        Message('Mit UPS versenden');
    end;
}