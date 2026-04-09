namespace GetUse.Academy.Bookstore.Permissions;

using GetUse.Academy.Bookstore;

permissionset 50100 "BOOKSTORE, EDIT"
{
    Caption = 'Edit and Create Books etc.';
    // Assignable = true;
    Permissions =
        table Book = X,
        tabledata Book = RIMD;
}