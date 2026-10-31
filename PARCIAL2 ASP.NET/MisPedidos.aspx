<%@ Page Title="Mis Pedidos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MisPedidos.aspx.cs" Inherits="PARCIAL2_ASP.NET.MisPedidos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="py-3">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
            <div>
                <h2 class="fw-bold text-dark mb-1">
                    <i class="bi bi-receipt-cutoff text-primary me-2"></i>Historial de Mis Pedidos
                </h2>
                <p class="text-muted mb-0">Consulte, pague, gestione y revise las facturas de sus compras en TecnoVigi Barranquilla</p>
            </div>
            <a href="NuevoPedido.aspx" class="btn btn-warning fw-bold shadow-sm">
                <i class="bi bi-cart-plus-fill me-1"></i>Crear Nuevo Pedido
            </a>
        </div>

        <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-info alert-dismissible fade show">
            <asp:Label ID="lblMensaje" runat="server"></asp:Label>
        </asp:Panel>

        <!-- Tabla de Pedidos del Cliente -->
        <div class="card card-tecno p-4 mb-4 border-0">
            <h5 class="fw-bold text-dark mb-3">
                <i class="bi bi-list-check text-primary me-2"></i>Mis Órdenes Registradas
            </h5>

            <asp:GridView ID="gvPedidos" runat="server" AutoGenerateColumns="False" 
                CssClass="table table-hover table-tecno text-center" 
                OnRowCommand="gvPedidos_RowCommand" EmptyDataText="Aún no ha realizado ningún pedido en nuestra tienda. ¡Haga clic en 'Crear Nuevo Pedido' para empezar!">
                <Columns>
                    <asp:BoundField DataField="IdPedido" HeaderText="N° Pedido" ItemStyle-CssClass="fw-bold text-dark" />
                    <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                    <asp:TemplateField HeaderText="Estado">
                        <ItemTemplate>
                            <span class='<%# Eval("Estado").ToString() == "Pagado" ? "badge bg-success" : (Eval("Estado").ToString() == "Pendiente" ? "badge bg-warning text-dark" : "badge bg-secondary") %>'>
                                <%# Eval("Estado") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="$ {0:N0} COP" ItemStyle-CssClass="fw-bold text-primary" />
                    
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <div class="d-flex justify-content-center gap-1">
                                <!-- Ver Detalle -->
                                <asp:Button ID="btnVerDetalle" runat="server" Text="🔍 Detalle" 
                                    CommandName="VerDetalle" CommandArgument='<%# Eval("IdPedido") %>' 
                                    CssClass="btn btn-sm btn-outline-info" />
                                
                                <!-- Botón Pagar (si está pendiente) -->
                                <asp:HyperLink ID="hlPagar" runat="server" 
                                    NavigateUrl='<%# "~/PagarPedido.aspx?id=" + Eval("IdPedido") %>' 
                                    Visible='<%# Eval("Estado").ToString() == "Pendiente" %>' 
                                    CssClass="btn btn-sm btn-success fw-bold">
                                    💳 Pagar
                                </asp:HyperLink>

                                <!-- Botón Modificar (si está pendiente) -->
                                <asp:HyperLink ID="hlModificar" runat="server"
                                    NavigateUrl='<%# "~/NuevoPedido.aspx?editar=" + Eval("IdPedido") %>'
                                    Visible='<%# Eval("Estado").ToString() == "Pendiente" %>'
                                    CssClass="btn btn-sm btn-outline-primary">
                                    ✏️ Modificar
                                </asp:HyperLink>

                                <!-- Botón Factura (si está pagado) -->
                                <asp:HyperLink ID="hlFactura" runat="server" 
                                    NavigateUrl='<%# "~/VerFactura.aspx?id=" + Eval("IdPedido") %>' 
                                    Visible='<%# Eval("Estado").ToString() == "Pagado" %>' 
                                    CssClass="btn btn-sm btn-primary">
                                    📄 Factura
                                </asp:HyperLink>

                                <!-- Botón Cancelar (si está pendiente) -->
                                <asp:Button ID="btnCancelar" runat="server" Text="❌ Cancelar" 
                                    CommandName="CancelarPedido" CommandArgument='<%# Eval("IdPedido") %>' 
                                    Visible='<%# Eval("Estado").ToString() == "Pendiente" %>' 
                                    OnClientClick="return confirm('¿Está seguro de que desea cancelar este pedido pendiente?');" 
                                    CssClass="btn btn-sm btn-outline-danger" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <!-- Panel de Detalle del Pedido Seleccionado -->
        <asp:Panel ID="pnlDetalle" runat="server" Visible="false" CssClass="card card-tecno p-4 border-0 bg-light">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold text-dark mb-0">
                    <i class="bi bi-info-circle-fill text-info me-2"></i>Detalle de Productos - Pedido N° <asp:Label ID="lblNumPedidoDetalle" runat="server"></asp:Label>
                </h5>
                <asp:Button ID="btnCerrarDetalle" runat="server" Text="Cerrar Detalle ✕" CssClass="btn btn-sm btn-outline-secondary" OnClick="btnCerrarDetalle_Click" />
            </div>

            <asp:GridView ID="gvDetallePedido" runat="server" AutoGenerateColumns="False" 
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
