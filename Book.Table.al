namespace GetUse.Academy.Bookstore;

/// <summary>
/// Table Book (ID 50100).
/// </summary>
table 50100 Book
{
    Caption = 'Book';
    DataCaptionFields = "No.", Description;
    LookupPageId = "Book List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.', Comment = 'de-DE=Nr.';
            ToolTip = 'Specifies the value of the No. field.', Comment = 'de-DE=Gibt den Wert des Feldes Nr. an.';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the value of the Description field.';
            trigger OnValidate()
            begin
                if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
                    "Search Description" := CopyStr(Description, 1, MaxStrLen("Search Description"));
            end;
        }
        field(3; "Search Description"; Code[100])
        {
            Caption = 'Search Description';
            ToolTip = 'Specifies the value of the Search Description field.';
        }
        field(4; Blocked; Boolean)
        {
            Caption = 'Blocked';
            ToolTip = 'Specifies the value of the Blocked field.';
        }
        field(5; Type; Enum "Book Type")
        {
            Caption = 'Type';
            ToolTip = 'Specifies the value of the Type field.';
            // OptionMembers = " ",Hardcover,Paperback;
            // OptionCaption = ' ,Hardcover,Paperback';
        }
        field(7; Created; Date)
        {
            Caption = 'Created';
            Editable = false;
            ToolTip = 'Specifies the value of the Created field.';
        }
        field(8; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
            ToolTip = 'Specifies the value of the Last Date Modified field.';
        }
        field(10; Author; Text[50])
        {
            Caption = 'Author';
            ToolTip = 'Specifies the value of the Author field.';
        }
        field(11; "Author Provision %"; Decimal)
        {
            Caption = 'Author Provision %';
            DecimalPlaces = 0 : 2;
            MinValue = 0;
            MaxValue = 100;
            ToolTip = 'Specifies the value of the Author Provision % field.';
        }
        field(15; ISBN; Code[20])
        {
            Caption = 'ISBN';
            ToolTip = 'Specifies the value of the ISBN field.';
        }
        field(16; "No. of Pages"; Integer)
        {
            Caption = 'No. of Pages';
            MinValue = 0;
            ToolTip = 'Specifies the value of the No. of Pages field.';
        }
        field(17; "Edition No."; Integer)
        {
            Caption = 'Edition No.';
            MinValue = 0;
            ToolTip = 'Specifies the value of the Edition No. field.';
        }
        field(18; "Date of Publishing"; Date)
        {
            Caption = 'Date of Publishing';
            ToolTip = 'Specifies the value of the Date of Publishing field.';
        }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, "No. of Pages") { }
        fieldgroup(Brick; "No.", ISBN, "Author Provision %", Author, "No. of Pages") { }
    }

    var
        OnDeleteBookErr: Label 'A Book cannot be deleted';

    trigger OnInsert()
    begin
        Created := Today();
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today();
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today();
    end;

    trigger OnDelete()
    var
        Handled: Boolean;
    begin
        OnBeforeDelete(Rec, Handled);
        if Handled then
            exit;
        Error(OnDeleteBookErr);
    end;

    /// <summary>
    /// Check if Book is blocked an fire some error
    /// </summary>
    procedure TestBlocked()
    begin
        TestField(Blocked, false);
    end;

    procedure ShowCard()
    begin
        ShowCard(Rec);
    end;

    procedure ShowCard(BookNo: Code[20])
    var
        Book: Record Book;
    begin
        if not Book.Get(BookNo) then
            exit;
        // ShowCard(Book);
        Book.ShowCard();
    end;

    /// <summary>
    /// ShowCard.
    /// </summary>
    /// <param name="Book">Record "Book".</param>
    procedure ShowCard(Book: Record Book)
    begin
        Page.Run(Page::"Book Card", Book);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDelete(Rec: Record Book; var Handled: Boolean)
    begin
    end;


}