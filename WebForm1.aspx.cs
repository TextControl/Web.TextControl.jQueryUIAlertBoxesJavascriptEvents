using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication9
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TextControl1.SetFileDirectoryAsync(Server.MapPath("documents"), TXTextControl.Web.FileType.Document);
        }
    }
}