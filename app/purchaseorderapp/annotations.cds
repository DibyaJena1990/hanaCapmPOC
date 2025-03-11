using CatalogService as service from '../../srv/catalogueservice';


annotate CatalogService.POs with @(

    UI.SelectionFields:[
        PO_ID,
        GROSS_AMOUNT,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY
    ],
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
            Label : 'Purchase Order ID'
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME,
            Label : 'Company Name'
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.BP_ID,
            Label : 'Business Partner ID'
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
            Label : 'Gross Amount'
        },
        {
            $Type : 'UI.DataField',
            Value : OVERALL_STATUS,
            Criticality: Criticality,
            CriticalityRepresentation : #WithIcon,
            Label : 'Overall Status'
        },{
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.boost',
            Label : 'Boost',
            Inline: true
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
            Label : 'Currency'
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
            Label : 'Country'
        },
    ],
    UI.HeaderInfo:{
        TypeName : 'PO',
        TypeNamePlural: 'Purchase Orders',
        Title : {
            $Type : 'UI.DataField',
            Value : PO_ID,
            Label : 'Purchase Order ID'
        },
        Description: {
            $Type : 'UI.DataField',
            Value : LIFECYCLE_STATUS,
        },
        ImageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/IBM_logo.svg/2560px-IBM_logo.svg.png'
    },
    UI.Facets:[
        {
            $Type : 'UI.CollectionFacet',
            Label : 'PO Details',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'More Info',
                    Target : '@UI.FieldGroup#MoreInfo',
                },{
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Pricing Details',
                    Target : '@UI.FieldGroup#Spiderman',
                },{
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Statuses',
                    Target : '@UI.FieldGroup#Jena',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'PO Line Items',
            Target : 'Items/@UI.LineItem',
        },
    ],
    UI.FieldGroup #MoreInfo: {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PO_ID,
                Label : 'Purchase Order ID'
            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID_NODE_KEY,
            }
        ],
    },
    UI.FieldGroup #Spiderman:{
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },{
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },{
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
        ],
    } ,
    UI.FieldGroup #Jena:{
        Data : [
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
            {
                $Type : 'UI.DataField',
                Value : OVERALL_STATUS,
                Label : 'Over All Status'
            }
        ],
    }     

);

annotate CatalogService.POItems with @(
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },{
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },{
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },{
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },{
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        },{
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        }

    ],
    UI.HeaderInfo:{
        TypeName : 'Item',
        TypeNamePlural : 'Items',
        Title : {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        }
    },
    UI.Facets:[
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Item Details',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Item Data',
                    Target : '@UI.FieldGroup#ItemData',
                },{
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Product Data',
                    Target : '@UI.FieldGroup#ProductData',
                }
            ],
        },
    ],
    UI.FieldGroup #ItemData:{
        Label : 'Item Data',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID_NODE_KEY,
            },{
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },{
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },{
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },{
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
        ],
    },
    UI.FieldGroup #ProductData:{
        Label: 'Product Details',
        Data: [
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.CATEGORY,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.DESCRIPTION,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.PRICE,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.SUPPLIER_GUID.ADDRESS_GUID.COUNTRY,
            },{
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.SUPPLIER_GUID.COMPANY_NAME,
            }
        ]
    }
);

annotate service.POs  with {
    PARTNER_GUID@(
        Common.Text: PARTNER_GUID.COMPANY_NAME,
        Common.ValueList.entity: service.BuisnessPartnerSet
    )
};

annotate service.POItems  with {
    PRODUCT_GUID@(
        Common.Text: PARTNER_GUID.DESCRIPTION,
        Common.ValueList.entity: service.BuisnessPartnerSet
    )
};
// we create a value help
@cds.odata.valuelist
annotate service.BuisnessPartnerSet with @(
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value : COMPANY_NAME,
        }
    ]

);

annotate service.ProductSet with @(
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value : DESCRIPTION,
        }
    ]

);

