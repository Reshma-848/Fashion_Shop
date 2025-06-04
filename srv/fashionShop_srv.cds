using app.fashionShop from '../db/fashionShop';

service FashionShop_Service {
    entity Sections as  projection on fashionShop.Sections;
    entity Fashion_Types as projection on fashionShop.Fashion_Types;
    entity Fashion_Items as projection on fashionShop.Fashion_Items;
    entity Srv_FashionShop as projection on fashionShop.YC_FashionShop;
}
@odata.draft.enabled
annotate fashionShop.Fashion_Items with @(UI :{
    HeaderInfo  : {
        $Type : 'UI.HeaderInfoType',
        TypeName : 'Online Fashion Shop',
        TypeNamePlural : 'Online Fashion Shop',
        Title: {Value : itemname},
        Description : {Value:'Online Fashion Shop'}
    },
    SelectionFields  : [
        fashionType_id,
        itemname,
        brand,
        size,
        price
    ],
    LineItem  : [
        {Value: fashionType.section.name, Label:'Name'},
        {Value: fashionType.typename, Label:'Fashion Type'},
        {Value: itemname},
        {Value: brand},
        {Value: size},
        {Value: price},
        {Value: currency_code}
    ],
    Facets    : [{
        $Type : 'UI.CollectionFacet',
        ID :'1',
        Label : 'Fashion Type & Section',
        Facets: [
            {
                $Type : 'UI.ReferenceFacet',
                Target: '@UI.FieldGroup#TypeSection'
            },
            {
                $Type : 'UI.CollectionFacet',
                ID:'2',
                Label : 'Fashion Item',
                Facets: [
                    {
                        $Type : 'UI.ReferenceFacet',
                        Target: '@UI.FieldGroup#FItem'
                    }
                ]
            }
        ]
    }]
});

annotate fashionShop.Fashion_Items with @(UI.FieldGroup #TypeSection : {
    Data : [
        {Value: fashionType_id},
        {Value: fashionType.typename},
        {Value: fashionType.description},
        {Value: fashionType.section.id},
        {Value: fashionType.section.name}
    ]
});

annotate fashionShop.Fashion_Items with @(UI.FieldGroup #FItem : {
    Data : [
        {Value: id},
        {Value: itemname},
        {Value: brand},
        {Value: material},
        {Value: size},
        {Value: price},
        {Value: currency_code},
        {Value: isAvailable}
    ]
});
