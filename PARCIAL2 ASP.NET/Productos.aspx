<%@ Page Title="Catálogo de Productos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="PARCIAL2_ASP.NET.Productos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="py-3">
        <!-- Encabezado de Productos -->
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
            <div>
                <h2 class="fw-bold text-dark mb-1">
                    <i class="bi bi-grid-3x3-gap-fill text-primary me-2"></i>Catálogo de Productos en Línea
                </h2>
                <p class="text-muted mb-0">Equipos de tecnología y sistemas de vigilancia disponibles en Parque Central, Barranquilla</p>
            </div>
            <% if (Session["Rol"] != null && Session["Rol"].ToString() == "Cliente") { %>
                <a href="NuevoPedido.aspx" class="btn btn-warning fw-bold shadow-sm">
                    <i class="bi bi-cart-fill me-1"></i>Ir a Mi Pedido Activo
                </a>
            <% } else { %>
                <a href="Login.aspx" class="btn btn-outline-primary">
                    <i class="bi bi-box-arrow-in-right me-1"></i>Inicia sesión para pedir
                </a>
            <% } %>
        </div>

        <!-- Filtros y Búsqueda -->
        <div class="card card-tecno p-3 mb-4 border-0">
            <div class="row g-3 align-items-end">
                <div class="col-md-5">
                    <label class="form-label fw-bold small text-muted">Buscar por nombre o descripción:</label>
                    <div class="input-group">
                        <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                        <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control" placeholder="Ej: Cámara, Portátil, Disco, Alarma..."></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-bold small text-muted">Filtrar por categoría:</label>
                    <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlCategoria_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
                <div class="col-md-3 d-flex gap-2">
                    <asp:Button ID="btnBuscar" runat="server" Text="Filtrar" CssClass="btn btn-primary fw-bold w-100" OnClick="btnBuscar_Click" />
                    <asp:Button ID="btnLimpiar" runat="server" Text="Todos" CssClass="btn btn-outline-secondary" OnClick="btnLimpiar_Click" />
                </div>
            </div>
        </div>

        <!-- Mensaje de resultados -->
        <asp:Label ID="lblMensaje" runat="server" CssClass="text-muted mb-3 d-block small"></asp:Label>

        <!-- Grilla de Productos -->
        <div class="row g-4 mb-4">
            <asp:Repeater ID="repProductos" runat="server" OnItemCommand="repProductos_ItemCommand">
                <ItemTemplate>
                    <div class="col-lg-4 col-md-6">
                        <div class="card card-tecno h-100 p-4 border-0 d-flex flex-column justify-content-between">
                            <div>
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <span class="badge bg-primary bg-opacity-10 text-primary fw-bold px-2 py-1">
                                        <i class="bi bi-tag-fill me-1"></i><%# Eval("Categoria") %>
                                    </span>
                                    <span class="badge <%# Convert.ToInt32(Eval("Stock")) > 5 ? "bg-success" : "bg-danger" %>">
                                        Stock: <%# Eval("Stock") %> unid.
                                    </span>
                                </div>
                                <h5 class="fw-bold text-dark mt-2 mb-2"><%# Eval("Nombre") %></h5>
                                <p class="small text-muted mb-3"><%# Eval("Descripcion") %></p>
                            </div>
                            <div class="pt-3 border-top mt-auto">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <span class="small text-muted">Precio Unitario:</span>
                                    <span class="fs-5 fw-bold text-primary">$ <%# string.Format("{0:N0}", Eval("Precio")) %> COP</span>
                                </div>
                                <asp:Button ID="btnComprar" runat="server" 
                                    CommandName="Comprar" 
                                    CommandArgument='<%# Eval("IdProducto") %>' 
                                    Text="🛒 Comprar / Agregar al Pedido" 
                                    CssClass="btn btn-primary w-100 fw-bold py-2 shadow-sm" />
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
