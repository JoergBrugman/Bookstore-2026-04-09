namespace GetUse.Academy.Bookstore.Interface;

codeunit 50107 "Book Type Paperback Impl." implements "Book Type Process V2"
{
    procedure StartDeployBook()
    begin
        Message('Print on Demand');
    end;

    procedure StartDeliverBook()
    begin
        Message('DPD Standard Versand');
    end;

    procedure CheckQuality()
    begin
        Message('Qualitätsprüfung OK');
    end;
}