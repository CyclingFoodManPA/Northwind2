using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace Northwind2.Entities.Models.Mapping
{
    public class vw_InvoiceSubtotalsMap : EntityTypeConfiguration<vw_InvoiceSubtotals>
    {
        public vw_InvoiceSubtotalsMap()
        {
            // Primary Key
            this.HasKey(t => t.InvoiceID);

            // Properties
            this.Property(t => t.InvoiceID)
                .HasDatabaseGeneratedOption(DatabaseGeneratedOption.None);

            // Table & Column Mappings
            this.ToTable("vw_InvoiceSubtotals", "Sales");
            this.Property(t => t.InvoiceID).HasColumnName("InvoiceID");
            this.Property(t => t.Subtotal).HasColumnName("Subtotal");
        }
    }
}
