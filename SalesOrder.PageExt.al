pageextension 50250 "YULPI Sales Order" extends "Sales Order"
{
    actions
    {
        addlast("&Print")
        {
            action(YULPI_Report)
            {
                Caption = 'Print YULPI Report';
                ApplicationArea = All;
                RunObject = report "YULPI Sales Report";
                Image = PrintReport;
            }
        }
    }
}
