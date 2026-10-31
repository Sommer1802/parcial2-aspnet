using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace PARCIAL2_ASP.NET
{
    public partial class PagarPedido : Page
    {
        private int IdPedido
        {
            get
            {
                int id = 0;
                int.TryParse(Request.QueryString["id"], out id);
                return id;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (IdPedido <= 0)
                {
                    Response.Redirect("~/MisPedidos.aspx");
                    return;
                }
                CargarDatosPedido();
            }
        }

        private void CargarDatosPedido()
        {
            try
            {
                string sql = @"
                    SELECT p.IdPedido, p.Fecha, p.Estado, p.Total, c.Nombre as Cliente, c.Documento 
                    FROM Pedido p 
                    INNER JOIN Cliente c ON p.IdCliente = c.IdCliente 
                    WHERE p.IdPedido = @id";

                DataTable dt = Conexion.EjecutarConsulta(sql, new SqlParameter("@id", IdPedido));
                if (dt.Rows.Count == 0)
                {
                    Response.Redirect("~/MisPedidos.aspx");
                    return;
                }

                DataRow r = dt.Rows[0];
                string estado = r["Estado"].ToString();
                if (estado.Equals("Pagado", StringComparison.OrdinalIgnoreCase))
                {
                    // Ya está pagado -> ir a la factura
                    Response.Redirect("~/VerFactura.aspx?id=" + IdPedido);
                    return;
                }

                lblNumeroPedido.Text = r["IdPedido"].ToString();
                lblNombreCliente.Text = r["Cliente"].ToString();
                decimal total = Convert.ToDecimal(r["Total"]);
                lblTotal.Text = string.Format("$ {0:N0} COP", total);

                // Cargar Items
                string sqlItems = @"
                    SELECT dp.Cantidad, dp.PrecioUnitario, (dp.Cantidad * dp.PrecioUnitario) as Subtotal, p.Nombre 
                    FROM DetallePedido dp 
                    INNER JOIN Producto p ON dp.IdProducto = p.IdProducto 
                    WHERE dp.IdPedido = @id";

                DataTable dtItems = Conexion.EjecutarConsulta(sqlItems, new SqlParameter("@id", IdPedido));
                gvItems.DataSource = dtItems;
                gvItems.DataBind();
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                lblError.Text = "Error al consultar la orden: " + ex.Message;
            }
        }

        protected void btnPagar_Click(object sender, EventArgs e)
        {
            bool pagado = false;
            try
            {
                string metodoPago = rblMetodoPago.SelectedValue;
                if (string.IsNullOrEmpty(metodoPago)) metodoPago = "Tarjeta de Crédito/Débito";

                // Obtener total del pedido
                string sqlTotal = "SELECT Total FROM Pedido WHERE IdPedido = @id";
                object objTotal = Conexion.EjecutarEscalar(sqlTotal, new SqlParameter("@id", IdPedido));
                if (objTotal == null)
                {
                    pnlError.Visible = true;
                    lblError.Text = "No se encontró el pedido solicitado.";
                    return;
                }

                decimal total = Convert.ToDecimal(objTotal);

                using (SqlConnection cn = Conexion.ObtenerConexion())
                {
                    cn.Open();
                    SqlTransaction tr = cn.BeginTransaction();
                    try
                    {
                        // 1. Actualizar estado del pedido a 'Pagado'
                        string sqlUpdate = "UPDATE Pedido SET Estado = 'Pagado' WHERE IdPedido = @id";
                        SqlCommand cmdU = new SqlCommand(sqlUpdate, cn, tr);
                        cmdU.Parameters.AddWithValue("@id", IdPedido);
                        cmdU.ExecuteNonQuery();

                        // 2. Insertar registro en Factura
                        string sqlFactura = @"
                            INSERT INTO Factura (IdPedido, Fecha, MetodoPago, Total)
                            VALUES (@idPed, GETDATE(), @metodo, @tot);
                            SELECT SCOPE_IDENTITY();";

                        SqlCommand cmdF = new SqlCommand(sqlFactura, cn, tr);
                        cmdF.Parameters.AddWithValue("@idPed", IdPedido);
                        cmdF.Parameters.AddWithValue("@metodo", metodoPago);
                        cmdF.Parameters.AddWithValue("@tot", total);
                        cmdF.ExecuteNonQuery();

                        tr.Commit();
                        pagado = true;
                    }
                    catch (Exception ex)
                    {
                        tr.Rollback();
                        pnlError.Visible = true;
                        lblError.Text = "Error al registrar el pago: " + ex.Message;
                    }
                }
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                lblError.Text = "Error general: " + ex.Message;
            }

            // Redirigir a ver factura web generada (fuera del try para que el Redirect no sea capturado como error)
            if (pagado)
            {
                Response.Redirect("~/VerFactura.aspx?id=" + IdPedido);
            }
        }
    }
}
