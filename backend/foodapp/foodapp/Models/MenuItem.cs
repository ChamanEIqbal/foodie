namespace foodapp.Models
{
    public class SubItem
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public double Price { get; set; }
    }

    public class MenuItem
    {
        public int Id { get; set; }
        public string Title { get; set; } = string.Empty;
        public string ImageUrl { get; set; } = string.Empty;
        public List<SubItem> SubItems { get; set; } = new();
    }
}
