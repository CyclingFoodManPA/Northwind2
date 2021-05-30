/*****************************************************************************
 *        Class Name: ListItem
 *  Class Decription: Contains Id, Name, Date, and Amount column for all child 
 *                    entities in DB that have an Id, Name, Date, and/or Amount
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
    public sealed class ListItemBDO
    {
        // Primitive Properties
        public int ID { get; set; }
        public string Name { get; set; }
        public DateTime Date { get; set; }
        public decimal Amount { get; set; }
    }
}
