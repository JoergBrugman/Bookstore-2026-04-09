namespace GetUse.Academy.Bookstore;

using GetUse.Academy.Bookstore.Interface;

enum 50100 "Book Type" implements "Book Type Process"
{
    Extensible = true;
    DefaultImplementation = "Book Type Process" = "Book Type None Impl.";
    UnknownValueImplementation = "Book Type Process" = "Book Type None Impl.";

    value(0;
    " ")
    {
        Caption = 'None';
    Implementation = "Book Type Process" = "Book Type None Impl.";
}
    value(1; Hardcover)
    {
        Caption = 'Hardcover';
        Implementation = "Book Type Process" = "Book Type Hardcover Impl.";
    }
    value(2; Paperback)
    {
        Caption = 'Paperback';
        Implementation = "Book Type Process" = "Book Type Paperback Impl.";
    }
}