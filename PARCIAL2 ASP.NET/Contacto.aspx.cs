using System;
using System.Web.UI;

namespace PARCIAL2_ASP.NET
{
    public partial class Contacto : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
            pnlMensajeExito.Visible = true;
            txtNombre.Text = string.Empty;
            txtTelefono.Text = string.Empty;
            txtCorreo.Text = string.Empty;
            txtMensaje.Text = string.Empty;
        }
    }
}
