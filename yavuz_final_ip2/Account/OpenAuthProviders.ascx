<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OpenAuthProviders.ascx.cs" Inherits="OpenAuthProviders" %>

<div id="socialLoginList">
    <h4>Oturum açmak için başka bir hizmet kullanın.</h4>
    <hr />
    <asp:ListView runat="server" ID="providerDetails" ItemType="System.String"
        SelectMethod="GetProviderNames" ViewStateMode="Disabled">
        <ItemTemplate>
            <p>
                <button type="submit" class="btn btn-default" name="provider" value="<%#: Item %>"
                    title="Hesabınızı kullanarak oturum<%#: Item %> açın.">
                    <%#: Item %>
                </button>
            </p>
        </ItemTemplate>
        <EmptyDataTemplate>
            <div>
                <p>Yapılandırılmış bir dış kimlik doğrulama hizmeti yok. Bu ASP.NET uygulamasını dış hizmetler üzerinden oturum açmayı destekleyecek şekilde ayarlamaya ilişkin ayrıntılar için <a href="https://go.microsoft.com/fwlink/?LinkId=252803">bu makaleye</a> bakın.</p>
            </div>
        </EmptyDataTemplate>
    </asp:ListView>
</div>