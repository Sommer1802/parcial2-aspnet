using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PARCIAL2_ASP.NET
{
    public partial class AdminEmpleados : Page
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
                CargarEmpleados();
            }
        }

        private void CargarEmpleados()
        {
            try
            {
                string sql = "SELECT IdEmpleado, Nombre, Cargo, Telefono, Correo, Usuario, Clave FROM Empleado WHERE 1 = 1";
                string buscar = txtBuscar.Text.Trim();
                if (!string.IsNullOrEmpty(buscar))
                {
                    sql += " AND (Nombre LIKE @b OR Cargo LIKE @b OR Usuario LIKE @b)";
                }
                sql += " ORDER BY IdEmpleado ASC";

                DataTable dt = Conexion.EjecutarConsulta(sql, new SqlParameter("@b", "%" + buscar + "%"));
                gvEmpleados.DataSource = dt;
                gvEmpleados.DataBind();
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al listar empleados: " + ex.Message, "danger");
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string nom = txtNombre.Text.Trim();
            string car = ddlCargo.SelectedValue;
            string tel = txtTelefono.Text.Trim();
            string cor = txtCorreo.Text.Trim();
            string usu = txtUsuario.Text.Trim();
            string cla = txtClave.Text.Trim();

            if (string.IsNullOrEmpty(nom) || string.IsNullOrEmpty(usu) || string.IsNullOrEmpty(cla))
            {
                MostrarMensaje("Nombre, usuario y clave son campos obligatorios.", "warning");
                return;
            }

            int idEmp = 0;
            int.TryParse(hfIdEmpleado.Value, out idEmp);

            try
            {
                if (idEmp == 0)
                {
                    // Crear (Insert)
                    string sqlCheck = "SELECT COUNT(*) FROM Empleado WHERE Usuario = @u";
                    int exists = Convert.ToInt32(Conexion.EjecutarEscalar(sqlCheck, new SqlParameter("@u", usu)));
                    if (exists > 0)
                    {
                        MostrarMensaje("El usuario '" + usu + "' ya existe para otro empleado.", "warning");
                        return;
                    }

                    string sqlInsert = @"
                        INSERT INTO Empleado (Nombre, Cargo, Telefono, Correo, Usuario, Clave)
                        VALUES (@nom, @car, @tel, @cor, @usu, @cla)";

                    Conexion.EjecutarComando(sqlInsert,
                        new SqlParameter("@nom", nom),
                        new SqlParameter("@car", car),
                        new SqlParameter("@tel", (object)tel ?? DBNull.Value),
                        new SqlParameter("@cor", (object)cor ?? DBNull.Value),
                        new SqlParameter("@usu", usu),
                        new SqlParameter("@cla", cla));

                    MostrarMensaje("Empleado '" + nom + "' registrado correctamente.", "success");
                }
                else
                {
                    // Actualizar (Update)
                    string sqlUpdate = @"
                        UPDATE Empleado 
                        SET Nombre = @nom, Cargo = @car, Telefono = @tel, Correo = @cor, Usuario = @usu, Clave = @cla
                        WHERE IdEmpleado = @id";

                    Conexion.EjecutarComando(sqlUpdate,
                        new SqlParameter("@nom", nom),
                        new SqlParameter("@car", car),
                        new SqlParameter("@tel", (object)tel ?? DBNull.Value),
                        new SqlParameter("@cor", (object)cor ?? DBNull.Value),
                        new SqlParameter("@usu", usu),
                        new SqlParameter("@cla", cla),
                        new SqlParameter("@id", idEmp));

                    MostrarMensaje("Empleado N° " + idEmp + " actualizado exitosamente.", "success");
                }

                LimpiarFormulario();
                CargarEmpleados();
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al guardar empleado: " + ex.Message, "danger");
            }
        }

        protected void gvEmpleados_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                int idEmp = Convert.ToInt32(e.CommandArgument);
                CargarEmpleadoParaEditar(idEmp);
            }
            else if (e.CommandName == "Eliminar")
            {
                int idEmp = Convert.ToInt32(e.CommandArgument);
                EliminarEmpleado(idEmp);
            }
        }

        private void CargarEmpleadoParaEditar(int idEmp)
        {
            try
            {
                string sql = "SELECT IdEmpleado, Nombre, Cargo, Telefono, Correo, Usuario, Clave FROM Empleado WHERE IdEmpleado = @id";
                DataTable dt = Conexion.EjecutarConsulta(sql, new SqlParameter("@id", idEmp));
                if (dt.Rows.Count > 0)
                {
                    DataRow r = dt.Rows[0];
                    hfIdEmpleado.Value = r["IdEmpleado"].ToString();
                    txtNombre.Text = r["Nombre"].ToString();
                    if (ddlCargo.Items.FindByValue(r["Cargo"].ToString()) != null)
                    {
                        ddlCargo.SelectedValue = r["Cargo"].ToString();
                    }
                    txtTelefono.Text = r["Telefono"].ToString();
                    txtCorreo.Text = r["Correo"].ToString();
                    txtUsuario.Text = r["Usuario"].ToString();
                    txtClave.Text = r["Clave"].ToString();

                    lblTituloForm.Text = "Editar Empleado N° " + idEmp;
                    btnGuardar.Text = "🔄 Actualizar Empleado";
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al cargar empleado para editar: " + ex.Message, "danger");
            }
        }

        private void EliminarEmpleado(int idEmp)
        {
            try
            {
                string sql = "DELETE FROM Empleado WHERE IdEmpleado = @id";
                Conexion.EjecutarComando(sql, new SqlParameter("@id", idEmp));
                MostrarMensaje("Empleado eliminado correctamente.", "success");
                LimpiarFormulario();
                CargarEmpleados();
            }
            catch (Exception ex)
            {
                MostrarMensaje("No se pudo eliminar el empleado: " + ex.Message, "danger");
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            CargarEmpleados();
        }

        private void LimpiarFormulario()
        {
            hfIdEmpleado.Value = "0";
            txtNombre.Text = string.Empty;
            ddlCargo.SelectedIndex = 0;
            txtTelefono.Text = string.Empty;
            txtCorreo.Text = string.Empty;
            txtUsuario.Text = string.Empty;
            txtClave.Text = string.Empty;
            lblTituloForm.Text = "Registrar Nuevo Empleado";
            btnGuardar.Text = "💾 Guardar Empleado";
        }

        private void MostrarMensaje(string texto, string tipo)
        {
            pnlMensaje.Visible = true;
            pnlMensaje.CssClass = "alert alert-" + tipo + " alert-dismissible fade show";
            lblMensaje.Text = texto;
        }
    }
}
