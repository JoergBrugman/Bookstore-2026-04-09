report 50101 "Cust. by Salesp. (Entries)"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'CustbySalespEntries.rdlc';
    Caption = 'Cust. by Salesp. (Entries)';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(SingleRowData; "Integer")
        {
            DataItemTableView = sorting(Number) where(Number = const(1));
            #region Columns
            column(COMPANYNAME; CompanyProperty.DisplayName()) { }
            #endregion Columns
        }
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.");
            #region Trigger
            trigger OnPreDataItem()
            begin
                CurrReport.Break();
            end;
            #endregion Trigger
        }
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = sorting("Customer No.", "Posting Date", "Currency Code");
            RequestFilterFields = "Customer No.", "Salesperson Code", "Posting Date";
            #region Trigger
            trigger OnAfterGetRecord()
            begin
                UpdateSalespCustBuffer("Cust. Ledger Entry");
            end;
            #endregion Trigger
        }

        dataitem("Job Buffer"; "Job Buffer")
        {
            UseTemporary = true;
            DataItemTableView = sorting("Account No. 1", "Account No. 2");

            // #region Columns
            column(SalespersonCode_JobBuffer; "Job Buffer"."Account No. 1") { }
            column(Name_Salesperson; SalespersonPurchaser.Name) { }
            column(CustomerNo_JobBuffer; "Job Buffer"."Account No. 2") { }
            column(Name_Customer; Customer.Name) { IncludeCaption = true; }
            column(CountryRegionCode_Customer; Customer."Country/Region Code") { IncludeCaption = true; }
            column(BalanceLCY_Custer; Customer."Balance (LCY)") { IncludeCaption = true; }
            column(SalesLCY_JobBuffer; "Job Buffer"."Amount 1") { }
            column(ProfitLCY_JobBuffer; "Job Buffer"."Amount 2") { }
            // column(EntryNo_CustLedgerEntry; "Cust. Ledger Entry"."Entry No.") { }
            // #endregion Columns

            trigger OnAfterGetRecord()
            begin
                GetSalesperson("Account No. 1");
                GetCustomer("Account No. 2");

            end;
        }
    }

    requestpage
    {
        SaveValues = true;
    }

    labels
    {
        ReportCaptionLbl = 'Cust. by Salesperson (Entries)';
    }

    trigger OnPreReport()
    begin
        CompanyInformation.Get();
    end;

    local procedure GetSalesperson(SalespersonCode: Code[20])
    begin
        if not TempSalespersonPurchaser.Get(SalespersonCode) then begin
            if not SalespersonPurchaser.Get(SalespersonCode) then begin
                SalespersonPurchaser.Init();
                SalespersonPurchaser.Code := SalespersonCode;
            end;
            TempSalespersonPurchaser := SalespersonPurchaser;
            TempSalespersonPurchaser.Insert();
        end else
            SalespersonPurchaser := TempSalespersonPurchaser;
    end;

    local procedure GetCustomer(CustNo: Code[20])
    begin
        if not TempCustomer.Get(CustNo) then begin
            if not Customer.Get(CustNo) then begin
                Customer.Init();
                Customer."No." := CustNo;
            end;
            if Customer."Country/Region Code" = '' then
                Customer."Country/Region Code" := CompanyInformation."Country/Region Code";
            TempCustomer := Customer;
            TempCustomer.Insert();
        end else
            Customer := TempCustomer;
        Customer.CalcFields("Balance (LCY)");
    end;

    local procedure UpdateSalespCustBuffer(CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        if not "Job Buffer".Get(CustLedgerEntry."Salesperson Code", CustLedgerEntry."Customer No.") then begin
            "Job Buffer".Init();
            "Job Buffer"."Account No. 1" := CustLedgerEntry."Salesperson Code";
            "Job Buffer"."Account No. 2" := CustLedgerEntry."Customer No.";
            "Job Buffer".Insert();
        end;
        "Job Buffer"."Amount 1" += CustLedgerEntry."Sales (LCY)";
        "Job Buffer"."Amount 2" += CustLedgerEntry."Profit (LCY)";
        "Job Buffer".Modify();
    end;

    var
        CompanyInformation: Record "Company Information";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        TempSalespersonPurchaser: Record "Salesperson/Purchaser" temporary;
        TempCustomer: Record Customer temporary;
}

