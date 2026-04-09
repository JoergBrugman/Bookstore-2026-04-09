namespace GetUse.Academy.Bookstore;

page 50102 "Book Factbox"
{
    Caption = 'Book Details';
    PageType = CardPart;
    SourceTable = Book;
    Editable = false;

    layout
    {
        area(Content)
        {
            field("No."; Rec."No.")
            {
                Caption = 'Book No.';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    ShowDetail();
                end;
            }
            field(Description; Rec.Description)
            {
                Caption = 'Book Dscription';
                ApplicationArea = All;
            }
            field("Date of Publishing"; Rec."Date of Publishing")
            {
                ApplicationArea = All;
            }
            field("No. of Pages"; Rec."No. of Pages")
            {
                ApplicationArea = All;
            }
            field(Author; Rec.Author)
            {
                ApplicationArea = All;
            }
        }
    }

    local procedure ShowDetail()
    begin
        Rec.ShowCard();
    end;
}