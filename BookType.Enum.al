namespace GetUse.Academy.Bookstore;

using GetUse.Academy.Bookstore.Interface;

enum 50100 "Book Type"
{
    Extensible = true;

    value(0; " ") { Caption = 'None'; }
    value(1; Hardcover)
    {
        Caption = 'Hardcover';
    }
    value(2; Paperback)
    {
        Caption = 'Paperback';
    }
}