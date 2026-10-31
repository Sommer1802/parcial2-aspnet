<%@ Page Title="Facturación General" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminFacturas.aspx.cs" Inherits="PARCIAL2_ASP.NET.AdminFacturas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="py-3">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
            <div>
                <h2 class="fw-bold text-dark mb-1">
                    <i class="bi bi-file-earmark-spreadsheet-fill text-danger me-2"></i>Facturas Emitidas en la Web
                </h2>
                <p class="text-muted mb-0">Control de comprobantes fiscales electrónicos generados en la tienda de Parque Central</p>
            </div>
            <span class="badge bg-danger fs-6 px-3 py-2">
                <i class="bi bi-shield-check me-1"></i>Zona de Administración
            </span>
        </div>

        <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert alert-info alert-dismissible fade show">
            <asp:Label ID="lblMensaje" runat="server"></asp:Label>
        </asp:Panel>

        <!-- Filtros y Búsqueda -->
        <div class="card card-tecno p-3 mb-4 border-0">
            <div class="row g-3 align-items-end">
                <div class="col-md-8">
                    <label class="form-label fw-bold small text-muted">Buscar por cliente, documento o N° de factura:</label>
                    <div class="input-group">
                        <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control" placeholder="Nombre de cliente, cédula o número de factura..."></asp:TextBox>
                        <asp:Button ID="btnBuscar" runat="server" Text="Filtrar Facturas" CssClass="btn btn-danger" OnClick="btnBuscar_Click" />
                    </div>
                </div>
                <div class="col-md-4 text-end">
                    <asp:Button ID="btnVerTodas" runat="server" Text="Mostrar Todas" CssClass="btn btn-outline-secondary w-100" OnClick="btnVerTodas_Click" />
                </div>
            </div>
        </div>

        <!-- Tabla de Facturas -->
        <div class="card card-tecno p-4 border-0">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold text-dark mb-0"><i class="bi bi-receipt text-danger me-2"></i>Comprobantes Registrados</h5>
                <asp:Label ID="lblTotalRecaudado" runat="server" CssClass="badge bg-success fs-6 px-3 py-2"></asp:Label>
            </div>

            <asp:GridView ID="gvFacturas" runat="server" AutoGenerateColumns="False" 
                CssClass="table table-hover table-tecno text-center" 
                EmptyDataText="Aún no se han generado facturas en el sistema. Los clientes registrados generan facturas al completar el pago de sus pedidos.">
                <Columns>
                    <asp:BoundField DataField="NumFactura" HeaderText="N° Factura" ItemStyle-CssClass="fw-bold text-danger" />
                    <asp:BoundField DataField="IdPedido" HeaderText="N° Pedido" ItemStyle-CssClass="fw-bold text-dark" />
                    <asp:BoundField DataField="Fecha" HeaderText="Fecha y Hora" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                    <asp:BoundField DataField="Cliente" HeaderText="Cliente" ItemStyle-CssClass="text-start fw-bold" />
                    <asp:BoundField DataField="Documento" HeaderText="Documento" />
                    <asp:BoundField DataField="MetodoPago" HeaderText="Método de Pago" />
                    <asp:BoundField DataField="Total" HeaderText="Total Pagado" DataFormatString="$ {0:N0} COP" ItemStyle-CssClass="fw-bold text-primary" />
                    <asp:TemplateField HeaderText="Acción">
                        <ItemTemplate>
                            <a href='<%# "VerFactura.aspx?id=" + Eval("IdPedido") %>' class="btn btn-sm btn-outline-danger fw-bold" target="_blank">
                                <i class="bi bi-printer me-1"></i>Ver / Imprimir
                            </a>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
