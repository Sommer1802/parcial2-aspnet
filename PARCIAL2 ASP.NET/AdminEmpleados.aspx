<%@ Page Title="Gestión de Empleados" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminEmpleados.aspx.cs" Inherits="PARCIAL2_ASP.NET.AdminEmpleados" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="py-3">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
            <div>
                <h2 class="fw-bold text-dark mb-1">
                    <i class="bi bi-people-fill text-primary me-2"></i>Gestión de Empleados (CRUD)
                </h2>
                <p class="text-muted mb-0">Módulo administrativo para Crear, Consultar, Actualizar y Eliminar personal de TecnoVigi</p>
            </div>
            <span class="badge bg-primary fs-6 px-3 py-2">
                <i class="bi bi-shield-check me-1"></i>Zona de Administración
            </span>
        </div>

        <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-info alert-dismissible fade show">
            <asp:Label ID="lblMensaje" runat="server"></asp:Label>
        </asp:Panel>

        <!-- Formulario CRUD de Empleado -->
        <div class="card card-tecno p-4 mb-4 border-0">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold text-dark mb-0">
                    <asp:Label ID="lblTituloForm" runat="server" Text="Registrar Nuevo Empleado"></asp:Label>
                </h5>
                <asp:HiddenField ID="hfIdEmpleado" runat="server" Value="0" />
            </div>

            <div class="row g-3">
                <div class="col-md-6 col-lg-4">
                    <label class="form-label fw-bold small">Nombre y Apellidos: <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Ej: Carlos Pérez"></asp:TextBox>
                </div>
                <div class="col-md-6 col-lg-4">
                    <label class="form-label fw-bold small">Cargo / Función: <span class="text-danger">*</span></label>
                    <asp:DropDownList ID="ddlCargo" runat="server" CssClass="form-select">
                        <asp:ListItem Text="Administrador" Value="Administrador"></asp:ListItem>
                        <asp:ListItem Text="Vendedor" Value="Vendedor" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Técnico de Vigilancia (SVC)" Value="Técnico de Vigilancia"></asp:ListItem>
                        <asp:ListItem Text="Técnico Informático (IMEI)" Value="Técnico Informático"></asp:ListItem>
                        <asp:ListItem Text="Instalador de Alarmas" Value="Instalador de Alarmas"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-6 col-lg-4">
                    <label class="form-label fw-bold small">Teléfono / Celular:</label>
                    <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="Ej: 300 456 7890"></asp:TextBox>
                </div>
                <div class="col-md-6 col-lg-4">
                    <label class="form-label fw-bold small">Correo Electrónico:</label>
                    <asp:TextBox ID="txtCorreo" runat="server" TextMode="Email" CssClass="form-control" placeholder="empleado@tecnovigi.com"></asp:TextBox>
                </div>
                <div class="col-md-6 col-lg-4">
                    <label class="form-label fw-bold small">Nombre de Usuario de Acceso: <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" placeholder="Ej: cperez"></asp:TextBox>
                </div>
                <div class="col-md-6 col-lg-4">
                    <label class="form-label fw-bold small">Contraseña: <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtClave" runat="server" CssClass="form-control" placeholder="Contraseña de acceso"></asp:TextBox>
                </div>
                <div class="col-12 text-end mt-3">
                    <asp:Button ID="btnLimpiar" runat="server" Text="Cancelar / Limpiar" CssClass="btn btn-outline-secondary me-2" OnClick="btnLimpiar_Click" />
                    <asp:Button ID="btnGuardar" runat="server" Text="💾 Guardar Empleado" CssClass="btn btn-primary fw-bold px-4" OnClick="btnGuardar_Click" />
                </div>
            </div>
        </div>

        <!-- Tabla / GridView de Empleados -->
        <div class="card card-tecno p-4 border-0">
            <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                <h5 class="fw-bold text-dark mb-0"><i class="bi bi-table text-primary me-2"></i>Listado de Empleados Registrados</h5>
                <div class="input-group" style="max-width: 320px;">
                    <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control form-control-sm" placeholder="Buscar por nombre o cargo..."></asp:TextBox>
                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-sm btn-primary" OnClick="btnBuscar_Click" />
                </div>
            </div>

            <asp:GridView ID="gvEmpleados" runat="server" AutoGenerateColumns="False" 
                CssClass="table table-hover table-tecno text-center" 
                OnRowCommand="gvEmpleados_RowCommand" EmptyDataText="No hay empleados registrados con el criterio especificado.">
                <Columns>
                    <asp:BoundField DataField="IdEmpleado" HeaderText="ID" ItemStyle-CssClass="fw-bold" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" ItemStyle-CssClass="text-start fw-bold" />
                    <asp:BoundField DataField="Cargo" HeaderText="Cargo" />
                    <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                    <asp:BoundField DataField="Correo" HeaderText="Correo" />
                    <asp:BoundField DataField="Usuario" HeaderText="Usuario" />
                    <asp:BoundField DataField="Clave" HeaderText="Clave" />
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <div class="d-flex justify-content-center gap-1">
                                <asp:Button ID="btnEditar" runat="server" Text="✏️ Editar" 
                                    CommandName="Editar" CommandArgument='<%# Eval("IdEmpleado") %>' 
                                    CssClass="btn btn-sm btn-outline-primary" />
                                <asp:Button ID="btnEliminar" runat="server" Text="🗑️ Eliminar" 
                                    CommandName="Eliminar" CommandArgument='<%# Eval("IdEmpleado") %>' 
                                    OnClientClick="return confirm('¿Está seguro de que desea eliminar este empleado?');" 
                                    CssClass="btn btn-sm btn-outline-danger" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
