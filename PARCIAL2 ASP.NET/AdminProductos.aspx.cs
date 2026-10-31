using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PARCIAL2_ASP.NET
{
    public partial class AdminProductos : Page
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

                ddlCategoriaForm.DataSource = dt;
                ddlCategoriaForm.DataTextField = "Nombre";
                ddlCategoriaForm.DataValueField = "IdCategoria";
                ddlCategoriaForm.DataBind();

                ddlFiltroCat.DataSource = dt;
                ddlFiltroCat.DataTextField = "Nombre";
                ddlFiltroCat.DataValueField = "IdCategoria";
                ddlFiltroCat.DataBind();
                ddlFiltroCat.Items.Insert(0, new ListItem("-- Todas las Categorías --", "0"));
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al cargar categorías: " + ex.Message, "danger");
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
                        p.IdCategoria, 
                        c.Nombre AS Categoria 
                    FROM Producto p 
                    INNER JOIN Categoria c ON p.IdCategoria = c.IdCategoria 
                    WHERE 1 = 1";

                string buscar = txtBuscar.Text.Trim();
                int idCat = 0;
                int.TryParse(ddlFiltroCat.SelectedValue, out idCat);

                if (!string.IsNullOrEmpty(buscar))
                {
                    sql += " AND (p.Nombre LIKE @b OR p.Descripcion LIKE @b)";
                }

                if (idCat > 0)
                {
                    sql += " AND p.IdCategoria = @idCat";
                }

                sql += " ORDER BY p.IdProducto ASC";

                DataTable dt = Conexion.EjecutarConsulta(sql,
                    new SqlParameter("@b", "%" + buscar + "%"),
                    new SqlParameter("@idCat", idCat));

                gvProductos.DataSource = dt;
                gvProductos.DataBind();
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al listar productos: " + ex.Message, "danger");
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string nom = txtNombre.Text.Trim();
            int idCat = Convert.ToInt32(ddlCategoriaForm.SelectedValue);
            decimal precio = 0;
            decimal.TryParse(txtPrecio.Text.Trim(), out precio);
            int stock = 0;
            int.TryParse(txtStock.Text.Trim(), out stock);
            string desc = txtDescripcion.Text.Trim();

            if (string.IsNullOrEmpty(nom) || precio <= 0)
            {
                MostrarMensaje("El nombre del producto y un precio válido son obligatorios.", "warning");
                return;
            }

            int idProd = 0;
            int.TryParse(hfIdProducto.Value, out idProd);

            try
            {
                if (idProd == 0)
                {
                    // Crear
                    string sqlInsert = @"
                        INSERT INTO Producto (Nombre, Descripcion, Precio, Stock, IdCategoria)
                        VALUES (@nom, @desc, @precio, @stock, @cat)";

                    Conexion.EjecutarComando(sqlInsert,
                        new SqlParameter("@nom", nom),
                        new SqlParameter("@desc", (object)desc ?? DBNull.Value),
                        new SqlParameter("@precio", precio),
                        new SqlParameter("@stock", stock),
                        new SqlParameter("@cat", idCat));

                    MostrarMensaje("Producto '" + nom + "' agregado exitosamente al inventario.", "success");
                }
                else
                {
                    // Actualizar
                    string sqlUpdate = @"
                        UPDATE Producto 
                        SET Nombre = @nom, Descripcion = @desc, Precio = @precio, Stock = @stock, IdCategoria = @cat 
                        WHERE IdProducto = @id";

                    Conexion.EjecutarComando(sqlUpdate,
                        new SqlParameter("@nom", nom),
                        new SqlParameter("@desc", (object)desc ?? DBNull.Value),
                        new SqlParameter("@precio", precio),
                        new SqlParameter("@stock", stock),
                        new SqlParameter("@cat", idCat),
                        new SqlParameter("@id", idProd));

                    MostrarMensaje("Producto N° " + idProd + " actualizado correctamente.", "success");
                }

                LimpiarFormulario();
                CargarProductos();
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al guardar producto: " + ex.Message, "danger");
            }
        }

        protected void gvProductos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                int idProd = Convert.ToInt32(e.CommandArgument);
                CargarProductoParaEditar(idProd);
            }
            else if (e.CommandName == "Eliminar")
            {
                int idProd = Convert.ToInt32(e.CommandArgument);
                EliminarProducto(idProd);
            }
        }

        private void CargarProductoParaEditar(int idProd)
        {
            try
            {
                string sql = "SELECT IdProducto, Nombre, Descripcion, Precio, Stock, IdCategoria FROM Producto WHERE IdProducto = @id";
                DataTable dt = Conexion.EjecutarConsulta(sql, new SqlParameter("@id", idProd));
                if (dt.Rows.Count > 0)
                {
                    DataRow r = dt.Rows[0];
                    hfIdProducto.Value = r["IdProducto"].ToString();
                    txtNombre.Text = r["Nombre"].ToString();
                    if (ddlCategoriaForm.Items.FindByValue(r["IdCategoria"].ToString()) != null)
                    {
                        ddlCategoriaForm.SelectedValue = r["IdCategoria"].ToString();
                    }
                    txtPrecio.Text = Convert.ToInt64(r["Precio"]).ToString();
                    txtStock.Text = r["Stock"].ToString();
                    txtDescripcion.Text = r["Descripcion"].ToString();

                    lblTituloForm.Text = "Editar Producto N° " + idProd;
                    btnGuardar.Text = "🔄 Actualizar Producto";
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al cargar producto: " + ex.Message, "danger");
            }
        }

        private void EliminarProducto(int idProd)
        {
            try
            {
                // Verificar si está en detalles de pedidos existentes
                string check = "SELECT COUNT(*) FROM DetallePedido WHERE IdProducto = @id";
                int pedidos = Convert.ToInt32(Conexion.EjecutarEscalar(check, new SqlParameter("@id", idProd)));
                if (pedidos > 0)
                {
                    MostrarMensaje("No se puede eliminar el producto porque se encuentra registrado en " + pedidos + " pedido(s). Se recomienda cambiar su stock a 0.", "warning");
                    return;
                }

                string sql = "DELETE FROM Producto WHERE IdProducto = @id";
                Conexion.EjecutarComando(sql, new SqlParameter("@id", idProd));
                MostrarMensaje("Producto retirado correctamente del catálogo.", "success");
                LimpiarFormulario();
                CargarProductos();
            }
            catch (Exception ex)
            {
                MostrarMensaje("No se pudo eliminar el producto: " + ex.Message, "danger");
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            CargarProductos();
        }

        protected void ddlFiltroCat_SelectedIndexChanged(object sender, EventArgs e)
        {
            CargarProductos();
        }

        private void LimpiarFormulario()
        {
            hfIdProducto.Value = "0";
            txtNombre.Text = string.Empty;
            if (ddlCategoriaForm.Items.Count > 0) ddlCategoriaForm.SelectedIndex = 0;
            txtPrecio.Text = string.Empty;
            txtStock.Text = string.Empty;
            txtDescripcion.Text = string.Empty;
            lblTituloForm.Text = "Agregar Nuevo Producto al Catálogo";
            btnGuardar.Text = "💾 Guardar Producto";
        }

        private void MostrarMensaje(string texto, string tipo)
        {
            pnlMensaje.Visible = true;
            pnlMensaje.CssClass = "alert alert-" + tipo + " alert-dismissible fade show";
            lblMensaje.Text = texto;
        }
    }
}
