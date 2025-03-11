namespace ranjan.cds;

using {
    ranjan.db.master,
    ranjan.db.transaction
} from './data-model';

context CDSViews {
    define view ![POWorklist] as
        select from transaction.purchaseorder {
            key PO_ID as![PurchaseOrderNo],
            key Items.PO_ITEM_POS as![Position],
                PARTNER_GUID.BP_ID as![VendorId],
                PARTNER_GUID.COMPANY_NAME as![ComapnyName],
               GROSS_AMOUNT as![GrossAmount],
               NET_AMOUNT as![NetAmount],
               TAX_AMOUNT as![TaxAmount],
               CURRENCY as![CurrencyCode],
                case OVERALL_STATUS
                    when
                        'N'
                    then
                        'New'
                    when
                        'D'
                    then
                        'Delivered'
                    when
                        'P'
                    then
                        'Pending'
                    when
                        'A'
                    then
                        'Approved'
                    when
                        'X'
                    then
                        'Rejected'

                end as![Status],
                Items.PRODUCT_GUID.DESCRIPTION as![Product],
                PARTNER_GUID.ADDRESS_GUID.COUNTRY as![Country]
        };
    define view![ProductVH] as
    select from master.product{
        @EndUserText.label: [
            {
                language: 'EN',
                text: 'Product Id'
            },
            {
                language: 'DE',
                text: 'Prodekt Id'
            }

        ]
        PRODUCT_ID as![ProductId],
        @EndUserText.label: [
            {
                language: 'EN',
                text: 'Product Name'
            },
            {
                language: 'DE',
                text: 'Prodekt Name'
            }

        ]
        DESCRIPTION as![ProductName]
    };
    define view![ItemView] as
       select from transaction.poitems{
        key PARENT_KEY.PARTNER_GUID.NODE_KEY as![VendorId],
        PRODUCT_GUID.NODE_KEY as![ProductId],
        CURRENCY as![Currency],
        GROSS_AMOUNT as![GrossAmount],
        NET_AMOUNT as![NetAmount],
        TAX_AMOUNT as![TaxAmount],
        PARENT_KEY.OVERALL_STATUS as![Status]
       };

       define view ProductOrders as select from master.product
       // Mixin is a key word provided by CAPM to Perform lazy loading
       // it is same like association concept in ABAP cds views - lazy Loading of dependent data
       mixin{
        ORDERS: Association[0..*] to ItemView on ORDERS.ProductId = $projection.ProductKey
       } into
       {
        NODE_KEY as![ProductKey],
        DESCRIPTION as![ProductName],
        PRICE as![Price],
        SUPPLIER_GUID.BP_ID as![SupplierId],
        SUPPLIER_GUID.COMPANY_NAME as![SupplierName],
        SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as![Country],
        //exposed association like abap which will lazy load orders of a given Product
        // at runtime on demand
        ORDERS as![ProductOrders]
       };
    //    define view CProductValuesView as
    //     select from ProductOrders{
    //         ProductKey,
    //         Country,
    //         round(sum(ProductOrders),2) as![TotalPurchaseAmount] : Decimal(10,2),
    //         ProductOrders.CurrencyCode as![CurrencyCode]
    //     } group by ProductKey, Country, ProductOrders.CurrencyCode;
      
}
