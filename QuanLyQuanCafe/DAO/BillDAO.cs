using QuanLyQuanCafe.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCafe.DAO
{
    public class BillDAO
    {
        private static BillDAO instance;

        public static BillDAO Instance 
        { get { if (instance == null) instance = new BillDAO();  return BillDAO.instance; }
            private set { BillDAO.instance = value; } 
        }
        private BillDAO() { }   
        // thành công bill id
        // thất bại -1
        public int GetUnCheckBillIDByTableID(int id)
        {
            
            DataTable data = DataProvider.Instance.ExecuteQuery("select * from dbo.Bill where idTable = "+id +" And status = 0");
            if(data.Rows.Count > 0)
            {
                Bill bill = new Bill(data.Rows[0]);
                return bill.ID; 
            }
           
            return -1;
        }

        public void InsertBill(int id)
        {
            DataProvider.Instance.ExecuteNonQuery("exec USP_InsertBill @idTable", new object[] { id });
        }

        public int GetMaxIDBill()
        {
            try
            {
                return (int)DataProvider.Instance.ExecuteScalar("Select Max(id) from dbo.Bill");
            }
            catch
            {
                return 1;
            }
           
        }
    }
}
