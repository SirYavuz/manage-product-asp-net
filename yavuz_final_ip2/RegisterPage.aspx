<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegisterPage.aspx.cs" Inherits="RegisterPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .form-container {
            margin-top: 50px;
        }

        .header {
            text-align: center;
            margin-bottom: 20px;
        }

        .text-danger {
            color: red;
        }
    </style>
    <script>
        function showAlertAndRedirect(message, url) {
            alert(message);
            window.location.href = url;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container form-container">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <h2 class="header">Register</h2>
                    <div class="form-group">
                        <asp:Label ID="lblEmail" runat="server" Text="Email:" CssClass="control-label"></asp:Label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email Required!" CssClass="text-danger" />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Wrong mail format!" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="text-danger" />
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblPassword" runat="server" Text="Password:" CssClass="control-label"></asp:Label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password Required!" CssClass="text-danger" />
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblPhone" runat="server" Text="Phone Number:" CssClass="control-label"></asp:Label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Phone number Required!" CssClass="text-danger" />
                        <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Wrong number format!" ValidationExpression="\d{10}" CssClass="text-danger" />
                    </div>
                    <div class="form-group">
                        <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="BtnRegister_Click" CssClass="btn btn-primary" />
                    </div>
                    <div class="form-group">
                        <asp:HiddenField ID="hdnPostBack" runat="server" />

                        <asp:Button ID="btnBackToLogin" runat="server" Text="Back" OnClick="BtnBackToLogin_Click" CssClass="btn btn-secondary" CausesValidation="false" />
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hdnRegistrationStatus" runat="server" />
    </form>
    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        // Check if registration was successful
        window.onload = function () {
            var registrationStatus = document.getElementById('<%= hdnRegistrationStatus.ClientID %>').value;
            if (registrationStatus === 'success') {
                showAlertAndRedirect('Registration is success!', 'LoginPage.aspx');
            }
        };
    </script>
</body>
</html>
