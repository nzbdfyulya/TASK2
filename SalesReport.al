report 50201 "YULPI Sales Report"
{
    WordLayout = 'YULPISales.docx';

    Caption = 'YULPI Sales Report';
    DefaultLayout = Word;

    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";

            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(Registration_No; CompanyInfo."Registration No.")
            {
            }
            column(Customer_Name; "Sell-to Customer Name")
            {
            }
            column(Delivery_address; "Sell-to Address")
            {
            }
            column(Phone_No; Customer."Phone No.")
            {
            }
            column(Total_Amount; TotalAmount)
            {
            }
            column(Total_VAT_Amount; TotalVat)
            {
            }
            column(Amount_Including_VAT; TotalincVat)
            {
            }
            dataitem(Line; "Sales Line")
            {
                DataItemLinkReference = Header;
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                column(Item_No; "No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_Price; "Unit Price")
                {
                }
                column(Amount; "Amount Including VAT")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                SalesLine.SetRange("Document Type", "Document Type");
                SalesLine.SetRange("Document No.", "No.");
                SalesLine.CalcSums(Amount, "Amount Including VAT");
                TotalAmount := SalesLine.Amount;
                TotalVat := SalesLine."Amount Including VAT" - SalesLine.Amount;
                TotalincVat := SalesLine."Amount Including VAT";
            end;
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
    end;

    var
        CompanyInfo: Record "Company Information";
        SalesLine: Record "Sales Line";
        TotalAmount: Decimal;
        TotalVat: Decimal;
        TotalincVat: Decimal;
        Customer: Record "Customer";


}