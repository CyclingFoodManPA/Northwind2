/*****************************************************************************
 *         Enum Name: HolidaySearchFields
 *  Class Decription: Contains search fields for Holiday
 *              Date: Friday, July 8, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;
using Northwind2.Common.Classes.Infrastructure;

namespace Northwind2.Common.Classes
{
    public class HolidaySearchFields : SearchBase
    {
        public DateTime HolidayDate { get; set; }
        public int HolidayDescriptionID { get; set; }
        public string HolidayDescriptionName { get; set; }
        public bool IsActive { get; set; }
    }
}