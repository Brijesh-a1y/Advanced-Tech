using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EntityProject.Models.Entities
{
    public class Product
    {
        public int Id { get; set; }

        [Required(ErrorMessage ="Product name is required")]
        [StringLength(100,ErrorMessage ="Product name cannot exceed 100 characters")]
        public string Name { get; set; }


        [Required]
        public string Description { get; set; }

        
        [Range(1, 100,ErrorMessage ="Price must be between 1 and 100")]
        public decimal Price { get; set; }


        [Range(0,10000,ErrorMessage ="Stock Quantity must be between 0 to 10000")]
        public int StockQuantity { get; set; } = 0; //default value is 0
        
        
        public DateTime CreatedDate {  get; set; } = DateTime.Now;
        public bool IsActive { get; set; } = true;

    }
}
