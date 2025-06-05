using app.fashionShop from '../db/fashionShop';

service FashionShop_Service {

    entity Sections as projection on fashionShop.Sections;

    @cds.redirection.target: true
    entity Fashion_Types as projection on fashionShop.Fashion_Types;

    @odata.draft.enabled
    entity Fashion_Items as projection on fashionShop.Fashion_Items;

    entity Srv_FashionShop as projection on fashionShop.YC_FashionShop;
    entity F4_FashionType as projection on fashionShop.YC_FashionType;
}

annotate fashionShop.Fashion_Items with @(UI: {
    CreateHidden: false,
    UpdateHidden: false,
    DeleteHidden: false,
    HeaderInfo: { // Title of the Application
        $Type: 'UI.HeaderInfoType',
        TypeName: 'Online Fashion Shop',
        TypeNamePlural: 'Online Fashion Shop',
        Title: { Value: itemname },
        Description: { Value: 'Online Fashion Shop' }
    },
    SelectionFields: [ //For Filters 
        fashionType_id,
        itemname,
        brand,
        size,
        price
    ],
    LineItem: [ //Defines the columns shown in the list/table
        { Value: fashionType.section.name, Label: 'Name' },
        { Value: fashionType.typename, Label: 'Fashion Type' },
        { Value: itemname },
        { Value: brand },
        { Value: size },
        { Value: price },
        { Value: currency_code }
    ],
    Facets: [{ //Tabs and Sections in Object Page
        $Type: 'UI.CollectionFacet',
        ID: '1',
        Label: 'Fashion Type & Section',
        Facets: [
            {
                $Type: 'UI.ReferenceFacet',
                Target: '@UI.FieldGroup#TypeSection'//data from this grp
            },
            {
                $Type: 'UI.CollectionFacet',
                ID: '2',
                Label: 'Fashion Item',
                Facets: [{
                    $Type: 'UI.ReferenceFacet',
                    Target: '@UI.FieldGroup#FItem'// data from this grp
                }]
            }
        ]
    }]
});

annotate fashionShop.Fashion_Items with @(UI.FieldGroup #TypeSection: {
    Data: [
        { Value: fashionType_id },
        { Value: fashionType.typename },
        { Value: fashionType.description },
        { Value: fashionType.section.id },
        { Value: fashionType.section.name }
    ]
});

annotate fashionShop.Fashion_Items with @(UI.FieldGroup #FItem: {
    Data: [
        { Value: id },
        { Value: itemname },
        { Value: brand },
        { Value: material },
        { Value: size },
        { Value: price },
        { Value: currency_code },
        { Value: isAvailable }
    ]
});

annotate fashionShop.Fashion_Items.fashionType.typename with @Common.FieldControl: #ReadOnly;
annotate fashionShop.Fashion_Items.fashionType.description with @Common.FieldControl: #ReadOnly;
annotate fashionShop.Fashion_Items.fashionType.section.id with @Common.FieldControl: #ReadOnly;
annotate fashionShop.Fashion_Items.fashionType.section.name with @Common.FieldControl: #ReadOnly;

annotate FashionShop_Service.Fashion_Items with { // dropdown or F4 Help
    fashionType @title: 'Fashion Type';
    fashionType @sap.value.list: 'fixed-values';
    fashionType @Common.ValueListWithFixedValues;
    fashionType @Common.ValueList: {
        CollectionPath: 'F4_FashionType',
        Parameters: [
            {
                $Type: 'Common.ValueListParameterInOut',
                ValueListProperty: 'fashionTypeID',
                LocalDataProperty: fashionType_id
            },
            {
                $Type: 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'sectionName'
            },
            {
                $Type: 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'fashionTypeName'
            }
        ]
    };
};
