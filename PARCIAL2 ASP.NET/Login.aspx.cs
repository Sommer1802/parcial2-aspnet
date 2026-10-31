using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace PARCIAL2_ASP.NET
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["aviso"] == "pedido")
                {
                    pnlAviso.Visible = true;
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            pnlError.Visible = false;
            string usuario = txtUsuario.Text.Trim();
            string clave = txtClave.Text.Trim();

            if (string.IsNullOrEmpty(usuario) || string.IsNullOrEmpty(clave))
            {
                pnlError.Visible = true;
                lblError.Text = "Por favor ingrese su usuario y contraseña.";
                return;
            }

            try
            {
                // 1. Verificar si es Empleado / Administrador
                string sqlEmp = "SELECT IdEmpleado, Nombre, Cargo, Usuario FROM Empleado WHERE Usuario = @u AND Clave = @c";
                DataTable dtEmp = Conexion.EjecutarConsulta(sqlEmp, new SqlParameter("@u", usuario), new SqlParameter("@c", clave));

                if (dtEmp.Rows.Count > 0)
                {
                    DataRow r = dtEmp.Rows[0];
                    Session["Usuario"] = r["Usuario"].ToString();
                    Session["Nombre"] = r["Nombre"].ToString();
                    Session["Cargo"] = r["Cargo"].ToString();
                    Session["IdEmpleado"] = Convert.ToInt32(r["IdEmpleado"]);

                    string cargo = r["Cargo"].ToString();
                    if (cargo.IndexOf("Admin", StringComparison.OrdinalIgnoreCase) >= 0)
                    {
                        Session["Rol"] = "Admin";
                    }
                    else
                    {
                        Session["Rol"] = "Empleado";
                    }

                    Response.Redirect("~/AdminPedidos.aspx");
                    return;
                }

                // 2. Verificar si es Cliente
                string sqlCli = "SELECT IdCliente, Nombre, Documento, Usuario FROM Cliente WHERE Usuario = @u AND Clave = @c";
                DataTable dtCli = Conexion.EjecutarConsulta(sqlCli, new SqlParameter("@u", usuario), new SqlParameter("@c", clave));

                if (dtCli.Rows.Count > 0)
                {
                    DataRow r = dtCli.Rows[0];
                    Session["Usuario"] = r["Usuario"].ToString();
                    Session["Nombre"] = r["Nombre"].ToString();
                    Session["Documento"] = r["Documento"].ToString();
                    Session["IdCliente"] = Convert.ToInt32(r["IdCliente"]);
                    Session["Rol"] = "Cliente";

                    if (!string.IsNullOrEmpty(Request.QueryString["prod"]))
                    {
                        Response.Redirect("~/NuevoPedido.aspx?prod=" + Request.QueryString["prod"]);
                    }
                    else
                    {
                        Response.Redirect("~/MisPedidos.aspx");
                    }
                    return;
                }

                // Si no coincide con ninguno
                pnlError.Visible = true;
                lblError.Text = "Usuario o contraseña incorrectos. Por favor verifique sus datos.";
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                lblError.Text = "Error al intentar iniciar sesión: " + ex.Message;
            }
        }
    }
}
