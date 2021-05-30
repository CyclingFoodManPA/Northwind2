/*****************************************************************************
 *         Enum Name: SearchBase
 *  Class Decription: Contains base search fields
 *              Date: Friday, July 1, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;

namespace Northwind2.Common.Classes.Infrastructure
{
    public class SearchBase
    {
        public string AddedBy { get; set; }
        public DateTime AddedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
    }
}
