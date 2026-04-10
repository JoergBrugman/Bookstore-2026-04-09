
namespace GetUse.Academy.Bookstore;

using GetUse.Academy.Bookstore.Interface;
using GetUse.Academy.Bookstore.Tools;

page 50101 "Book List"
{
    Caption = 'Books';
    PageType = List;
    SourceTable = Book;
    Editable = false;
    CardPageId = "Book Card";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Books)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = 'de-DE=Nr.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(ISBN; Rec.ISBN)
                {
                    ToolTip = 'Specifies the value of the ISBN field.';
                }
                field(Author; Rec.Author)
                {
                    ToolTip = 'Specifies the value of the Author field.';
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("No. of Pages"; Rec."No. of Pages")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the No. of Pages field.';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links) { ApplicationArea = RecordLinks; }
            systempart(Notes; Notes) { ApplicationArea = Notes; }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CreateBooks)
            {
                Caption = 'Create Books';
                Image = CreateDocuments;
                ApplicationArea = All;
                ToolTip = 'Executes the Create Books action.';
                RunObject = codeunit "Create Books";
            }
            action(SalesProcessSimple)
            {
                Caption = 'Simple Process';
                Image = Process;
                ApplicationArea = All;
                ToolTip = 'Executes the Simple Process action.';

                trigger OnAction()
                var
                    BookTypeSimpleImpl: Codeunit "Book Type Simple Impl.";
                begin
                    BookTypeSimpleImpl.StartDeployBook();
                    BookTypeSimpleImpl.StartDeliverBook();
                end;
            }
            action(SalesProcessWithInterface)
            {
                Caption = 'Sales Process with Interface';
                Image = Process;
                ToolTip = 'Executes the Sales Process with Interface action.';

                trigger OnAction()
                var
                    BookTypeNoneImpl: Codeunit "Book Type None Impl.";
                    BookTypeHardcoverImpl: Codeunit "Book Type Hardcover Impl.";
                    BookTypePaperbackImpl: Codeunit "Book Type Paperback Impl.";
                    BookTypeProcess: Interface "Book Type Process";
                    IsHandled: Boolean;
                begin
                    OnBeforeHandleBookType(Rec, IsHandled);
                    if IsHandled then
                        exit;

                    case Rec.Type of
                        "Book Type"::" ":
                            BookTypeProcess := BookTypeNoneImpl;
                        "Book Type"::Hardcover:
                            BookTypeProcess := BookTypeHardcoverImpl;
                        "Book Type"::Paperback:
                            BookTypeProcess := BookTypePaperbackImpl;
                    end;
                    BookTypeProcess.StartDeployBook();
                    BookTypeProcess.StartDeliverBook();
                end;
            }
            action(SalesProcessWithInterfaceAndEnum)
            {
                Caption = 'Sales Process with Interface and Enum';
                Image = Process;
                ToolTip = 'Executes the Sales Process with Interface and Enum action.';
                trigger OnAction()
                var
                    BookTypeProcess: Interface "Book Type Process";
                begin
                    BookTypeProcess := Rec.Type;
                    BookTypeProcess.StartDeployBook();
                    if BookTypeProcess is "Book Type Process V2" then
                        (BookTypeProcess as "Book Type Process V2").CheckQuality();
                    BookTypeProcess.StartDeliverBook();
                end;
            }
        }
        area(Reporting)
        {
            action(BookList)
            {
                Caption = 'Book List';
                Image = PrintReport;
                RunObject = report "Book - List";
                ToolTip = 'Executes the Book List report.';
            }
        }
    }


    [IntegrationEvent(false, false)]
    local procedure OnBeforeHandleBookType(Rec: Record Book; var IsHandled: Boolean)
    begin
    end;
}