/*****************************************************************************
 *        Class Name: HolidayBDO
 *  Class Decription: Contains the Holiday information from the DB
 *              Date: Friday, July 8, 2016
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
    public class HolidayBDO : EntityBaseBDO
    {
        public HolidayBDO()
        {
        }

        public int HolidayID { get; set; }
        public DateTime HolidayDate { get; set; }
        public int HolidayDescriptionID { get; set; }
        public string HolidayDescriptionName { get; set; }
        public bool IsActive { get; set; }
    }
}
