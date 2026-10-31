<%@ Page Title="Gestión de Pedidos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminPedidos.aspx.cs" Inherits="PARCIAL2_ASP.NET.AdminPedidos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="py-3">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
            <div>
                <h2 class="fw-bold text-dark mb-1">
                    <i class="bi bi-cart-check-fill text-primary me-2"></i>Gestión de Pedidos de Clientes (CRUD)
                </h2>
                <p class="text-muted mb-0">Supervisar, actualizar estados, consultar detalles y gestionar órdenes de venta</p>
            </div>
            <span class="badge bg-primary fs-6 px-3 py-2">
                <i class="bi bi-shield-check me-1"></i>Zona de Administración
            </span>
        </div>

        <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-info alert-dismissible fade show">
            <asp:Label ID="lblMensaje" runat="server"></asp:Label>
        </asp:Panel>

        <!-- Filtros de Pedidos -->
        <div class="card card-tecno p-3 mb-4 border-0">
            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label fw-bold small text-muted">Filtrar por Estado:</label>
                    <asp:DropDownList ID="ddlFiltroEstado" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlFiltroEstado_SelectedIndexChanged">
                        <asp:ListItem Text="-- Todos los Estados --" Value=""></asp:ListItem>
                        <asp:ListItem Text="Pendiente" Value="Pendiente"></asp:ListItem>
                        <asp:ListItem Text="Pagado" Value="Pagado"></asp:ListItem>
                        <asp:ListItem Text="Despachado" Value="Despachado"></asp:ListItem>
                        <asp:ListItem Text="Cancelado" Value="Cancelado"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-5">
                    <label class="form-label fw-bold small text-muted">Buscar por Cliente o N° Pedido:</label>
                    <div class="input-group">
                        <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control" placeholder="Nombre de cliente o N° de orden..."></asp:TextBox>
                        <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-primary" OnClick="btnBuscar_Click" />
                    </div>
                </div>
                <div class="col-md-3 text-end">
                    <a href="NuevoPedido.aspx" class="btn btn-outline-success fw-bold w-100">
                        <i class="bi bi-plus-circle me-1"></i>Crear Pedido Manual
                    </a>
                </div>
            </div>
        </div>

        <!-- Tabla / GridView de Pedidos -->
        <div class="card card-tecno p-4 mb-4 border-0">
            <h5 class="fw-bold text-dark mb-3"><i class="bi bi-table text-primary me-2"></i>Órdenes Generadas en el Sistema</h5>

            <asp:GridView ID="gvPedidos" runat="server" AutoGenerateColumns="False" 
                CssClass="table table-hover table-tecno text-center" 
                OnRowCommand="gvPedidos_RowCommand" EmptyDataText="No se encontraron órdenes con los filtros seleccionados.">
                <Columns>
                    <asp:BoundField DataField="IdPedido" HeaderText="N° Pedido" ItemStyle-CssClass="fw-bold text-dark" />
                    <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                    <asp:BoundField DataField="Cliente" HeaderText="Cliente" ItemStyle-CssClass="text-start fw-bold" />
                    <asp:BoundField DataField="Documento" HeaderText="Documento" />
                    <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="$ {0:N0} COP" ItemStyle-CssClass="fw-bold text-primary" />
                    <asp:TemplateField HeaderText="Estado">
                        <ItemTemplate>
                            <span class='<%# Eval("Estado").ToString() == "Pagado" ? "badge bg-success" : (Eval("Estado").ToString() == "Pendiente" ? "badge bg-warning text-dark" : (Eval("Estado").ToString() == "Despachado" ? "badge bg-info text-dark" : "badge bg-secondary")) %>'>
                                <%# Eval("Estado") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <div class="d-flex justify-content-center gap-1">
                                <asp:Button ID="btnVer" runat="server" Text="🔍 Detalle" 
                                    CommandName="VerDetalle" CommandArgument='<%# Eval("IdPedido") %>' 
                                    CssClass="btn btn-sm btn-outline-primary" />

                                <asp:Button ID="btnEditarEstado" runat="server" Text="✏️ Estado" 
                                    CommandName="EditarEstado" CommandArgument='<%# Eval("IdPedido") %>' 
                                    CssClass="btn btn-sm btn-outline-warning" />

                                <asp:HyperLink ID="hlFactura" runat="server" 
                                    NavigateUrl='<%# "~/VerFactura.aspx?id=" + Eval("IdPedido") %>' 
                                    Visible='<%# Eval("Estado").ToString() == "Pagado" || Eval("Estado").ToString() == "Despachado" %>' 
                                    CssClass="btn btn-sm btn-success">
                                    📄 Factura
                                </asp:HyperLink>

                                <asp:Button ID="btnEliminar" runat="server" Text="🗑️ Eliminar" 
                                    CommandName="EliminarPedido" CommandArgument='<%# Eval("IdPedido") %>' 
                                    OnClientClick="return confirm('¿Está seguro de eliminar este registro de pedido?');" 
                                    CssClass="btn btn-sm btn-outline-danger" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <!-- Modal / Panel para Cambiar Estado de Pedido -->
        <asp:Panel ID="pnlCambiarEstado" runat="server" Visible="false" CssClass="card card-tecno p-4 mb-4 border-0 bg-warning bg-opacity-10">
            <h5 class="fw-bold text-dark mb-3">
                <i class="bi bi-pencil-square text-warning me-2"></i>Actualizar Estado del Pedido N° <asp:Label ID="lblPedidoAEditar" runat="server"></asp:Label>
            </h5>
            <div class="row g-3 align-items-end">
                <div class="col-md-5">
                    <label class="form-label fw-bold small">Nuevo Estado:</label>
                    <asp:DropDownList ID="ddlNuevoEstado" runat="server" CssClass="form-select">
                        <asp:ListItem Text="Pendiente" Value="Pendiente"></asp:ListItem>
                        <asp:ListItem Text="Pagado" Value="Pagado"></asp:ListItem>
                        <asp:ListItem Text="Despachado" Value="Despachado"></asp:ListItem>
                        <asp:ListItem Text="Cancelado" Value="Cancelado"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-7 d-flex gap-2">
                    <asp:Button ID="btnGuardarEstado" runat="server" Text="Actualizar Estado" CssClass="btn btn-warning fw-bold px-4" OnClick="btnGuardarEstado_Click" />
                    <asp:Button ID="btnCancelarCambio" runat="server" Text="Cancelar" CssClass="btn btn-outline-secondary" OnClick="btnCancelarCambio_Click" />
                </div>
            </div>
        </asp:Panel>

        <!-- Panel de Detalle del Pedido -->
        <asp:Panel ID="pnlDetalle" runat="server" Visible="false" CssClass="card card-tecno p-4 border-0 bg-light">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold text-dark mb-0">
                    <i class="bi bi-box-seam text-primary me-2"></i>Artículos del Pedido N° <asp:Label ID="lblNumPedidoDetalle" runat="server"></asp:Label>
                </h5>
                <asp:Button ID="btnCerrarDetalle" runat="server" Text="Cerrar Detalle ✕" CssClass="btn btn-sm btn-outline-secondary" OnClick="btnCerrarDetalle_Click" />
            </div>

            <asp:GridView ID="gvDetalle" runat="server" AutoGenerateColumns="False" 
                CssClass="table table-bordered table-tecno text-center bg-white">
                <Columns>
                    <asp:BoundField DataField="Nombre" HeaderText="Producto" ItemStyle-CssClass="text-start fw-bold" />
                    <asp:BoundField DataField="Descripcion" HeaderText="Descripción" ItemStyle-CssClass="text-start small text-muted" />
                    <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                    <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio Unitario" DataFormatString="$ {0:N0}" />
                    <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="$ {0:N0}" ItemStyle-CssClass="fw-bold text-primary" />
                </Columns>
            </asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>
