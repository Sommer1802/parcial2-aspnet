<%@ Page Title="Gestión de Clientes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminClientes.aspx.cs" Inherits="PARCIAL2_ASP.NET.AdminClientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="py-3">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
            <div>
                <h2 class="fw-bold text-dark mb-1">
                    <i class="bi bi-person-lines-fill text-success me-2"></i>Gestión de Clientes (CRUD)
                </h2>
                <p class="text-muted mb-0">Módulo administrativo para Crear, Consultar, Actualizar y Eliminar cuentas de clientes</p>
            </div>
            <span class="badge bg-success fs-6 px-3 py-2">
                <i class="bi bi-shield-check me-1"></i>Zona de Administración
            </span>
        </div>

        <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-info alert-dismissible fade show">
            <asp:Label ID="lblMensaje" runat="server"></asp:Label>
        </asp:Panel>

        <!-- Formulario CRUD de Cliente -->
        <div class="card card-tecno p-4 mb-4 border-0">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold text-dark mb-0">
                    <asp:Label ID="lblTituloForm" runat="server" Text="Registrar Nuevo Cliente"></asp:Label>
                </h5>
                <asp:HiddenField ID="hfIdCliente" runat="server" Value="0" />
            </div>

            <div class="row g-3">
                <div class="col-md-6 col-lg-3">
                    <label class="form-label fw-bold small">Documento / C.C.: <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtDocumento" runat="server" CssClass="form-control" placeholder="Ej: 1045123456"></asp:TextBox>
                </div>
                <div class="col-md-6 col-lg-5">
                    <label class="form-label fw-bold small">Nombre y Apellidos: <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Ej: María Gómez"></asp:TextBox>
                </div>
                <div class="col-md-6 col-lg-4">
                    <label class="form-label fw-bold small">Teléfono / Celular:</label>
                    <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="Ej: 300 123 4567"></asp:TextBox>
                </div>
                <div class="col-md-6 col-lg-4">
                    <label class="form-label fw-bold small">Correo Electrónico:</label>
                    <asp:TextBox ID="txtCorreo" runat="server" TextMode="Email" CssClass="form-control" placeholder="cliente@correo.com"></asp:TextBox>
                </div>
                <div class="col-md-6 col-lg-4">
                    <label class="form-label fw-bold small">Dirección en Barranquilla:</label>
                    <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" placeholder="Ej: Cra 45 # 50-10"></asp:TextBox>
                </div>
                <div class="col-md-6 col-lg-2">
                    <label class="form-label fw-bold small">Usuario: <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" placeholder="mgomez"></asp:TextBox>
                </div>
                <div class="col-md-6 col-lg-2">
                    <label class="form-label fw-bold small">Contraseña: <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtClave" runat="server" CssClass="form-control" placeholder="Clave"></asp:TextBox>
                </div>
                <div class="col-12 text-end mt-3">
                    <asp:Button ID="btnLimpiar" runat="server" Text="Cancelar / Limpiar" CssClass="btn btn-outline-secondary me-2" OnClick="btnLimpiar_Click" />
                    <asp:Button ID="btnGuardar" runat="server" Text="💾 Guardar Cliente" CssClass="btn btn-success fw-bold px-4" OnClick="btnGuardar_Click" />
                </div>
            </div>
        </div>

        <!-- Tabla / GridView de Clientes -->
        <div class="card card-tecno p-4 border-0">
            <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                <h5 class="fw-bold text-dark mb-0"><i class="bi bi-table text-success me-2"></i>Listado de Clientes Registrados</h5>
                <div class="input-group" style="max-width: 320px;">
                    <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control form-control-sm" placeholder="Buscar por documento, nombre o usuario..."></asp:TextBox>
                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-sm btn-success" OnClick="btnBuscar_Click" />
                </div>
            </div>

            <asp:GridView ID="gvClientes" runat="server" AutoGenerateColumns="False" 
                CssClass="table table-hover table-tecno text-center" 
                OnRowCommand="gvClientes_RowCommand" EmptyDataText="No hay clientes registrados que coincidan con la búsqueda.">
                <Columns>
                    <asp:BoundField DataField="IdCliente" HeaderText="ID" ItemStyle-CssClass="fw-bold" />
                    <asp:BoundField DataField="Documento" HeaderText="Documento" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre y Apellidos" ItemStyle-CssClass="text-start fw-bold" />
                    <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                    <asp:BoundField DataField="Correo" HeaderText="Correo" />
                    <asp:BoundField DataField="Direccion" HeaderText="Dirección" />
                    <asp:BoundField DataField="Usuario" HeaderText="Usuario" />
                    <asp:BoundField DataField="Clave" HeaderText="Clave" />
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <div class="d-flex justify-content-center gap-1">
                                <asp:Button ID="btnEditar" runat="server" Text="✏️ Editar" 
                                    CommandName="Editar" CommandArgument='<%# Eval("IdCliente") %>' 
                                    CssClass="btn btn-sm btn-outline-primary" />
                                <asp:Button ID="btnEliminar" runat="server" Text="🗑️ Eliminar" 
                                    CommandName="Eliminar" CommandArgument='<%# Eval("IdCliente") %>' 
                                    OnClientClick="return confirm('¿Está seguro de que desea eliminar este cliente?');" 
                                    CssClass="btn btn-sm btn-outline-danger" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
