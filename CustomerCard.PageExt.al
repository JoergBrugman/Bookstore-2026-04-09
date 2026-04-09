namespace GetUse.Academy.Bookstore;

using Microsoft.Sales.Customer;

pageextension 50100 "Customer Card" extends "Customer Card"
{
    layout
    {
        addafter(General)
        {
            group("Bookstore")
            {
                Caption = 'Bookstore';

                field("Favorite Book No."; Rec."Favorite Book No.") { ApplicationArea = All; }
                field("Favorite Book Description"; Rec."Favorite Book Description") { ApplicationArea = All; }
            }
        }
        addafter(Control149)
        {
            part(BookFactbox; "Book Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Favorite Book No.");
            }
        }
    }
}