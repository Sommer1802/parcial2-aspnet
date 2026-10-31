using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace PARCIAL2_ASP.NET
{
    public partial class Registro : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            pnlError.Visible = false;
            string doc = txtDocumento.Text.Trim();
            string nom = txtNombre.Text.Trim();
            string tel = txtTelefono.Text.Trim();
            string cor = txtCorreo.Text.Trim();
            string dir = txtDireccion.Text.Trim();
            string usu = txtUsuario.Text.Trim();
            string cla = txtClave.Text.Trim();

            if (string.IsNullOrEmpty(doc) || string.IsNullOrEmpty(nom) || string.IsNullOrEmpty(usu) || string.IsNullOrEmpty(cla))
            {
                pnlError.Visible = true;
                lblError.Text = "Por favor complete todos los campos obligatorios (*).";
                return;
            }

            try
            {
                // Verificar si el usuario ya existe en Cliente o Empleado
                string checkSql = "SELECT COUNT(*) FROM Cliente WHERE Usuario = @u";
                int existe = Convert.ToInt32(Conexion.EjecutarEscalar(checkSql, new SqlParameter("@u", usu)));
                if (existe > 0)
                {
                    pnlError.Visible = true;
                    lblError.Text = "El nombre de usuario '" + usu + "' ya está registrado. Por favor elija otro.";
                    return;
                }

                // Insertar Cliente y obtener nuevo IdCliente
                string insertSql = @"
                    INSERT INTO Cliente (Documento, Nombre, Telefono, Correo, Direccion, Usuario, Clave)
                    VALUES (@doc, @nom, @tel, @cor, @dir, @usu, @cla);
                    SELECT SCOPE_IDENTITY();";

                object newId = Conexion.EjecutarEscalar(insertSql,
                    new SqlParameter("@doc", doc),
                    new SqlParameter("@nom", nom),
                    new SqlParameter("@tel", (object)tel ?? DBNull.Value),
                    new SqlParameter("@cor", (object)cor ?? DBNull.Value),
                    new SqlParameter("@dir", (object)dir ?? DBNull.Value),
                    new SqlParameter("@usu", usu),
                    new SqlParameter("@cla", cla));

                int idCliente = Convert.ToInt32(newId);

                // Auto-login
                Session["Usuario"] = usu;
                Session["Nombre"] = nom;
                Session["Documento"] = doc;
                Session["IdCliente"] = idCliente;
                Session["Rol"] = "Cliente";

                Response.Redirect("~/Productos.aspx");
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                lblError.Text = "Error al registrar cliente: " + ex.Message;
            }
        }
    }
}
