using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Menu = QuanLyQuanCafe.DTO.Menu;
namespace QuanLyQuanCafe.DAO
{
    public class MenuDAO
    {
        private static MenuDAO instance;

        public static MenuDAO Instance 
        {
            get { if (instance == null) instance = new MenuDAO(); return MenuDAO.instance; }
            private set { MenuDAO.instance = value; }    
        }
        private MenuDAO() { }

        public List<Menu> GetListMenuByTable(int id)
        {
            List<Menu> listMenu = new List<Menu>();
            string query = "Select f.name , bi.count , f.price , f.price*bi.count As totalPrice from dbo.BillInfo as bi , dbo.Food as f, dbo.Bill as b where  bi.idBill = b.id and bi.idFood = f.id and b.status = 0 and b.idTable ="+ id;
            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            foreach (DataRow item in data.Rows) 
            {
                Menu menu = new Menu(item);

                listMenu.Add(menu);
            
            }
            
            return listMenu;
        }
    }
}
