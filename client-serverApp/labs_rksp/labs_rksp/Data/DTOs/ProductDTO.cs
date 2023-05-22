using labs_rksp.Data.Models;

namespace labs_rksp.Data.DTOs
{
    public class ProductDTO
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Price { get; set; }
        public string Material { get; set; }
        public int[] Orders { get; set; }
    }
}
