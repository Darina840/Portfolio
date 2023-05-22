using BlazorApp1.Data.Models;
namespace BlazorApp1.Data.Models
{
    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Price { get; set; }
        public int Material { get; set; }
        public int[] Sales { get; set; }
    }
}
