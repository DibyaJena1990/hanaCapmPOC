namespace ranjandb;
using { ranjandb.commons as commons } from './commons';
using { cuid,temporal,managed } from '@sap/cds/common';


context master {
    entity student : commons.address{
        key id: commons.guid;
        name: commons.guid;
        class:Association to one standards;
        gender: String(1);
    }
 entity standards {
    key id:commons.guid;
    classname: String(10);
    sections: Int16;
    classteacher:commons.guid;
 }
    entity books {
        key id: commons.guid;
        bookname: commons.guid;
        author: commons.guid;
    }
}

context transaction {

    entity rentals : cuid,temporal,managed{
       student: Association to master.student;
       book : Association to master.books;

    } 
}

