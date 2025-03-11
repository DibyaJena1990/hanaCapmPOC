using { ranjan.cds } from '../db/CDSViews';
using { ranjan.db.master } from '../db/data-model';



service MyService @(path:'MyService') {

    function test(name: String(20)) returns String;
    entity ProductOrdersSet as projection on cds.CDSViews.ProductOrders{
        *,
        ProductOrders
    };

    entity ReadEmployeeSrv as projection on master.employees;

}