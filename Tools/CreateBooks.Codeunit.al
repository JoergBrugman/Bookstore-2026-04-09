namespace GetUse.Academy.Bookstore.Tools;

using GetUse.Academy.Bookstore;

codeunit 50149 "Create Books"
{
    trigger OnRun()
    var
        Cnt: Integer;
        OrdinalsList: List of [Integer];
        OrdinalCnt: Integer;
    begin
        Book.DeleteAll();
        OrdinalsList := Book.Type.Ordinals();
        OrdinalCnt := OrdinalsList.Count();
        for Cnt := 1 to 100 do CreateBook(Cnt, OrdinalsList.Get((Cnt - 1) mod OrdinalCnt + 1));
    end;

    var
        Book: Record Book;

    local procedure CreateBook(Int: Integer; BookTypeInt: Integer)
    var
        Suffix: Text;
    begin
        Book.Init();
        Suffix := Format(int, 0, '<Integer,3><Filler Character,0>');
        if not Book.Get('B' + Suffix) then Book."No." := 'B' + Suffix;
        Book.Validate(Description, 'Buch ' + Format(int));
        Book.Author := 'Autor ' + Format(int);
        Book."Author Provision %" := Int mod 10;
        Book.ISBN := CopyStr(Format(int), 1, MaxStrLen(Book.ISBN));
        Book."No. of Pages" := Int * 10;
        Book.Type := "Book Type".FromInteger(BookTypeInt);
        Book."Date of Publishing" := Today() + Int;
        if not Book.Insert(true) then Book.Modify(true);
    end;
}
