namespace app.fashionShop;

using { Currency } from '@sap/cds/common';

type Flag : String(1);

entity Sections {
    key id : UUID @(title:'Section ID');
    name : String(50) @(title:'Section Name');
    description : String(64) @(title:'Section Description');
}

entity Fashion_Types {
    key id : UUID @(title:'Fashion Type ID');
    section : Association to Sections @(title:'Section ID');
    typename : String(16) @(title:'Fashion Type');
    description : String(100) @(title:'Fashion Description');     
}

entity Fashion_Items {
    key id : UUID @(title:'Fashion Item ID');
    fashionType : Association to Fashion_Types @(title:'Fashion Type ID');
    itemname : String(16) @(title:'Fashion_Item');
    brand : String(16) @(title:'Brand');
    size : String(8) @(title:'Size');
    material : String(16) @(title:'Material');
    price : String(10) @(title:'Price');
    currency : Currency @(title:'Currency');
    isAvailable : Flag @(title:'Is Available');
}

//View creation for Fashion_Shop

view YC_FashionShop as select from Fashion_Items as fItem
{
       fItem.fashionType.section.id as sectionId,
       fItem.fashionType.section.name as sectionName,
       fItem.fashionType.section.description as sectionDesc,
       fItem.fashionType.id as fashionTypeId,
       fItem.fashionType.typename as fashionTypeName,
       fItem.fashionType.description as fashionTypeDesc,
       fItem.id as fahsionItemId,
       fItem.itemname as fashionItemName,
       fItem.brand as brand,
       fItem.size as size,
       fItem.material as material,
       fItem.price as  price,
       fItem.currency as currency,
    //    fItem.isAvailable as isAvailable,
       concat (fItem.brand,concat(' ',fItem.itemname)) as itemDetails : String (32),
       case 
            when fItem.price >= 500 then 'Premium'
            when fItem.price >= 100 and fItem.price < 500 then 'Mid-Range'
            else 'Low-Range'
        end as priceRange : String(10)
} where fItem.isAvailable='X';