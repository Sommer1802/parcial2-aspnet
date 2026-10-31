using System;
using System.Web.UI;

namespace PARCIAL2_ASP.NET
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ActualizarEstadoSesion();
            }
        }

        private void ActualizarEstadoSesion()
        {
            if (Session["Usuario"] != null)
            {
                phAnonimo.Visible = false;
                phAutenticado.Visible = true;

                string nombre = Session["Nombre"] != null ? Session["Nombre"].ToString() : Session["Usuario"].ToString();
                string rol = Session["Rol"] != null ? Session["Rol"].ToString() : "Usuario";

                litUsuarioNombre.Text = Server.HtmlEncode(nombre);
                litUsuarioRol.Text = Server.HtmlEncode(rol);

                if (rol.Equals("Cliente", StringComparison.OrdinalIgnoreCase))
                {
                    phMenuCliente.Visible = true;
                    phMenuAdmin.Visible = false;
                }
                else if (rol.Equals("Admin", StringComparison.OrdinalIgnoreCase) || rol.Equals("Empleado", StringComparison.OrdinalIgnoreCase))
                {
                    phMenuAdmin.Visible = true;
                    phMenuCliente.Visible = false;
                }
                else
                {
                    phMenuCliente.Visible = false;
                    phMenuAdmin.Visible = false;
                }
            }
            else
            {
                phAnonimo.Visible = true;
                phAutenticado.Visible = false;
                phMenuCliente.Visible = false;
                phMenuAdmin.Visible = false;
            }
        }
    }
}
