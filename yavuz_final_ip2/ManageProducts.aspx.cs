using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class ManageProducts : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Kullanıcı giriş yapmamışsa Login sayfasına yönlendir
        if (Session["UserEmail"] == null)
        {
            Response.Redirect("LoginPage.aspx");
        }

        if (!IsPostBack)
        {
            BindProductGrid();
        }
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        // Kullanıcı oturumunu sonlandır
        Session.Clear();
        Response.Redirect("LoginPage.aspx");
    }

    protected void btnAddProduct_Click(object sender, EventArgs e)
    {
        Page.Validate("AddProduct");
        if (Page.IsValid)
        {
            string productName = txtProductName.Text;
            decimal price = decimal.Parse(txtPrice.Text);
            int stock = int.Parse(txtStock.Text);

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Products (ProductName, Price, Stock) VALUES (@ProductName, @Price, @Stock)";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@ProductName", productName);
                command.Parameters.AddWithValue("@Price", price);
                command.Parameters.AddWithValue("@Stock", stock);

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
            }

            BindProductGrid();
        }
    }

    private void BindProductGrid()
    {
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnection"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "SELECT ProductId, ProductName, Price, Stock FROM Products";
            SqlDataAdapter adapter = new SqlDataAdapter(query, connection);
            DataTable dataTable = new DataTable();
            adapter.Fill(dataTable);

            // Toplam fiyat sütununu hesaplamak için döngü
            DataColumn totalPriceColumn = new DataColumn("TotalPrice", typeof(decimal));
            dataTable.Columns.Add(totalPriceColumn);

            foreach (DataRow row in dataTable.Rows)
            {
                decimal price = Convert.ToDecimal(row["Price"]);
                int stock = Convert.ToInt32(row["Stock"]);
                decimal totalPrice = price * stock;
                row["TotalPrice"] = totalPrice;
            }

            gvProducts.DataSource = dataTable;
            gvProducts.DataBind();
        }
    }

    protected void gvProducts_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvProducts.EditIndex = e.NewEditIndex;
        BindProductGrid();
    }

    protected void gvProducts_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvProducts.EditIndex = -1;
        BindProductGrid();
    }

    protected void gvProducts_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        Page.Validate("EditProduct");
        if (Page.IsValid)
        {
            int productId = Convert.ToInt32(gvProducts.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvProducts.Rows[e.RowIndex];
            decimal price = decimal.Parse(((TextBox)row.FindControl("txtEditPrice")).Text);
            int stock = int.Parse(((TextBox)row.FindControl("txtEditStock")).Text);

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "UPDATE Products SET Price = @Price, Stock = @Stock WHERE ProductId = @ProductId";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Price", price);
                command.Parameters.AddWithValue("@Stock", stock);
                command.Parameters.AddWithValue("@ProductId", productId);

                connection.Open();
                command.ExecuteNonQuery();
                Response.Write("<script>alert('Product details updated!')</script>");
                connection.Close();
            }

            gvProducts.EditIndex = -1;
            BindProductGrid();
        }
    }

    protected void gvProducts_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int productId = Convert.ToInt32(gvProducts.DataKeys[e.RowIndex].Value);

        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnection"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "DELETE FROM Products WHERE ProductId = @ProductId";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@ProductId", productId);

            connection.Open();
            command.ExecuteNonQuery();
            Response.Write("<script>alert('Product deleted.')</script>");
            connection.Close();
        }

        BindProductGrid();
    }

    protected string CalculateTotalPrice(object price, object stock)
    {
        if (price != DBNull.Value && stock != DBNull.Value)
        {
            decimal productPrice = Convert.ToDecimal(price);
            int productStock = Convert.ToInt32(stock);
            decimal totalPrice = productPrice * productStock;
            return totalPrice.ToString("C"); // Toplam fiyatı para birimi formatında döndürmek için
        }
        else
        {
            return "Unknown";
        }
    }

    protected void gvProducts_Sorting(object sender, GridViewSortEventArgs e)
    {
        string sortExpression = e.SortExpression;
        string direction = string.Empty;

        if (ViewState["SortDirection"] != null)
        {
            direction = ViewState["SortDirection"].ToString();
            if (direction.Equals("ASC"))
            {
                ViewState["SortDirection"] = "DESC";
            }
            else
            {
                ViewState["SortDirection"] = "ASC";
            }
        }
        else
        {
            ViewState["SortDirection"] = "ASC";
        }

        // Veritabanından verileri yeniden yüklemek için
        DataTable dt = GetProductsFromDatabase(); // Veri tabanından verileri çeken bir metot
                                                  // DataTable nesnesini kullanarak DataView oluşturma
        DataView dv = dt.DefaultView;

        // GridView sıralama yapmak için
        dv.Sort = sortExpression + " " + direction;
        gvProducts.DataSource = dv;
        gvProducts.DataBind();
    }

    private DataTable GetProductsFromDatabase()
    {
        DataTable dataTable = new DataTable();

        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnection"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "SELECT ProductId, ProductName, Price, Stock FROM Products";
            SqlDataAdapter adapter = new SqlDataAdapter(query, connection);
            adapter.Fill(dataTable);
        }

        // Toplam fiyat sütununu hesaplamak için döngü
        DataColumn totalPriceColumn = new DataColumn("TotalPrice", typeof(decimal));
        dataTable.Columns.Add(totalPriceColumn);

        foreach (DataRow row in dataTable.Rows)
        {
            decimal price = Convert.ToDecimal(row["Price"]);
            int stock = Convert.ToInt32(row["Stock"]);
            decimal totalPrice = price * stock;
            row["TotalPrice"] = totalPrice;
        }

        return dataTable;
    }
}
