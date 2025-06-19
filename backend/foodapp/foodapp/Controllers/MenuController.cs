namespace foodapp.Controllers
{
    using foodapp.Data;
    using foodapp.Models;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.EntityFrameworkCore;

    [ApiController]
    [Route("api/[controller]")]
    public class MenuController : ControllerBase
    {
        private readonly FoodieContext _context;
        public MenuController(FoodieContext context) => _context = context;

        [HttpGet]
        public async Task<ActionResult<IEnumerable<MenuItem>>> GetMenu() => await _context.MenuItems.Include(m => m.SubItems).ToListAsync();

        [HttpPost]
        public async Task<ActionResult> CreateMenuItem(MenuItem item)
        {
            _context.MenuItems.Add(item);
            await _context.SaveChangesAsync();
            return Ok(item);
        }

        [HttpPut("{id}")]
        public async Task<ActionResult> UpdateMenuItem(int id, MenuItem item)
        {
            var existing = await _context.MenuItems.Include(m => m.SubItems).FirstOrDefaultAsync(m => m.Id == id);
            if (existing == null) return NotFound();

            existing.Title = item.Title;
            existing.ImageUrl = item.ImageUrl;
            existing.SubItems = item.SubItems;

            await _context.SaveChangesAsync();
            return Ok(existing);
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> DeleteMenuItem(int id)
        {
            var item = await _context.MenuItems.FindAsync(id);
            if (item == null) return NotFound();

            _context.MenuItems.Remove(item);
            await _context.SaveChangesAsync();
            return Ok();
        }

        [HttpPost("{menuId}/subitem")]
        public async Task<ActionResult> AddSubItem(int menuId, SubItem sub)
        {
            var menu = await _context.MenuItems.Include(m => m.SubItems).FirstOrDefaultAsync(m => m.Id == menuId);
            if (menu == null) return NotFound();

            menu.SubItems.Add(sub);
            await _context.SaveChangesAsync();
            return Ok(menu);
        }

        [HttpPut("{menuId}/subitem/{subId}")]
        public async Task<ActionResult> UpdateSubItem(int menuId, int subId, SubItem updatedSub)
        {
            var subItem = await _context.SubItems.FirstOrDefaultAsync(s => s.Id == subId);
            if (subItem == null) return NotFound();

            subItem.Name = updatedSub.Name;
            subItem.Price = updatedSub.Price;
            await _context.SaveChangesAsync();

            return Ok(subItem);
        }

        [HttpDelete("{menuId}/subitem/{subId}")]
        public async Task<ActionResult> DeleteSubItem(int menuId, int subId)
        {
            var sub = await _context.SubItems.FindAsync(subId);
            if (sub == null) return NotFound();

            _context.SubItems.Remove(sub);
            await _context.SaveChangesAsync();
            return Ok();
        }

    [HttpPut("menu/{title}")]
        public async Task<IActionResult> UpdateMenuItemByTitle(string title, [FromBody] MenuItem updatedItem)
        {
            var existingItem = await _context.MenuItems
                .Include(m => m.SubItems)
                .FirstOrDefaultAsync(m => m.Title == title);

            if (existingItem == null)
                return NotFound(new { message = $"Menu item with title '{title}' not found." });

            existingItem.ImageUrl = updatedItem.ImageUrl;

            existingItem.SubItems.Clear();
            foreach (var subItem in updatedItem.SubItems)
            {
                existingItem.SubItems.Add(new SubItem
                {
                    Name = subItem.Name,
                    Price = subItem.Price
                });
            }

            await _context.SaveChangesAsync();
            return Ok(existingItem);
        }
    }

    }
