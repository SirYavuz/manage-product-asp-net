<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageProducts.aspx.cs" Inherits="ManageProducts" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Product Management</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .form-container {
            margin-top: 50px;
        }

        .grid-container {
            margin-top: 30px;
        }

        .header {
            margin-top: 20px;
            text-align: center;
        }

        #btnAddProduct {
            width: 100%;
        }

        .edit-button {
            margin-right: 5px;
        }

        .delete-button {
            margin-left: 5px;
        }

        .logout-button {
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container form-container">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <h2 class="header">Product Management</h2>
                    <div class="form-group">
                        <asp:Label ID="lblProductName" runat="server" Text="Product Name:" CssClass="control-label"></asp:Label>
                        <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control" ValidationGroup="AddProduct"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvProductName" runat="server" ControlToValidate="txtProductName" ErrorMessage="Name Required!" ValidationGroup="AddProduct" CssClass="text-danger" />
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblPrice" runat="server" Text="Price:" CssClass="control-label"></asp:Label>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" ValidationGroup="AddProduct"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="txtPrice" ErrorMessage="Price is required" ValidationGroup="AddProduct" CssClass="text-danger" />
                    </div>
                    <div class="form-group">
                        <asp:Label ID="lblStock" runat="server" Text="Stock:" CssClass="control-label"></asp:Label>
                        <asp:TextBox ID="txtStock" runat="server" CssClass="form-control" ValidationGroup="AddProduct"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvStock" runat="server" ControlToValidate="txtStock" ErrorMessage="Stock is required" ValidationGroup="AddProduct" CssClass="text-danger" />
                    </div>
                    <div class="form-group">
                        <asp:Button ID="btnAddProduct" runat="server" Text="Add Product" OnClick="btnAddProduct_Click" ValidationGroup="AddProduct" CssClass="btn btn-primary" />
                    </div>
                </div>
            </div>
            <div class="row grid-container">
                <div class="col-md-8 offset-md-2">
                    <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" DataKeyNames="ProductId" CssClass="table table-bordered table-striped"
                        OnSorting="gvProducts_Sorting" AllowSorting="true"
                        OnRowEditing="gvProducts_RowEditing" OnRowCancelingEdit="gvProducts_RowCancelingEdit" OnRowUpdating="gvProducts_RowUpdating" OnRowDeleting="gvProducts_RowDeleting">
                        <Columns>
                            <asp:BoundField DataField="ProductId" HeaderText="ID" ReadOnly="True" SortExpression="ProductId" />
                            <asp:BoundField DataField="ProductName" HeaderText="Product Name" SortExpression="ProductName" ReadOnly="True" />
                            <asp:TemplateField HeaderText="Price by count" SortExpression="Price">
                                <ItemTemplate>
                                    <asp:Label ID="lblPrice" runat="server" Text='<%# Bind("Price") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEditPrice" runat="server" Text='<%# Bind("Price") %>' CssClass="form-control"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Stock" SortExpression="Stock">
                                <ItemTemplate>
                                    <asp:Label ID="lblStock" runat="server" Text='<%# Bind("Stock") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEditStock" runat="server" Text='<%# Bind("Stock") %>' CssClass="form-control"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total Price" SortExpression="TotalPrice">
                                <ItemTemplate>
                                    <asp:Label ID="lblTotalPrice" runat="server" Text='<%# CalculateTotalPrice(Eval("Price"), Eval("Stock")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Edit And Delete">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-sm btn-success edit-button" />
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-sm btn-danger delete-button" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" Text="Update" CssClass="btn btn-sm btn-success edit-button" />
                                    <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-sm btn-secondary delete-button" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <div class="row logout-button">
                <div class="col-md-12 text-center">
                    <asp:Button ID="btnLogout" runat="server" Text="Exit Session" OnClick="btnLogout_Click" CssClass="btn btn-secondary" />
                </div>
            </div>
        </div>
    </form>
    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
