module.exports = cds.service.impl(async function () {

  const { POs, EmployeeSet } = this.entities;
  
  //generic handler - developer get flexibiities to attach their
  // own code on top of what CAPM already offers
  this.before(['CREATE','PATCH'], EmployeeSet, (req) => {
       if(parseFloat(req.data.salaryAmount) >= 1000000){
        req.error(500, "Hey we cannot process this amount");
       }
  });

  this.on('largestOrder', async(req) => {

    try {
      //start db transaction
      const tx = cds.tx(req);
      //cds query Language - communicate to DB in agnostic manner read po with higest amount
      const recordData = tx.read(POs).orderBy({
        GROSS_AMOUNT: 'desc'
      }).limit(1);
  return recordData;

    } catch (error) {
      
    }

  });

  this.on('getOrderStatus', async(req,res) => {

    return{
      "OVERALL_STATUS": "New"
    }

  });



});