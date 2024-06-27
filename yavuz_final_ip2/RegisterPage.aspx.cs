using System;
using System.Data.SqlClient;
using System.Web.UI;

public partial class RegisterPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void BtnRegister_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text;
        string password = txtPassword.Text;
        string phone = txtPhone.Text;

        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnection"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();

            // Mail ve telefon daha önceden kayıt edilmiş mi kontrolü
            string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email OR PhoneNumber = @PhoneNumber";
            SqlCommand checkCommand = new SqlCommand(checkQuery, connection);
            checkCommand.Parameters.AddWithValue("@Email", email);
            checkCommand.Parameters.AddWithValue("@PhoneNumber", phone);

            int count = (int)checkCommand.ExecuteScalar();
            if (count > 0)
            {
                // Email ve telefon daha önceden kullanıldıysa bildirim yollama.
                ClientScript.RegisterStartupScript(this.GetType(), "RegistrationAlert", "alert('Bu email veya telefon numarası ile kayıt zaten mevcut.');", true);
                return;
            }

            // Yeni kullanıcı oluştur
            string query = "INSERT INTO Users (Email, Password, PhoneNumber) VALUES (@Email, @Password, @PhoneNumber)";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@Email", email);
            command.Parameters.AddWithValue("@Password", password);
            command.Parameters.AddWithValue("@PhoneNumber", phone);

            command.ExecuteNonQuery();
        }

        hdnRegistrationStatus.Value = "success";
    }

    protected void BtnBackToLogin_Click(object sender, EventArgs e)
    {
        Response.Redirect("LoginPage.aspx");
    }
}
