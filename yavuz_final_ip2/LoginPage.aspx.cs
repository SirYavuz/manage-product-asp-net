using System;
using System.Data.SqlClient;

public partial class LoginPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void BtnLogin_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text;
        string password = txtPassword.Text;

        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnection"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "SELECT COUNT(*) FROM Users WHERE Email = @Email AND Password = @Password";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@Email", email);
            command.Parameters.AddWithValue("@Password", password);

            connection.Open();
            int count = (int)command.ExecuteScalar();
            connection.Close();

            if (count == 1)
            {
                // Login başarılıysa
                Session["UserEmail"] = email; // Kullanıcı oturum bilgisini sakla
                Response.Redirect("ManageProducts.aspx");
            }
            else
            {
                // Faillerse
                lblError.Text = "Mail or password is not found in database!";
            }
        }
    }
}
