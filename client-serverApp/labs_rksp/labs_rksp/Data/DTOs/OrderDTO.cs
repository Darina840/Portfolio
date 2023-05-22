using labs_rksp.Data.Models;

namespace labs_rksp.Data.DTOs
{
    public class OrderDTO
    {
        public int Id { get; set; }
        public string Date { get; set; }
        public int Amount { get; set; }
        public int Cost { get; set; }
        public int[] Products { get; set; }
        
    }
}
