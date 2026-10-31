using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PARCIAL2_ASP.NET
{
    public partial class AdminPedidos : Page
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
                CargarPedidos();
            }
        }

        private void CargarPedidos()
        {
            try
            {
                string sql = @"
                    SELECT 
                        p.IdPedido, 
                        p.Fecha, 
                        p.Estado, 
                        p.Total, 
                        c.Nombre AS Cliente, 
                        c.Documento 
                    FROM Pedido p 
                    INNER JOIN Cliente c ON p.IdCliente = c.IdCliente 
                    WHERE 1 = 1";

                string estado = ddlFiltroEstado.SelectedValue;
                string buscar = txtBuscar.Text.Trim();

                if (!string.IsNullOrEmpty(estado))
                {
                    sql += " AND p.Estado = @estado";
                }

                if (!string.IsNullOrEmpty(buscar))
                {
                    sql += " AND (c.Nombre LIKE @b OR c.Documento LIKE @b OR CAST(p.IdPedido AS VARCHAR) LIKE @b)";
                }

                sql += " ORDER BY p.IdPedido DESC";

                DataTable dt = Conexion.EjecutarConsulta(sql,
                    new SqlParameter("@estado", (object)estado ?? DBNull.Value),
                    new SqlParameter("@b", "%" + buscar + "%"));

                gvPedidos.DataSource = dt;
                gvPedidos.DataBind();
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al consultar pedidos: " + ex.Message, "danger");
            }
        }

        protected void ddlFiltroEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            CargarPedidos();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            CargarPedidos();
        }

        protected void gvPedidos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "VerDetalle")
            {
                int idPed = Convert.ToInt32(e.CommandArgument);
                CargarDetalle(idPed);
            }
            else if (e.CommandName == "EditarEstado")
            {
                int idPed = Convert.ToInt32(e.CommandArgument);
                PrepararCambioEstado(idPed);
            }
            else if (e.CommandName == "EliminarPedido")
            {
                int idPed = Convert.ToInt32(e.CommandArgument);
                EliminarPedido(idPed);
            }
        }

        private void CargarDetalle(int idPed)
        {
            try
            {
                lblNumPedidoDetalle.Text = idPed.ToString();
                string sql = @"
                    SELECT 
                        dp.Cantidad, 
                        dp.PrecioUnitario, 
                        (dp.Cantidad * dp.PrecioUnitario) AS Subtotal, 
                        p.Nombre, 
                        p.Descripcion 
                    FROM DetallePedido dp 
                    INNER JOIN Producto p ON dp.IdProducto = p.IdProducto 
                    WHERE dp.IdPedido = @id";

                DataTable dt = Conexion.EjecutarConsulta(sql, new SqlParameter("@id", idPed));
                gvDetalle.DataSource = dt;
                gvDetalle.DataBind();
                pnlDetalle.Visible = true;
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al cargar detalle: " + ex.Message, "danger");
            }
        }

        private void PrepararCambioEstado(int idPed)
        {
            lblPedidoAEditar.Text = idPed.ToString();
            string sql = "SELECT Estado FROM Pedido WHERE IdPedido = @id";
            object est = Conexion.EjecutarEscalar(sql, new SqlParameter("@id", idPed));
            if (est != null)
            {
                string estadoActual = est.ToString();
                if (ddlNuevoEstado.Items.FindByValue(estadoActual) != null)
                {
                    ddlNuevoEstado.SelectedValue = estadoActual;
                }
            }
            pnlCambiarEstado.Visible = true;
        }

        protected void btnGuardarEstado_Click(object sender, EventArgs e)
        {
            int idPed = 0;
            int.TryParse(lblPedidoAEditar.Text, out idPed);
            if (idPed > 0)
            {
                string nuevoEstado = ddlNuevoEstado.SelectedValue;
                string sql = "UPDATE Pedido SET Estado = @est WHERE IdPedido = @id";
                Conexion.EjecutarComando(sql, new SqlParameter("@est", nuevoEstado), new SqlParameter("@id", idPed));

                // Si se marca como pagado y no tiene factura, crear factura automática
                if (nuevoEstado.Equals("Pagado", StringComparison.OrdinalIgnoreCase))
                {
                    string checkFac = "SELECT COUNT(*) FROM Factura WHERE IdPedido = @id";
                    int countFac = Convert.ToInt32(Conexion.EjecutarEscalar(checkFac, new SqlParameter("@id", idPed)));
                    if (countFac == 0)
                    {
                        string sqlTotal = "SELECT Total FROM Pedido WHERE IdPedido = @id";
                        decimal total = Convert.ToDecimal(Conexion.EjecutarEscalar(sqlTotal, new SqlParameter("@id", idPed)));

                        string sqlInsFac = "INSERT INTO Factura (IdPedido, Fecha, MetodoPago, Total) VALUES (@id, GETDATE(), 'Pago Aprobado por Administrador', @tot)";
                        Conexion.EjecutarComando(sqlInsFac, new SqlParameter("@id", idPed), new SqlParameter("@tot", total));
                    }
                }

                MostrarMensaje("Estado del pedido N° " + idPed + " actualizado a '" + nuevoEstado + "'.", "success");
                pnlCambiarEstado.Visible = false;
                CargarPedidos();
            }
        }

        protected void btnCancelarCambio_Click(object sender, EventArgs e)
        {
            pnlCambiarEstado.Visible = false;
        }

        private void EliminarPedido(int idPed)
        {
            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                cn.Open();
                SqlTransaction tr = cn.BeginTransaction();
                try
                {
                    // 1. Eliminar facturas asociadas
                    string sqlFac = "DELETE FROM Factura WHERE IdPedido = @id";
                    SqlCommand cmdF = new SqlCommand(sqlFac, cn, tr);
                    cmdF.Parameters.AddWithValue("@id", idPed);
                    cmdF.ExecuteNonQuery();

                    // 2. Eliminar detalle
                    string sqlDet = "DELETE FROM DetallePedido WHERE IdPedido = @id";
                    SqlCommand cmdD = new SqlCommand(sqlDet, cn, tr);
                    cmdD.Parameters.AddWithValue("@id", idPed);
                    cmdD.ExecuteNonQuery();

                    // 3. Eliminar pedido
                    string sqlPed = "DELETE FROM Pedido WHERE IdPedido = @id";
                    SqlCommand cmdP = new SqlCommand(sqlPed, cn, tr);
                    cmdP.Parameters.AddWithValue("@id", idPed);
                    cmdP.ExecuteNonQuery();

                    tr.Commit();
                    MostrarMensaje("Pedido N° " + idPed + " eliminado del sistema exitosamente.", "success");
                    CargarPedidos();
                    pnlDetalle.Visible = false;
                }
                catch (Exception ex)
                {
                    tr.Rollback();
                    MostrarMensaje("Error al eliminar el pedido: " + ex.Message, "danger");
                }
            }
        }

        protected void btnCerrarDetalle_Click(object sender, EventArgs e)
        {
            pnlDetalle.Visible = false;
        }

        private void MostrarMensaje(string texto, string tipo)
        {
            pnlMensaje.Visible = true;
            pnlMensaje.CssClass = "alert alert-" + tipo + " alert-dismissible fade show";
            lblMensaje.Text = texto;
        }
    }
}
