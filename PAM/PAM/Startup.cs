using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(PAM.Startup))]
namespace PAM
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
