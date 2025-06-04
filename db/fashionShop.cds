namespace app.fashionShop;

using { Currency } from '@sap/cds/common';

type Flag : String(1);

entity Sections {
    key id : UUID;
    name : String(50);
    description : String(64);
}

entity Fashion_Types {
    key id : UUID;
    section : Association to Sections;
    typename : String(16);
    description : String(100);     
}

entity Fashion_Items {
    key id : UUID;
    fashionType : Association to Fashion_Types;
    itemname : String(16);
    brand : String(16);
    size : String(8);
    material : String(16);
    price : String(10);
    currency : Currency;
    isAvailable : Flag;
}
