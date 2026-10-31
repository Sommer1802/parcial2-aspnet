using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace PARCIAL2_ASP.NET
{
    public partial class VerFactura : Page
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
            if (!IsPostBack)
            {
                if (IdPedido <= 0)
                {
                    MostrarError("No se proporcionó un número de pedido válido para consultar la factura.");
                    return;
                }
                CargarFactura();
            }
        }

        private void CargarFactura()
        {
            try
            {
                string sqlFactura = @"
                    SELECT 
                        f.IdFactura, 
                        f.Fecha AS FechaFactura, 
                        f.MetodoPago, 
                        f.Total AS TotalFactura, 
                        p.IdPedido, 
                        p.Fecha AS FechaPedido, 
                        c.Nombre AS Cliente, 
                        c.Documento, 
                        c.Telefono, 
                        c.Direccion 
                    FROM Factura f 
                    INNER JOIN Pedido p ON f.IdPedido = p.IdPedido 
                    INNER JOIN Cliente c ON p.IdCliente = c.IdCliente 
                    WHERE p.IdPedido = @id";

                DataTable dtFactura = Conexion.EjecutarConsulta(sqlFactura, new SqlParameter("@id", IdPedido));
                if (dtFactura.Rows.Count == 0)
                {
                    // Si no tiene factura registrada aún (por ejemplo pedido pendiente)
                    MostrarError("Aún no se ha generado factura para el pedido N° " + IdPedido + ". Si el pedido está pendiente, por favor realice el pago primero.");
                    return;
                }

                DataRow rf = dtFactura.Rows[0];
                int idFac = Convert.ToInt32(rf["IdFactura"]);
                lblNumFactura.Text = "FAC-" + idFac.ToString("D6");
                lblNumPedido.Text = rf["IdPedido"].ToString();
                DateTime fecha = Convert.ToDateTime(rf["FechaFactura"]);
                lblFechaEmision.Text = fecha.ToString("dd/MM/yyyy hh:mm tt");
                lblMetodoPago.Text = rf["MetodoPago"].ToString();

                lblCliNombre.Text = rf["Cliente"].ToString();
                lblCliDoc.Text = rf["Documento"].ToString();
                lblCliTel.Text = !string.IsNullOrEmpty(rf["Telefono"].ToString()) ? rf["Telefono"].ToString() : "N/A";
                lblCliDir.Text = !string.IsNullOrEmpty(rf["Direccion"].ToString()) ? rf["Direccion"].ToString() : "Sector Parque Central, Barranquilla";

                decimal total = Convert.ToDecimal(rf["TotalFactura"]);
                decimal subtotal = Math.Round(total / 1.19m, 2);
                decimal iva = total - subtotal;

                lblSubtotal.Text = string.Format("$ {0:N0} COP", subtotal);
                lblIva.Text = string.Format("$ {0:N0} COP", iva);
                lblTotal.Text = string.Format("$ {0:N0} COP", total);

                // Cargar Items
                string sqlItems = @"
                    SELECT 
                        p.Nombre, 
                        dp.Cantidad, 
                        dp.PrecioUnitario, 
                        (dp.Cantidad * dp.PrecioUnitario) AS Subtotal 
                    FROM DetallePedido dp 
                    INNER JOIN Producto p ON dp.IdProducto = p.IdProducto 
                    WHERE dp.IdPedido = @id";

                DataTable dtItems = Conexion.EjecutarConsulta(sqlItems, new SqlParameter("@id", IdPedido));
                gvItemsFactura.DataSource = dtItems;
                gvItemsFactura.DataBind();
            }
            catch (Exception ex)
            {
                MostrarError("Error al generar la factura: " + ex.Message);
            }
        }

        private void MostrarError(string texto)
        {
            pnlError.Visible = true;
            lblError.Text = texto;
            seccionFactura.Visible = false;
        }
    }
}
