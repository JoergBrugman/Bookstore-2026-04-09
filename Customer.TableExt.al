namespace GetUse.Academy.Bookstore;

using Microsoft.Sales.Customer;

tableextension 50100 Customer extends Customer
{
    fields
    {
        field(50100; "Favorite Book No."; Code[20])
        {
            Caption = 'Favorite Book No.';
            TableRelation = Book;
            ToolTip = 'Specifies the value of the Favorite Book No. field.';
            trigger OnValidate()
            var
                Book: Record Book;
            begin
                if ("Favorite Book No." <> '') and
                    ("Favorite Book No." <> xRec."Favorite Book No.")
                then begin
                    Book.Get("Favorite Book No.");
                    Book.TestBlocked();
                end;
                if ("Favorite Book No." <> xRec."Favorite Book No.") and (CurrFieldNo > 0) then
                    CalcFields("Favorite Book Description");
            end;
        }
        field(50101; "Favorite Book Description"; Text[100])
        {
            Caption = 'Favorite Book Description';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Book.Description where("No." = field("Favorite Book No.")));
            ToolTip = 'Specifies the value of the Favorite Book Description field.';
        }

    }
}