namespace Northwind2.Entities.Models
{
    using System;

    public partial class ListItem
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public DateTime Date { get; set; }
        public decimal Amount { get; set; }
    }
}
