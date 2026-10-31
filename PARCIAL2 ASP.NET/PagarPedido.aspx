<%@ Page Title="Pagar Pedido" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PagarPedido.aspx.cs" Inherits="PARCIAL2_ASP.NET.PagarPedido" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row justify-content-center py-4">
        <div class="col-lg-8 col-md-10">
            <div class="card card-tecno p-4 p-md-5 border-0 shadow">
                <div class="text-center mb-4">
                    <div class="bg-success bg-opacity-10 text-success p-3 rounded-circle d-inline-block mb-3">
                        <i class="bi bi-credit-card-2-front-fill fs-1"></i>
                    </div>
                    <h3 class="fw-bold text-dark">Pasarela de Pago Seguro</h3>
                    <p class="text-muted small">Finalice su compra para generar su factura oficial en la web - TecnoVigi Barranquilla</p>
                </div>

                <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger small">
                    <i class="bi bi-x-circle-fill me-1"></i>
                    <asp:Label ID="lblError" runat="server"></asp:Label>
                </asp:Panel>

                <!-- Resumen del Pedido -->
                <div class="p-3 bg-light rounded-3 mb-4 border">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <span class="text-muted small">Orden a Pagar:</span>
                            <h5 class="fw-bold text-dark mb-0">Pedido N° <asp:Label ID="lblNumeroPedido" runat="server"></asp:Label></h5>
                            <span class="small text-muted">Cliente: <asp:Label ID="lblNombreCliente" runat="server" CssClass="text-dark fw-bold"></asp:Label></span>
                        </div>
                        <div class="col-md-6 text-md-end mt-2 mt-md-0">
                            <span class="text-muted small">Total a Cancelar:</span>
                            <h3 class="fw-bold text-success mb-0">
                                <asp:Label ID="lblTotal" runat="server"></asp:Label>
                            </h3>
                        </div>
                    </div>
                </div>

                <!-- Detalle rápido de productos en la orden -->
                <h6 class="fw-bold text-dark mb-2 small"><i class="bi bi-box-seam me-1"></i>Productos incluidos:</h6>
                <asp:GridView ID="gvItems" runat="server" AutoGenerateColumns="False" CssClass="table table-sm table-bordered text-center small mb-4">
                    <Columns>
                        <asp:BoundField DataField="Nombre" HeaderText="Producto" ItemStyle-CssClass="text-start" />
                        <asp:BoundField DataField="Cantidad" HeaderText="Cant." />
                        <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio" DataFormatString="$ {0:N0}" />
                        <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="$ {0:N0}" ItemStyle-CssClass="fw-bold text-primary" />
                    </Columns>
                </asp:GridView>

                <!-- Selección de Método de Pago -->
                <h5 class="fw-bold text-dark mb-3">
                    <i class="bi bi-wallet2 text-primary me-2"></i>Seleccione su Método de Pago
                </h5>

                <div class="mb-3">
                    <asp:RadioButtonList ID="rblMetodoPago" runat="server" CssClass="form-check" RepeatLayout="UnorderedList">
                        <asp:ListItem Text="💳 Tarjeta de Crédito / Débito (Visa, Mastercard, Amex)" Value="Tarjeta de Crédito/Débito" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="🏦 PSE - Débito Bancario en Línea (Ahorros / Corriente)" Value="PSE Bancario"></asp:ListItem>
                        <asp:ListItem Text="📱 Transferencia Digital (Bancolombia / Nequi / Daviplata)" Value="Transferencia Digital"></asp:ListItem>
                        <asp:ListItem Text="💵 Pago en Efectivo / Contraentrega en Parque Central" Value="Efectivo Contraentrega"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <label class="form-label fw-bold small">Número de Referencia / Comprobante (Simulado):</label>
                        <asp:TextBox ID="txtReferencia" runat="server" CssClass="form-control" Text="REF-984723"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold small">Nota o Comentario de Entrega:</label>
                        <asp:TextBox ID="txtNotas" runat="server" CssClass="form-control" placeholder="Ej: Entregar en horario de oficina"></asp:TextBox>
                    </div>
                </div>

                <div class="d-flex gap-2 justify-content-end border-top pt-3">
                    <a href="MisPedidos.aspx" class="btn btn-outline-secondary">Cancelar y Volver</a>
                    <asp:Button ID="btnPagar" runat="server" Text="🔒 Confirmar y Procesar Pago" CssClass="btn btn-success fw-bold px-4 py-2 shadow" OnClick="btnPagar_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
