using { ranjan.db.master,ranjan.db.transaction } from '../db/data-model';

service CatalogService@(path: 'CatalogService', requires: 'authenticated-user'){
    entity BuisnessPartnerSet as projection on master.buisnesspartner;
    
    entity EmployeeSet @(restrict:[
        {grant: 'READ', to:'Viewer', where: 'bankName = $user.BankName'},
        {grant: 'WRITE', to:'Admin'}
    ]) as projection on master.employees;
    entity ProductSet as projection on master.product;

    function getOrderStatus() returns POs;
    entity POs @(
        odata.draft.enabled: true,
        Common.DefaultValuesFunction: 'getOrderStatus'
    ) as projection on transaction.purchaseorder{
        *,
        case OVERALL_STATUS
            when 'N' then 'New'
            when 'P' then 'Paid'
            when 'B' then 'Blocked'
            else 'Delivered' end as OVERALL_STATUS: String(20),
        case OVERALL_STATUS
            when 'N' then 0
            when 'P' then 1
            when 'B' then 2
            else 3 end as Criticality: Integer,
            Items
    }
    actions{
        action boost() returns POs;
        function largestOrder() returns POs;
    };
    entity POItems as projection on transaction.poitems;
}
