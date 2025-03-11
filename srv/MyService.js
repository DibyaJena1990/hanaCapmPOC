const cds = require('@sap/cds')

const { employees } = cds.entities("ranjan.db.master");


module.exports = (srv) => {
    srv.on('test', req => `Hello ${req.data.name}`);
    srv.on('READ','ReadEmployeeSrv', async(req) => {
//Example 1: Simple demo for custom logic instaed CAPM Framework doing we are writing our own return data.
    //    return {
    //     "ID": "236678",
    //     "nameFirst": "Pi"
    //    }



   // calling DB and adding extra logic
    const tx = await cds.tx(req);

//Example 2: Read and manipulate Data
    // var results = await tx.run(SELECT.from(employees).limit(5));
    // for (let index = 0; index < results.length; index++) {
    //     const element = results[index];

    //     element.nameMiddle = "Kumar"
        
    // }
    // return results;


//Example 3: Working with Conditions
    var wherecondition = req.data;
    if(wherecondition.hasOwnProperty("ID")){
      return await tx.run(SELECT.from(employees).where(wherecondition));
    }else{
        return await tx.run(SELECT.from(employees).limit(5).where({
            "sex": 'F'
        }));
    }


    });

}