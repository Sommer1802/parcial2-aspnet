using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PARCIAL2_ASP.NET
{
    public partial class MisPedidos : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Rol"] == null || !Session["Rol"].ToString().Equals("Cliente", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("~/Login.aspx?aviso=pedido");
                return;
            }

            if (!IsPostBack)
            {
                CargarPedidos();

                // Mensaje al volver de modificar un pedido
                if (!string.IsNullOrEmpty(Request.QueryString["editado"]))
                {
                    MostrarMensaje("El pedido N° " + Server.HtmlEncode(Request.QueryString["editado"]) + " fue modificado correctamente. Puede pagarlo cuando desee.", "success");
                }
            }
        }

        private void CargarPedidos()
        {
            try
            {
                int idCliente = Convert.ToInt32(Session["IdCliente"]);
                string sql = "SELECT IdPedido, Fecha, Estado, Total FROM Pedido WHERE IdCliente = @cli ORDER BY IdPedido DESC";
                DataTable dt = Conexion.EjecutarConsulta(sql, new SqlParameter("@cli", idCliente));
                gvPedidos.DataSource = dt;
                gvPedidos.DataBind();
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al consultar pedidos: " + ex.Message, "danger");
            }
        }

        protected void gvPedidos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "VerDetalle")
            {
                int idPed = Convert.ToInt32(e.CommandArgument);
                CargarDetalle(idPed);
            }
            else if (e.CommandName == "CancelarPedido")
            {
                int idPed = Convert.ToInt32(e.CommandArgument);
                CancelarPedido(idPed);
            }
        }

        private void CargarDetalle(int idPedido)
        {
            try
            {
                lblNumPedidoDetalle.Text = idPedido.ToString();
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

                DataTable dt = Conexion.EjecutarConsulta(sql, new SqlParameter("@id", idPedido));
                gvDetallePedido.DataSource = dt;
                gvDetallePedido.DataBind();
                pnlDetalle.Visible = true;
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al cargar detalle: " + ex.Message, "danger");
            }
        }

        private void CancelarPedido(int idPedido)
        {
            try
            {
                int idCliente = Convert.ToInt32(Session["IdCliente"]);

                // Revertir stock y actualizar estado
                using (SqlConnection cn = Conexion.ObtenerConexion())
                {
                    cn.Open();
                    SqlTransaction tr = cn.BeginTransaction();
                    try
                    {
                        // 1. Devolver stock a los productos
                        string sqlStock = @"
                            UPDATE p 
                            SET p.Stock = p.Stock + dp.Cantidad 
                            FROM Producto p 
                            INNER JOIN DetallePedido dp ON p.IdProducto = dp.IdProducto 
                            WHERE dp.IdPedido = @id";

                        SqlCommand cmdS = new SqlCommand(sqlStock, cn, tr);
                        cmdS.Parameters.AddWithValue("@id", idPedido);
                        cmdS.ExecuteNonQuery();

                        // 2. Cambiar estado a Cancelado
                        string sqlEstado = "UPDATE Pedido SET Estado = 'Cancelado' WHERE IdPedido = @id AND IdCliente = @cli AND Estado = 'Pendiente'";
                        SqlCommand cmdE = new SqlCommand(sqlEstado, cn, tr);
                        cmdE.Parameters.AddWithValue("@id", idPedido);
                        cmdE.Parameters.AddWithValue("@cli", idCliente);
                        cmdE.ExecuteNonQuery();

                        tr.Commit();
                        MostrarMensaje("El pedido N° " + idPedido + " ha sido cancelado con éxito y el stock fue reincorporado.", "success");
                        CargarPedidos();
                        pnlDetalle.Visible = false;
                    }
                    catch (Exception ex)
                    {
                        tr.Rollback();
                        MostrarMensaje("Error al cancelar pedido: " + ex.Message, "danger");
                    }
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error: " + ex.Message, "danger");
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
