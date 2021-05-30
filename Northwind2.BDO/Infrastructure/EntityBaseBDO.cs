/*****************************************************************************
 *        Class Name: BaseEntityBDO
 *  Class Decription: Contains attributes for all BDO's in the Northwind2
 *                    DB
 *              Date: Friday, July 1, 2016
 *            Author: ksafford
 * 
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;

namespace Northwind2.BDO
{
    public abstract class EntityBaseBDO
    {
        // Primitive Properties
        public string AddedBy { get; set; }
        public DateTime AddedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
        public Byte[] Modified { get; set; }
    }
}
