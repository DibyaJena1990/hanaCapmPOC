namespace ranjan.db;

using { cuid,managed,temporal, Currency } from '@sap/cds/common';
using { ranjandb.commons as commons } from './commons';

context master {
    entity buisnesspartner {
        key NODE_KEY : commons.guid;
        BP_ROLE: String(2);
        EMAIL_ADDRESS:String(105);
        PHONE_NUMBER: String(32);
        FAX_NUMBER: String(32);
        WEB_ADDRESS:String(44);
        ADDRESS_GUID: Association to address;
        BP_ID:String(32);
        COMPANY_NAME: String(250);
    }

     entity address {
        key NODE_KEY: commons.guid;
        CITY: String(32);
        POSTAL_CODE: String(64);
        STREET:String(44);
        BUILDING: String(128);
        COUNTRY:String(44);
        ADDRESS:String(44);
        VAL_START_DATE: Date;
        VAL_END_DATE:Date;
        LATITUDE:Decimal;
        LONGITUDE:Decimal;
        buisnesspartner:Association to one buisnesspartner on buisnesspartner.ADDRESS_GUID = $self;
    }

     entity product {
        key NODE_KEY: commons.guid;
        PRODUCT_ID:String(28);
        TYPE_CODE: String(2);
        CATEGORY:String(32);
        DESCRIPTION: localized String(255);
        SUPPLIER_GUID: Association to master.buisnesspartner;
        TAX_TARIF_CODE:Integer;
        MEASURE_UNIT: String(2);
        WEIGHT_MEASURE:Decimal(5, 2);
        WEIGHT_UNIT:String(2);
        CURRENCY_CODE:String(4);
        PRICE:Decimal(15, 2);
        WIDTH: Decimal(5, 2);
        DEPTH:Decimal(5, 2);
        HEIGHT:Decimal(5, 2);
        DIM_UNIT:String(2);
    }
    entity employees : cuid{
        nameFirst: String(40);
        nameMiddle:String(40);
        nameLast: String(40);
        nameInitials: String(40);
        sex: commons.Gender;
        language: String(1);
        phonenumber:commons.Phonenumber;
        email: commons.email;
        loginName: String(40);
        Currency : Currency;
        salaryAmount: commons.AmountT;
        accountNumber:String(16);
        bankId:String(80);
        bankName:String(64);
    }
}

context transaction {
    entity purchaseorder: commons.amount {
        key NODE_KEY: commons.guid;
        PO_ID: String(40);
        PARTNER_GUID: Association to master.buisnesspartner;
        LIFECYCLE_STATUS: String(1);
        OVERALL_STATUS: String(1);  
        Items: Composition of many poitems on Items.PARENT_KEY = $self;      
    }

    entity poitems:commons.amount {
        key NODE_KEY:commons.guid;
        PARENT_KEY:Association to purchaseorder;
        PO_ITEM_POS: Integer;
        PRODUCT_GUID: Association to master.product;
    }
}

