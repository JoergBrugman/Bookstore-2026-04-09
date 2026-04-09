namespace GetUse.Academy.Bookstore;

using System.Utilities;

report 50100 "Book - List"
{
    Caption = 'Book List';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'BookList.rdlc';

    dataset
    {
        dataitem(SingleRowData; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));
            column(COMPANYNAME; CompanyProperty.DisplayName()) { }
            column(ShowNoOfPages; ShowNoOfPages) { }
        }
        dataitem("Book"; Book)
        {
            RequestFilterFields = "No.", Author;
            column(No_Book; "No.") { IncludeCaption = true; }
            column(Description_Book; Description) { IncludeCaption = true; }
            column(Author_Book; Author) { IncludeCaption = true; }
            column(NoofPages_Book; "No. of Pages") { IncludeCaption = true; }
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowNoOfPages; ShowNoOfPages)
                    {
                        Caption = 'Show No. of Pages';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Show No. of Pages field.';
                    }
                }
            }
        }
    }
    labels
    {
        ReportCaptionLbl = 'Book - List';
        PageCaptionLbl = 'Page {0} of {1}';
    }
    var
#pragma warning disable AA0204
        ShowNoOfPages: Boolean;
#pragma warning restore AA0204
}