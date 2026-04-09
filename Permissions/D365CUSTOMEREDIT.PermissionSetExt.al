namespace GetUse.Academy.Bookstore.Permissions;

using System.Security.AccessControl;

permissionsetextension 50100 "D365 CUSTOMER, EDIT" extends "D365 CUSTOMER, EDIT"
{
    IncludedPermissionSets = "BOOKSTORE, EDIT";
}