using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PARCIAL2_ASP.NET
{
    public partial class Productos : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarCategorias();
                CargarProductos();
            }
        }

        private void CargarCategorias()
        {
            try
            {
                string sql = "SELECT IdCategoria, Nombre FROM Categoria ORDER BY Nombre ASC";
                DataTable dt = Conexion.EjecutarConsulta(sql);
                ddlCategoria.DataSource = dt;
                ddlCategoria.DataTextField = "Nombre";
                ddlCategoria.DataValueField = "IdCategoria";
                ddlCategoria.DataBind();
                ddlCategoria.Items.Insert(0, new ListItem("-- Todas las Categorías --", "0"));
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error cargando categorías: " + ex.Message;
            }
        }

        private void CargarProductos()
        {
            try
            {
                string sql = @"
                    SELECT 
                        p.IdProducto, 
                        p.Nombre, 
                        p.Descripcion, 
                        p.Precio, 
                        p.Stock, 
                        c.Nombre AS Categoria 
                    FROM Producto p 
                    INNER JOIN Categoria c ON p.IdCategoria = c.IdCategoria 
                    WHERE 1 = 1";

                string filtroNombre = txtBuscar.Text.Trim();
                int idCat = 0;
                int.TryParse(ddlCategoria.SelectedValue, out idCat);

                if (!string.IsNullOrEmpty(filtroNombre))
                {
                    sql += " AND (p.Nombre LIKE @buscar OR p.Descripcion LIKE @buscar)";
                }

                if (idCat > 0)
                {
                    sql += " AND p.IdCategoria = @idCat";
                }

                sql += " ORDER BY p.IdProducto ASC";

                SqlParameter p1 = new SqlParameter("@buscar", "%" + filtroNombre + "%");
                SqlParameter p2 = new SqlParameter("@idCat", idCat);

                DataTable dt = Conexion.EjecutarConsulta(sql, p1, p2);
                repProductos.DataSource = dt;
                repProductos.DataBind();

                lblMensaje.Text = "Mostrando " + dt.Rows.Count + " productos disponibles en nuestra sede de Parque Central.";
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al listar productos: " + ex.Message;
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            CargarProductos();
        }

        protected void ddlCategoria_SelectedIndexChanged(object sender, EventArgs e)
        {
            CargarProductos();
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtBuscar.Text = string.Empty;
            ddlCategoria.SelectedValue = "0";
            CargarProductos();
        }

        protected void repProductos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Comprar")
            {
                string idProd = e.CommandArgument.ToString();

                // Verificar si hay sesión de Cliente activa
                if (Session["Rol"] != null && Session["Rol"].ToString().Equals("Cliente", StringComparison.OrdinalIgnoreCase))
                {
                    Response.Redirect("~/NuevoPedido.aspx?prod=" + idProd);
                }
                else
                {
                    // No está autenticado como cliente -> redirigir a Login con aviso
                    Response.Redirect("~/Login.aspx?aviso=pedido&prod=" + idProd);
                }
            }
        }
    }
}
