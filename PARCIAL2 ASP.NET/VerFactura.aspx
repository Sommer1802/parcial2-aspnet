<%@ Page Title="Factura de Venta Web" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VerFactura.aspx.cs" Inherits="PARCIAL2_ASP.NET.VerFactura" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="py-4">
        <!-- Barra de Botones Superiores (No se imprimen) -->
        <div class="d-flex justify-content-between align-items-center mb-4 d-print-none flex-wrap gap-2">
            <div>
                <a href="MisPedidos.aspx" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-left me-1"></i>Volver a Mis Pedidos
                </a>
                <a href="Productos.aspx" class="btn btn-outline-primary ms-1">
                    <i class="bi bi-bag me-1"></i>Seguir Comprando
                </a>
            </div>
            <div>
                <button type="button" class="btn btn-success fw-bold shadow-sm" onclick="window.print();">
                    <i class="bi bi-printer-fill me-1"></i>Imprimir Factura / Guardar PDF
                </button>
            </div>
        </div>

        <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger">
            <asp:Label ID="lblError" runat="server"></asp:Label>
        </asp:Panel>

        <!-- Documento de la Factura -->
        <div class="invoice-box border p-4 p-md-5 rounded-4 shadow bg-white" id="seccionFactura" runat="server">
            <!-- Encabezado de Factura -->
            <div class="row align-items-center pb-4 mb-4 border-bottom">
                <div class="col-sm-7">
                    <div class="d-flex align-items-center mb-2">
                        <i class="bi bi-shield-lock-fill text-primary display-5 me-2"></i>
                        <div>
                            <h2 class="fw-bold text-primary mb-0">TecnoVigi Barranquilla</h2>
                            <span class="small text-muted fw-bold">Tecnología y Seguridad Electrónica</span>
                        </div>
                    </div>
                    <p class="small text-muted mb-0">
                        <strong>NIT:</strong> 900.584.231-1 • Régimen Común<br />
                        <strong>Sede Principal:</strong> Sector Parque Central, Barranquilla - Colombia<br />
                        <strong>PBX:</strong> (605) 385-2000 • <strong>Email:</strong> facturacion@tecnovigi.com
                    </p>
                </div>
                <div class="col-sm-5 text-sm-end mt-3 mt-sm-0">
                    <div class="p-3 bg-light rounded-3 border d-inline-block text-center">
                        <span class="text-muted small fw-bold text-uppercase d-block">Factura Electrónica Web</span>
                        <h4 class="fw-bold text-danger mb-1">N° <asp:Label ID="lblNumFactura" runat="server"></asp:Label></h4>
                        <span class="badge bg-success px-3 py-1">PAGADA EN LÍNEA</span>
                    </div>
                </div>
            </div>

            <!-- Datos de Facturación y del Cliente -->
            <div class="row g-4 mb-4">
                <div class="col-md-6">
                    <div class="p-3 bg-light rounded-3 h-100">
                        <h6 class="fw-bold text-dark border-bottom pb-2 mb-2">
                            <i class="bi bi-person-fill text-primary me-1"></i>Datos del Cliente:
                        </h6>
                        <ul class="list-unstyled small mb-0">
                            <li class="mb-1"><strong>Nombre / Razón Social:</strong> <asp:Label ID="lblCliNombre" runat="server" CssClass="text-dark"></asp:Label></li>
                            <li class="mb-1"><strong>Documento de Identidad / C.C.:</strong> <asp:Label ID="lblCliDoc" runat="server" CssClass="text-dark"></asp:Label></li>
                            <li class="mb-1"><strong>Teléfono:</strong> <asp:Label ID="lblCliTel" runat="server" CssClass="text-dark"></asp:Label></li>
                            <li class="mb-1"><strong>Dirección de Entrega:</strong> <asp:Label ID="lblCliDir" runat="server" CssClass="text-dark"></asp:Label></li>
                            <li><strong>Ciudad:</strong> Barranquilla - Atlántico</li>
                        </ul>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="p-3 bg-light rounded-3 h-100">
                        <h6 class="fw-bold text-dark border-bottom pb-2 mb-2">
                            <i class="bi bi-receipt text-primary me-1"></i>Datos de la Transacción:
                        </h6>
                        <ul class="list-unstyled small mb-0">
                            <li class="mb-1"><strong>N° de Pedido:</strong> PED-<asp:Label ID="lblNumPedido" runat="server" CssClass="fw-bold text-primary"></asp:Label></li>
                            <li class="mb-1"><strong>Fecha y Hora de Emisión:</strong> <asp:Label ID="lblFechaEmision" runat="server"></asp:Label></li>
                            <li class="mb-1"><strong>Método de Pago:</strong> <asp:Label ID="lblMetodoPago" runat="server" CssClass="badge bg-primary"></asp:Label></li>
                            <li class="mb-1"><strong>Servidor de Emisión:</strong> Localhost - Visual Studio 202X</li>
                            <li><strong>Estado de la Orden:</strong> <span class="badge bg-success">Aprobada &amp; Pagada</span></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Tabla de Ítems Facturados -->
            <div class="table-responsive mb-4">
                <asp:GridView ID="gvItemsFactura" runat="server" AutoGenerateColumns="False" 
                    CssClass="table table-bordered table-tecno text-center">
                    <Columns>
                        <asp:BoundField DataField="Nombre" HeaderText="Descripción del Producto o Equipo" ItemStyle-CssClass="text-start fw-bold" />
                        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                        <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio Unitario" DataFormatString="$ {0:N0}" />
                        <asp:BoundField DataField="Subtotal" HeaderText="Subtotal (COP)" DataFormatString="$ {0:N0}" ItemStyle-CssClass="fw-bold text-dark text-end" HeaderStyle-CssClass="text-end" />
                    </Columns>
                </asp:GridView>
            </div>

            <!-- Totales de la Factura -->
            <div class="row justify-content-end mb-4">
                <div class="col-md-5">
                    <div class="p-3 bg-light rounded-3 border">
                        <div class="d-flex justify-content-between mb-2 small">
                            <span class="text-muted">Subtotal antes de impuestos:</span>
                            <asp:Label ID="lblSubtotal" runat="server" CssClass="fw-bold text-dark"></asp:Label>
                        </div>
                        <div class="d-flex justify-content-between mb-2 small">
                            <span class="text-muted">IVA Incluido (19%):</span>
                            <asp:Label ID="lblIva" runat="server" CssClass="fw-bold text-dark"></asp:Label>
                        </div>
                        <hr class="my-2" />
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="fs-5 fw-bold text-dark">TOTAL FACTURADO:</span>
                            <span class="fs-4 fw-bold text-primary">
                                <asp:Label ID="lblTotal" runat="server"></asp:Label>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Términos y Garantía en Parque Central -->
            <div class="border-top pt-3 small text-muted">
                <p class="mb-1">
                    <strong>Garantía y Condiciones:</strong> Todos los productos de tecnología y seguridad (ordenadores, impresoras, discos duros, cámaras y alarmas) cuentan con 1 año de garantía por defectos de fábrica directamente en nuestra sede de Parque Central, Barranquilla.
                </p>
                <p class="mb-0 text-center font-monospace small">
                    *** Esta es una factura electrónica válida generada en la Web por la aplicación TecnoVigi Barranquilla ***
                </p>
            </div>
        </div>
    </div>
</asp:Content>
