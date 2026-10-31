<%@ Page Title="Realizar Pedido" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NuevoPedido.aspx.cs" Inherits="PARCIAL2_ASP.NET.NuevoPedido" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="py-3">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
            <div>
                <h2 class="fw-bold text-dark mb-1">
                    <i class="bi bi-cart-plus-fill text-warning me-2"></i><asp:Literal ID="litTitulo" runat="server" Text="Gestión de Pedidos - Nueva Compra"></asp:Literal>
                </h2>
                <p class="text-muted mb-0"><asp:Literal ID="litSubtitulo" runat="server" Text="Seleccione los productos de tecnología y seguridad que desea incluir en su pedido"></asp:Literal></p>
            </div>
            <a href="MisPedidos.aspx" class="btn btn-outline-primary">
                <i class="bi bi-receipt-cutoff me-1"></i>Ver Mis Pedidos Anteriores
            </a>
        </div>

        <asp:Panel ID="pnlAlerta" runat="server" Visible="false" CssClass="alert alert-info alert-dismissible fade show">
            <asp:Label ID="lblAlerta" runat="server"></asp:Label>
        </asp:Panel>

        <div class="row g-4">
            <!-- Selección de Productos -->
            <div class="col-lg-5">
                <div class="card card-tecno p-4 border-0 mb-4">
                    <h5 class="fw-bold text-dark mb-3">
                        <i class="bi bi-box-seam text-primary me-2"></i>Agregar Producto al Pedido
                    </h5>

                    <div class="mb-3">
                        <label class="form-label fw-bold small">Seleccione un Producto:</label>
                        <asp:DropDownList ID="ddlProductos" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlProductos_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <div class="p-3 bg-light rounded-3 mb-3" id="pnlDetalleProd" runat="server">
                        <div class="d-flex justify-content-between mb-1">
                            <span class="small text-muted">Categoría:</span>
                            <asp:Label ID="lblCatProd" runat="server" CssClass="fw-bold small text-dark"></asp:Label>
                        </div>
                        <div class="d-flex justify-content-between mb-1">
                            <span class="small text-muted">Precio Unitario:</span>
                            <asp:Label ID="lblPrecioProd" runat="server" CssClass="fw-bold text-primary"></asp:Label>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="small text-muted">Disponibilidad (Stock):</span>
                            <asp:Label ID="lblStockProd" runat="server" CssClass="badge bg-success"></asp:Label>
                        </div>
                        <div class="small text-muted border-top pt-2">
                            <asp:Label ID="lblDescProd" runat="server"></asp:Label>
                        </div>
                    </div>

                    <div class="row g-2 align-items-end">
                        <div class="col-5">
                            <label class="form-label fw-bold small">Cantidad:</label>
                            <asp:TextBox ID="txtCantidad" runat="server" TextMode="Number" CssClass="form-control" Text="1" min="1"></asp:TextBox>
                        </div>
                        <div class="col-7">
                            <asp:Button ID="btnAgregarItem" runat="server" Text="➕ Agregar al Carrito" CssClass="btn btn-warning w-100 fw-bold py-2 shadow-sm" OnClick="btnAgregarItem_Click" />
                        </div>
                    </div>
                </div>

                <!-- Resumen de Cliente -->
                <div class="card card-tecno p-3 border-0 bg-primary bg-opacity-10">
                    <h6 class="fw-bold text-primary mb-2"><i class="bi bi-person-check-fill me-1"></i>Datos del Cliente Registrado:</h6>
                    <div class="small text-muted">
                        <strong>Nombre:</strong> <asp:Label ID="lblCliNombre" runat="server" CssClass="text-dark"></asp:Label><br />
                        <strong>Documento:</strong> <asp:Label ID="lblCliDoc" runat="server" CssClass="text-dark"></asp:Label><br />
                        <strong>Entrega en:</strong> Barranquilla - Parque Central
                    </div>
                </div>
            </div>

            <!-- Detalle de la Orden / Carrito Actual -->
            <div class="col-lg-7">
                <div class="card card-tecno p-4 border-0">
                    <h5 class="fw-bold text-dark mb-3">
                        <i class="bi bi-cart-check text-success me-2"></i>Artículos Seleccionados en el Pedido
                    </h5>

                    <asp:GridView ID="gvCarrito" runat="server" AutoGenerateColumns="False" 
                        CssClass="table table-bordered table-hover table-tecno text-center" 
                        OnRowDeleting="gvCarrito_RowDeleting" EmptyDataText="No ha seleccionado ningún producto aún. Seleccione uno de la lista para comenzar su pedido.">
                        <Columns>
                            <asp:BoundField DataField="Nombre" HeaderText="Producto" ItemStyle-CssClass="text-start fw-bold" />
                            <asp:BoundField DataField="Cantidad" HeaderText="Cant." />
                            <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio Unit." DataFormatString="$ {0:N0}" />
                            <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="$ {0:N0}" ItemStyle-CssClass="fw-bold text-primary" />
                            <asp:CommandField ShowDeleteButton="True" DeleteText="🗑️ Quitar" ButtonType="Button" ControlStyle-CssClass="btn btn-sm btn-outline-danger" />
                        </Columns>
                    </asp:GridView>

                    <!-- Total y Confirmación -->
                    <div class="border-top pt-3 mt-3">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="fs-5 text-muted">Total a Pagar del Pedido:</span>
                            <span class="fs-3 fw-bold text-success">
                                <asp:Label ID="lblTotalPedido" runat="server" Text="$ 0 COP"></asp:Label>
                            </span>
                        </div>
                        
                        <div class="d-flex gap-2 justify-content-end">
                            <asp:Button ID="btnVaciar" runat="server" Text="Vaciar Pedido" CssClass="btn btn-outline-secondary" OnClick="btnVaciar_Click" />
                            <asp:Button ID="btnConfirmarPedido" runat="server" Text="✅ Confirmar y Registrar Pedido" CssClass="btn btn-success fw-bold px-4 py-2 shadow" OnClick="btnConfirmarPedido_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
