namespace ranjandb.commons;

using {Currency} from '@sap/cds/common';


// reusable data types
type guid        : String(32);

type AmountT     : Decimal(10, 2) @(
    Semantic.amount.CurrencyCode: 'CURRENCY_code',
    sap.unit                    : 'CURRENCY_code'
);

type Gender      : String(1) enum {
    male   = 'M';
    female = 'F';
};


type Phonenumber : String(30) @assert.format: '^\+?[1-9][0-9]{0,2}[-.\s]?\(?\d{2,4}\)?[-.\s]?\d{3,4}[-.\s]?\d{4}$';
type email       : String(64) @assert.format: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';


aspect amount: {
    CURRENCY: Currency;
    GROSS_AMOUNT: AmountT @(title : '{i18n>GrossAmount}');
    NET_AMOUNT: AmountT @(title : '{i18n>NetAmount}');
    TAX_AMOUNT: AmountT @(title : '{i18n>TaxAmount}');
}
aspect address {
    houseno : Int16;
    street  : String(80);
    city    : String(80);
    country : String(3);
}
