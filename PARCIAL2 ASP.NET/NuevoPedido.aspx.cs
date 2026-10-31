using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PARCIAL2_ASP.NET
{
    public partial class NuevoPedido : Page
    {
        // Id del pedido que se está modificando (null = pedido nuevo)
        private int? IdPedidoEditar
        {
            get { return Session["CarritoPedido"] as int?; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Validar que el usuario sea Cliente registrado
            if (Session["Rol"] == null || !Session["Rol"].ToString().Equals("Cliente", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("~/Login.aspx?aviso=pedido");
                return;
            }

            if (!IsPostBack)
            {
                lblCliNombre.Text = Session["Nombre"] != null ? Session["Nombre"].ToString() : "Cliente";
                lblCliDoc.Text = Session["Documento"] != null ? Session["Documento"].ToString() : "N/A";

                // Modo edición: cargar el pedido pendiente en el carrito
                string editar = Request.QueryString["editar"];
                if (!string.IsNullOrEmpty(editar))
                {
                    int idEditar;
                    if (!int.TryParse(editar, out idEditar) || !CargarPedidoParaEditar(idEditar))
                    {
                        Response.Redirect("~/MisPedidos.aspx");
                        return;
                    }
                    litTitulo.Text = "Modificar Pedido N° " + idEditar;
                    litSubtitulo.Text = "Agregue, quite o cambie cantidades de los productos de su pedido pendiente";
                    btnConfirmarPedido.Text = "💾 Guardar Cambios del Pedido";
                }
                else if (IdPedidoEditar != null)
                {
                    // Se abandonó una edición: empezar con un carrito vacío
                    Session["Carrito"] = null;
                    Session["CarritoPedido"] = null;
                }

                CargarProductos();
                InicializarCarrito();

                // Si viene redirigido desde el catálogo con un producto preseleccionado
                if (!string.IsNullOrEmpty(Request.QueryString["prod"]))
                {
                    string prodId = Request.QueryString["prod"];
                    if (ddlProductos.Items.FindByValue(prodId) != null)
                    {
                        ddlProductos.SelectedValue = prodId;
                        MostrarDetalleProducto();
                        AgregarProductoAlCarrito(Convert.ToInt32(prodId), 1);
                    }
                }
                else
                {
                    MostrarDetalleProducto();
                }

                ActualizarGrillaCarrito();
            }
        }

        private void CargarProductos()
        {
            try
            {
                // Incluye también los productos que ya están en el pedido que se modifica
                string sql = @"
                    SELECT IdProducto, Nombre, Precio, Stock FROM Producto
                    WHERE Stock > 0 OR IdProducto IN (SELECT IdProducto FROM DetallePedido WHERE IdPedido = @ped)
                    ORDER BY Nombre ASC";
                DataTable dt = Conexion.EjecutarConsulta(sql, new SqlParameter("@ped", IdPedidoEditar ?? 0));
                ddlProductos.DataSource = dt;
                ddlProductos.DataTextField = "Nombre";
                ddlProductos.DataValueField = "IdProducto";
                ddlProductos.DataBind();
            }
            catch (Exception ex)
            {
                MostrarAlerta("Error al cargar productos: " + ex.Message, "danger");
            }
        }

        private void MostrarDetalleProducto()
        {
            if (ddlProductos.Items.Count == 0) return;

            int idProd = Convert.ToInt32(ddlProductos.SelectedValue);
            string sql = @"
                SELECT p.Nombre, p.Descripcion, p.Precio, c.Nombre as Categoria,
                    p.Stock + ISNULL((SELECT SUM(Cantidad) FROM DetallePedido WHERE IdPedido = @ped AND IdProducto = p.IdProducto), 0) AS Stock
                FROM Producto p
                INNER JOIN Categoria c ON p.IdCategoria = c.IdCategoria
                WHERE p.IdProducto = @id";

            DataTable dt = Conexion.EjecutarConsulta(sql, new SqlParameter("@id", idProd), new SqlParameter("@ped", IdPedidoEditar ?? 0));
            if (dt.Rows.Count > 0)
            {
                DataRow r = dt.Rows[0];
                lblCatProd.Text = r["Categoria"].ToString();
                decimal precio = Convert.ToDecimal(r["Precio"]);
                lblPrecioProd.Text = string.Format("$ {0:N0} COP", precio);
                int stock = Convert.ToInt32(r["Stock"]);
                lblStockProd.Text = stock + " unidades disponibles";
                lblDescProd.Text = r["Descripcion"].ToString();
            }
        }

        protected void ddlProductos_SelectedIndexChanged(object sender, EventArgs e)
        {
            MostrarDetalleProducto();
        }

        private void InicializarCarrito()
        {
            if (Session["Carrito"] == null)
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("IdProducto", typeof(int));
                dt.Columns.Add("Nombre", typeof(string));
                dt.Columns.Add("Cantidad", typeof(int));
                dt.Columns.Add("PrecioUnitario", typeof(decimal));
                dt.Columns.Add("Subtotal", typeof(decimal));
                Session["Carrito"] = dt;
            }
        }

        private DataTable ObtenerCarrito()
        {
            InicializarCarrito();
            return (DataTable)Session["Carrito"];
        }

        private void AgregarProductoAlCarrito(int idProd, int cantidad)
        {
            if (cantidad <= 0) cantidad = 1;

            DataTable dtCarrito = ObtenerCarrito();

            // Consultar datos del producto (al modificar, lo reservado en el pedido cuenta como disponible)
            string sql = @"
                SELECT Nombre, Precio,
                    Stock + ISNULL((SELECT SUM(Cantidad) FROM DetallePedido WHERE IdPedido = @ped AND IdProducto = @id), 0) AS Stock
                FROM Producto WHERE IdProducto = @id";
            DataTable dtProd = Conexion.EjecutarConsulta(sql, new SqlParameter("@id", idProd), new SqlParameter("@ped", IdPedidoEditar ?? 0));

            if (dtProd.Rows.Count == 0) return;

            string nombre = dtProd.Rows[0]["Nombre"].ToString();
            decimal precio = Convert.ToDecimal(dtProd.Rows[0]["Precio"]);
            int stockDisponible = Convert.ToInt32(dtProd.Rows[0]["Stock"]);

            // Verificar si ya está en el carrito
            DataRow[] existentes = dtCarrito.Select("IdProducto = " + idProd);
            if (existentes.Length > 0)
            {
                int nuevaCantidad = Convert.ToInt32(existentes[0]["Cantidad"]) + cantidad;
                if (nuevaCantidad > stockDisponible)
                {
                    MostrarAlerta("No hay suficiente stock. Stock disponible: " + stockDisponible, "warning");
                    return;
                }
                existentes[0]["Cantidad"] = nuevaCantidad;
                existentes[0]["Subtotal"] = nuevaCantidad * Convert.ToDecimal(existentes[0]["PrecioUnitario"]);
            }
            else
            {
                if (cantidad > stockDisponible)
                {
                    MostrarAlerta("No hay suficiente stock. Stock disponible: " + stockDisponible, "warning");
                    return;
                }
                DataRow nuevaFila = dtCarrito.NewRow();
                nuevaFila["IdProducto"] = idProd;
                nuevaFila["Nombre"] = nombre;
                nuevaFila["Cantidad"] = cantidad;
                nuevaFila["PrecioUnitario"] = precio;
                nuevaFila["Subtotal"] = cantidad * precio;
                dtCarrito.Rows.Add(nuevaFila);
            }

            Session["Carrito"] = dtCarrito;
            ActualizarGrillaCarrito();
        }

        private bool CargarPedidoParaEditar(int idPedido)
        {
            int idCliente = Convert.ToInt32(Session["IdCliente"]);

            // Solo se puede modificar un pedido propio que siga pendiente
            string sqlEstado = "SELECT Estado FROM Pedido WHERE IdPedido = @id AND IdCliente = @cli";
            object estado = Conexion.EjecutarEscalar(sqlEstado, new SqlParameter("@id", idPedido), new SqlParameter("@cli", idCliente));
            if (estado == null || !estado.ToString().Equals("Pendiente", StringComparison.OrdinalIgnoreCase))
            {
                return false;
            }

            string sqlItems = @"
                SELECT dp.IdProducto, p.Nombre, dp.Cantidad, dp.PrecioUnitario
                FROM DetallePedido dp
                INNER JOIN Producto p ON dp.IdProducto = p.IdProducto
                WHERE dp.IdPedido = @id";
            DataTable dtItems = Conexion.EjecutarConsulta(sqlItems, new SqlParameter("@id", idPedido));

            Session["Carrito"] = null;
            DataTable dtCarrito = ObtenerCarrito();
            foreach (DataRow item in dtItems.Rows)
            {
                int cantidad = Convert.ToInt32(item["Cantidad"]);
                decimal precio = Convert.ToDecimal(item["PrecioUnitario"]);

                DataRow fila = dtCarrito.NewRow();
                fila["IdProducto"] = Convert.ToInt32(item["IdProducto"]);
                fila["Nombre"] = item["Nombre"].ToString();
                fila["Cantidad"] = cantidad;
                fila["PrecioUnitario"] = precio;
                fila["Subtotal"] = cantidad * precio;
                dtCarrito.Rows.Add(fila);
            }

            Session["Carrito"] = dtCarrito;
            Session["CarritoPedido"] = idPedido;
            return true;
        }

        protected void btnAgregarItem_Click(object sender, EventArgs e)
        {
            if (ddlProductos.SelectedValue != null)
            {
                int idProd = Convert.ToInt32(ddlProductos.SelectedValue);
                int cant = 1;
                int.TryParse(txtCantidad.Text.Trim(), out cant);
                if (cant <= 0) cant = 1;

                AgregarProductoAlCarrito(idProd, cant);
            }
        }

        private void ActualizarGrillaCarrito()
        {
            DataTable dt = ObtenerCarrito();
            gvCarrito.DataSource = dt;
            gvCarrito.DataBind();

            decimal total = 0;
            foreach (DataRow r in dt.Rows)
            {
                total += Convert.ToDecimal(r["Subtotal"]);
            }

            lblTotalPedido.Text = string.Format("$ {0:N0} COP", total);
        }

        protected void gvCarrito_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            DataTable dt = ObtenerCarrito();
            if (e.RowIndex >= 0 && e.RowIndex < dt.Rows.Count)
            {
                dt.Rows.RemoveAt(e.RowIndex);
                Session["Carrito"] = dt;
                ActualizarGrillaCarrito();
            }
        }

        protected void btnVaciar_Click(object sender, EventArgs e)
        {
            Session["Carrito"] = null;
            InicializarCarrito();
            ActualizarGrillaCarrito();
        }

        protected void btnConfirmarPedido_Click(object sender, EventArgs e)
        {
            DataTable dt = ObtenerCarrito();
            if (dt.Rows.Count == 0)
            {
                MostrarAlerta("Su pedido está vacío. Debe agregar al menos un producto.", "warning");
                return;
            }

            int idCliente = Convert.ToInt32(Session["IdCliente"]);
            decimal total = 0;
            foreach (DataRow r in dt.Rows)
            {
                total += Convert.ToDecimal(r["Subtotal"]);
            }

            int? idEditar = IdPedidoEditar;
            string destino = null;

            using (SqlConnection cn = Conexion.ObtenerConexion())
            {
                cn.Open();
                SqlTransaction tr = cn.BeginTransaction();
                try
                {
                    int idPedido;
                    if (idEditar == null)
                    {
                        // 1. Insertar Pedido
                        string sqlPedido = @"
                            INSERT INTO Pedido (IdCliente, Fecha, Estado, Total)
                            VALUES (@cli, GETDATE(), 'Pendiente', @tot);
                            SELECT SCOPE_IDENTITY();";

                        SqlCommand cmdP = new SqlCommand(sqlPedido, cn, tr);
                        cmdP.Parameters.AddWithValue("@cli", idCliente);
                        cmdP.Parameters.AddWithValue("@tot", total);
                        idPedido = Convert.ToInt32(cmdP.ExecuteScalar());
                    }
                    else
                    {
                        idPedido = idEditar.Value;

                        // 1. Actualizar el total (solo si el pedido sigue pendiente y es del cliente)
                        string sqlActualizar = "UPDATE Pedido SET Total = @tot WHERE IdPedido = @id AND IdCliente = @cli AND Estado = 'Pendiente'";
                        SqlCommand cmdA = new SqlCommand(sqlActualizar, cn, tr);
                        cmdA.Parameters.AddWithValue("@tot", total);
                        cmdA.Parameters.AddWithValue("@id", idPedido);
                        cmdA.Parameters.AddWithValue("@cli", idCliente);
                        if (cmdA.ExecuteNonQuery() == 0)
                        {
                            throw new InvalidOperationException("El pedido ya no está pendiente y no se puede modificar.");
                        }

                        // Devolver al inventario el stock de los productos anteriores
                        string sqlDevolver = @"
                            UPDATE p
                            SET p.Stock = p.Stock + dp.Cantidad
                            FROM Producto p
                            INNER JOIN DetallePedido dp ON p.IdProducto = dp.IdProducto
                            WHERE dp.IdPedido = @id";
                        SqlCommand cmdDev = new SqlCommand(sqlDevolver, cn, tr);
                        cmdDev.Parameters.AddWithValue("@id", idPedido);
                        cmdDev.ExecuteNonQuery();

                        // Borrar el detalle anterior para registrarlo de nuevo
                        SqlCommand cmdBorrar = new SqlCommand("DELETE FROM DetallePedido WHERE IdPedido = @id", cn, tr);
                        cmdBorrar.Parameters.AddWithValue("@id", idPedido);
                        cmdBorrar.ExecuteNonQuery();
                    }

                    // 2. Insertar DetallePedido y Descontar Stock
                    foreach (DataRow r in dt.Rows)
                    {
                        int idProd = Convert.ToInt32(r["IdProducto"]);
                        int cant = Convert.ToInt32(r["Cantidad"]);
                        decimal precio = Convert.ToDecimal(r["PrecioUnitario"]);

                        string sqlDetalle = @"
                            INSERT INTO DetallePedido (IdPedido, IdProducto, Cantidad, PrecioUnitario)
                            VALUES (@idPed, @idProd, @cant, @precio)";

                        SqlCommand cmdD = new SqlCommand(sqlDetalle, cn, tr);
                        cmdD.Parameters.AddWithValue("@idPed", idPedido);
                        cmdD.Parameters.AddWithValue("@idProd", idProd);
                        cmdD.Parameters.AddWithValue("@cant", cant);
                        cmdD.Parameters.AddWithValue("@precio", precio);
                        cmdD.ExecuteNonQuery();

                        // Actualizar Stock
                        string sqlStock = "UPDATE Producto SET Stock = Stock - @c WHERE IdProducto = @p AND Stock >= @c";
                        SqlCommand cmdS = new SqlCommand(sqlStock, cn, tr);
                        cmdS.Parameters.AddWithValue("@c", cant);
                        cmdS.Parameters.AddWithValue("@p", idProd);
                        if (cmdS.ExecuteNonQuery() == 0)
                        {
                            throw new InvalidOperationException("No hay suficiente stock de " + r["Nombre"] + ".");
                        }
                    }

                    tr.Commit();
                    Session["Carrito"] = null;
                    Session["CarritoPedido"] = null;

                    // Pedido nuevo -> pantalla de pago; pedido modificado -> volver a Mis Pedidos
                    destino = idEditar == null
                        ? "~/PagarPedido.aspx?id=" + idPedido
                        : "~/MisPedidos.aspx?editado=" + idPedido;
                }
                catch (Exception ex)
                {
                    tr.Rollback();
                    MostrarAlerta("Error al procesar el pedido: " + ex.Message, "danger");
                }
            }

            // Se redirige fuera del try para que el Redirect no sea capturado como error
            if (destino != null)
            {
                Response.Redirect(destino);
            }
        }

        private void MostrarAlerta(string texto, string tipo)
        {
            pnlAlerta.Visible = true;
            pnlAlerta.CssClass = "alert alert-" + tipo + " alert-dismissible fade show";
            lblAlerta.Text = texto;
        }
    }
}
