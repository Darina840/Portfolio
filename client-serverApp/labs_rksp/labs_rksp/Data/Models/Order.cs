using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace labs_rksp.Data.Models
{
    public class Order
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column(Order = 1)]
        public int Id { get; set; }
        public string Date { get; set; }
        public int Amount { get; set; }
        public int Cost { get; set; }
        public IEnumerable<Product>? Products { get; set; }

    }
}
