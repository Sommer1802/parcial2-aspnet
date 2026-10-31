using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace PARCIAL2_ASP.NET
{
    public partial class AdminFacturas : Page
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
                CargarFacturas();
            }
        }

        private void CargarFacturas()
        {
            try
            {
                string sql = @"
                    SELECT 
                        f.IdFactura, 
                        ('FAC-' + RIGHT('000000' + CAST(f.IdFactura AS VARCHAR), 6)) AS NumFactura, 
                        f.IdPedido, 
                        f.Fecha, 
                        f.MetodoPago, 
                        f.Total, 
                        c.Nombre AS Cliente, 
                        c.Documento 
                    FROM Factura f 
                    INNER JOIN Pedido p ON f.IdPedido = p.IdPedido 
                    INNER JOIN Cliente c ON p.IdCliente = c.IdCliente 
                    WHERE 1 = 1";

                string buscar = txtBuscar.Text.Trim();
                if (!string.IsNullOrEmpty(buscar))
                {
                    sql += " AND (c.Nombre LIKE @b OR c.Documento LIKE @b OR CAST(f.IdFactura AS VARCHAR) LIKE @b OR CAST(f.IdPedido AS VARCHAR) LIKE @b)";
                }

                sql += " ORDER BY f.IdFactura DESC";

                DataTable dt = Conexion.EjecutarConsulta(sql, new SqlParameter("@b", "%" + buscar + "%"));
                gvFacturas.DataSource = dt;
                gvFacturas.DataBind();

                decimal totalRecaudado = 0;
                foreach (DataRow r in dt.Rows)
                {
                    totalRecaudado += Convert.ToDecimal(r["Total"]);
                }

                lblTotalRecaudado.Text = "Total Facturado: $ " + totalRecaudado.ToString("N0") + " COP";
            }
            catch (Exception ex)
            {
                pnlMensaje.Visible = true;
                lblMensaje.Text = "Error al consultar facturas: " + ex.Message;
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            CargarFacturas();
        }

        protected void btnVerTodas_Click(object sender, EventArgs e)
        {
            txtBuscar.Text = string.Empty;
            CargarFacturas();
        }
    }
}
