using System;
using System.Data;
using System.Web.UI;

namespace PARCIAL2_ASP.NET
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProductosDestacados();
            }
        }

        private void CargarProductosDestacados()
        {
            try
            {
                string sql = @"
                    SELECT TOP 6 
                        p.IdProducto, 
                        p.Nombre, 
                        p.Descripcion, 
                        p.Precio, 
                        p.Stock, 
                        c.Nombre AS Categoria 
                    FROM Producto p 
                    INNER JOIN Categoria c ON p.IdCategoria = c.IdCategoria 
                    ORDER BY p.IdProducto ASC";

                DataTable dt = Conexion.EjecutarConsulta(sql);
                repDestacados.DataSource = dt;
                repDestacados.DataBind();
            }
            catch (Exception)
            {
                // Manejo silencioso en caso de error inicial
            }
        }
    }
}
