using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PARCIAL2_ASP.NET
{
    public partial class AdminClientes : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Rol"] == null || (!Session["Rol"].ToString().Equals("Admin", StringComparison.OrdinalIgnoreCase) && !Session["Rol"].ToString().Equals("Empleado", StringComparison.OrdinalIgnoreCase)))
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                CargarClientes();
            }
        }

        private void CargarClientes()
        {
            try
            {
                string sql = "SELECT IdCliente, Documento, Nombre, Telefono, Correo, Direccion, Usuario, Clave FROM Cliente WHERE 1 = 1";
                string buscar = txtBuscar.Text.Trim();
                if (!string.IsNullOrEmpty(buscar))
                {
                    sql += " AND (Nombre LIKE @b OR Documento LIKE @b OR Usuario LIKE @b)";
                }
                sql += " ORDER BY IdCliente ASC";

                DataTable dt = Conexion.EjecutarConsulta(sql, new SqlParameter("@b", "%" + buscar + "%"));
                gvClientes.DataSource = dt;
                gvClientes.DataBind();
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al listar clientes: " + ex.Message, "danger");
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string doc = txtDocumento.Text.Trim();
            string nom = txtNombre.Text.Trim();
            string tel = txtTelefono.Text.Trim();
            string cor = txtCorreo.Text.Trim();
            string dir = txtDireccion.Text.Trim();
            string usu = txtUsuario.Text.Trim();
            string cla = txtClave.Text.Trim();

            if (string.IsNullOrEmpty(doc) || string.IsNullOrEmpty(nom) || string.IsNullOrEmpty(usu) || string.IsNullOrEmpty(cla))
            {
                MostrarMensaje("Documento, nombre, usuario y clave son obligatorios.", "warning");
                return;
            }

            int idCli = 0;
            int.TryParse(hfIdCliente.Value, out idCli);

            try
            {
                if (idCli == 0)
                {
                    // Crear (Insert)
                    string sqlCheck = "SELECT COUNT(*) FROM Cliente WHERE Usuario = @u";
                    int exists = Convert.ToInt32(Conexion.EjecutarEscalar(sqlCheck, new SqlParameter("@u", usu)));
                    if (exists > 0)
                    {
                        MostrarMensaje("El nombre de usuario '" + usu + "' ya está registrado.", "warning");
                        return;
                    }

                    string sqlInsert = @"
                        INSERT INTO Cliente (Documento, Nombre, Telefono, Correo, Direccion, Usuario, Clave)
                        VALUES (@doc, @nom, @tel, @cor, @dir, @usu, @cla)";

                    Conexion.EjecutarComando(sqlInsert,
                        new SqlParameter("@doc", doc),
                        new SqlParameter("@nom", nom),
                        new SqlParameter("@tel", (object)tel ?? DBNull.Value),
                        new SqlParameter("@cor", (object)cor ?? DBNull.Value),
                        new SqlParameter("@dir", (object)dir ?? DBNull.Value),
                        new SqlParameter("@usu", usu),
                        new SqlParameter("@cla", cla));

                    MostrarMensaje("Cliente '" + nom + "' registrado correctamente.", "success");
                }
                else
                {
                    // Actualizar (Update)
                    string sqlUpdate = @"
                        UPDATE Cliente 
                        SET Documento = @doc, Nombre = @nom, Telefono = @tel, Correo = @cor, Direccion = @dir, Usuario = @usu, Clave = @cla
                        WHERE IdCliente = @id";

                    Conexion.EjecutarComando(sqlUpdate,
                        new SqlParameter("@doc", doc),
                        new SqlParameter("@nom", nom),
                        new SqlParameter("@tel", (object)tel ?? DBNull.Value),
                        new SqlParameter("@cor", (object)cor ?? DBNull.Value),
                        new SqlParameter("@dir", (object)dir ?? DBNull.Value),
                        new SqlParameter("@usu", usu),
                        new SqlParameter("@cla", cla),
                        new SqlParameter("@id", idCli));

                    MostrarMensaje("Cliente N° " + idCli + " actualizado correctamente.", "success");
                }

                LimpiarFormulario();
                CargarClientes();
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al procesar cliente: " + ex.Message, "danger");
            }
        }

        protected void gvClientes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                int idCli = Convert.ToInt32(e.CommandArgument);
                CargarClienteParaEditar(idCli);
            }
            else if (e.CommandName == "Eliminar")
            {
                int idCli = Convert.ToInt32(e.CommandArgument);
                EliminarCliente(idCli);
            }
        }

        private void CargarClienteParaEditar(int idCli)
        {
            try
            {
                string sql = "SELECT IdCliente, Documento, Nombre, Telefono, Correo, Direccion, Usuario, Clave FROM Cliente WHERE IdCliente = @id";
                DataTable dt = Conexion.EjecutarConsulta(sql, new SqlParameter("@id", idCli));
                if (dt.Rows.Count > 0)
                {
                    DataRow r = dt.Rows[0];
                    hfIdCliente.Value = r["IdCliente"].ToString();
                    txtDocumento.Text = r["Documento"].ToString();
                    txtNombre.Text = r["Nombre"].ToString();
                    txtTelefono.Text = r["Telefono"].ToString();
                    txtCorreo.Text = r["Correo"].ToString();
                    txtDireccion.Text = r["Direccion"].ToString();
                    txtUsuario.Text = r["Usuario"].ToString();
                    txtClave.Text = r["Clave"].ToString();

                    lblTituloForm.Text = "Editar Cliente N° " + idCli;
                    btnGuardar.Text = "🔄 Actualizar Cliente";
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al cargar cliente: " + ex.Message, "danger");
            }
        }

        private void EliminarCliente(int idCli)
        {
            try
            {
                // Verificar si tiene pedidos
                string checkPed = "SELECT COUNT(*) FROM Pedido WHERE IdCliente = @id";
                int pedidos = Convert.ToInt32(Conexion.EjecutarEscalar(checkPed, new SqlParameter("@id", idCli)));
                if (pedidos > 0)
                {
                    MostrarMensaje("No se puede eliminar este cliente porque tiene " + pedidos + " pedido(s) asociados en el sistema.", "warning");
                    return;
                }

                string sql = "DELETE FROM Cliente WHERE IdCliente = @id";
                Conexion.EjecutarComando(sql, new SqlParameter("@id", idCli));
                MostrarMensaje("Cliente eliminado correctamente.", "success");
                LimpiarFormulario();
                CargarClientes();
            }
            catch (Exception ex)
            {
                MostrarMensaje("No se pudo eliminar el cliente: " + ex.Message, "danger");
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            CargarClientes();
        }

        private void LimpiarFormulario()
        {
            hfIdCliente.Value = "0";
            txtDocumento.Text = string.Empty;
            txtNombre.Text = string.Empty;
            txtTelefono.Text = string.Empty;
            txtCorreo.Text = string.Empty;
            txtDireccion.Text = string.Empty;
            txtUsuario.Text = string.Empty;
            txtClave.Text = string.Empty;
            lblTituloForm.Text = "Registrar Nuevo Cliente";
            btnGuardar.Text = "💾 Guardar Cliente";
        }

        private void MostrarMensaje(string texto, string tipo)
        {
            pnlMensaje.Visible = true;
            pnlMensaje.CssClass = "alert alert-" + tipo + " alert-dismissible fade show";
            lblMensaje.Text = texto;
        }
    }
}
