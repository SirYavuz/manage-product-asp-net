using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(yavuz_final_ip2.Startup))]
namespace yavuz_final_ip2
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
