<%@ Page Title="Gestión de Productos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminProductos.aspx.cs" Inherits="PARCIAL2_ASP.NET.AdminProductos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="py-3">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
            <div>
                <h2 class="fw-bold text-dark mb-1">
                    <i class="bi bi-box-seam-fill text-warning me-2"></i>Gestión de Productos e Inventario (CRUD)
                </h2>
                <p class="text-muted mb-0">Añadir, modificar, actualizar stock y retirar productos de tecnología y vigilancia</p>
            </div>
            <span class="badge bg-warning text-dark fs-6 px-3 py-2">
                <i class="bi bi-shield-check me-1"></i>Zona de Administración
            </span>
        </div>

        <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-info alert-dismissible fade show">
            <asp:Label ID="lblMensaje" runat="server"></asp:Label>
        </asp:Panel>

        <!-- Formulario CRUD de Producto -->
        <div class="card card-tecno p-4 mb-4 border-0">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold text-dark mb-0">
                    <asp:Label ID="lblTituloForm" runat="server" Text="Agregar Nuevo Producto al Catálogo"></asp:Label>
                </h5>
                <asp:HiddenField ID="hfIdProducto" runat="server" Value="0" />
            </div>

            <div class="row g-3">
                <div class="col-md-6 col-lg-5">
                    <label class="form-label fw-bold small">Nombre del Producto o Equipo: <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Ej: Cámara Giratoria 360 PTZ"></asp:TextBox>
                </div>
                <div class="col-md-6 col-lg-3">
                    <label class="form-label fw-bold small">Categoría: <span class="text-danger">*</span></label>
                    <asp:DropDownList ID="ddlCategoriaForm" runat="server" CssClass="form-select">
                    </asp:DropDownList>
                </div>
                <div class="col-md-6 col-lg-2">
                    <label class="form-label fw-bold small">Precio (COP): <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtPrecio" runat="server" TextMode="Number" CssClass="form-control" placeholder="Ej: 350000"></asp:TextBox>
                </div>
                <div class="col-md-6 col-lg-2">
                    <label class="form-label fw-bold small">Stock Inicial: <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtStock" runat="server" TextMode="Number" CssClass="form-control" placeholder="Ej: 15"></asp:TextBox>
                </div>
                <div class="col-12">
                    <label class="form-label fw-bold small">Descripción Técnica y Características:</label>
                    <asp:TextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control" placeholder="Detalles de resolución, zoom, intensificador de luz, conectividad..."></asp:TextBox>
                </div>
                <div class="col-12 text-end mt-3">
                    <asp:Button ID="btnLimpiar" runat="server" Text="Cancelar / Limpiar" CssClass="btn btn-outline-secondary me-2" OnClick="btnLimpiar_Click" />
                    <asp:Button ID="btnGuardar" runat="server" Text="💾 Guardar Producto" CssClass="btn btn-warning fw-bold px-4" OnClick="btnGuardar_Click" />
                </div>
            </div>
        </div>

        <!-- Tabla / GridView de Productos -->
        <div class="card card-tecno p-4 border-0">
            <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                <h5 class="fw-bold text-dark mb-0"><i class="bi bi-boxes text-warning me-2"></i>Inventario de Productos en Parque Central</h5>
                <div class="d-flex gap-2">
                    <asp:DropDownList ID="ddlFiltroCat" runat="server" CssClass="form-select form-select-sm" AutoPostBack="true" OnSelectedIndexChanged="ddlFiltroCat_SelectedIndexChanged">
                    </asp:DropDownList>
                    <div class="input-group" style="max-width: 250px;">
                        <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control form-control-sm" placeholder="Buscar producto..."></asp:TextBox>
                        <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-sm btn-warning" OnClick="btnBuscar_Click" />
                    </div>
                </div>
            </div>

            <asp:GridView ID="gvProductos" runat="server" AutoGenerateColumns="False" 
                CssClass="table table-hover table-tecno text-center" 
                OnRowCommand="gvProductos_RowCommand" EmptyDataText="No se encontraron productos con los filtros aplicados.">
                <Columns>
                    <asp:BoundField DataField="IdProducto" HeaderText="ID" ItemStyle-CssClass="fw-bold" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" ItemStyle-CssClass="text-start fw-bold" />
                    <asp:BoundField DataField="Categoria" HeaderText="Categoría" />
                    <asp:BoundField DataField="Precio" HeaderText="Precio" DataFormatString="$ {0:N0} COP" ItemStyle-CssClass="fw-bold text-primary" />
                    <asp:TemplateField HeaderText="Stock">
                        <ItemTemplate>
                            <span class='<%# Convert.ToInt32(Eval("Stock")) <= 5 ? "badge bg-danger" : "badge bg-success" %>'>
                                <%# Eval("Stock") %> unid.
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Descripcion" HeaderText="Descripción" ItemStyle-CssClass="text-start small text-muted" />
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <div class="d-flex justify-content-center gap-1">
                                <asp:Button ID="btnEditar" runat="server" Text="✏️ Editar" 
                                    CommandName="Editar" CommandArgument='<%# Eval("IdProducto") %>' 
                                    CssClass="btn btn-sm btn-outline-primary" />
                                <asp:Button ID="btnEliminar" runat="server" Text="🗑️ Eliminar" 
                                    CommandName="Eliminar" CommandArgument='<%# Eval("IdProducto") %>' 
                                    OnClientClick="return confirm('¿Está seguro de que desea eliminar este producto del inventario?');" 
                                    CssClass="btn btn-sm btn-outline-danger" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
