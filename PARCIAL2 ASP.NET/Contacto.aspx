<%@ Page Title="Contacto" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contacto.aspx.cs" Inherits="PARCIAL2_ASP.NET.Contacto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="py-3">
        <div class="p-4 p-md-5 mb-4 rounded-4 text-white shadow-sm hero-contacto">
            <h1 class="display-5 fw-bold mb-2">Contacto &amp; Ubicación</h1>
            <p class="lead mb-0">
                Estamos ubicados en <strong>Parque Central, Barranquilla</strong>. Visítanos o envíanos tu solicitud y nuestro equipo técnico te responderá de inmediato.
            </p>
        </div>

        <div class="row g-4">
            <!-- Formulario de Contacto -->
            <div class="col-lg-7">
                <div class="card card-tecno p-4 border-0">
                    <h4 class="fw-bold text-dark mb-3">
                        <i class="bi bi-chat-left-dots text-primary me-2"></i>Envíanos un Mensaje
                    </h4>
                    
                    <asp:Panel ID="pnlMensajeExito" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle-fill me-2"></i>
                        <strong>¡Mensaje Enviado con Éxito!</strong> Gracias por contactar a TecnoVigi Barranquilla. Uno de nuestros asesores comerciales se comunicará contigo a la brevedad.
                    </asp:Panel>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold small">Nombre Completo:</label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Ej: Juan Pérez" required="true"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small">Teléfono / Celular:</label>
                            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="Ej: 300 123 4567" required="true"></asp:TextBox>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-bold small">Correo Electrónico:</label>
                            <asp:TextBox ID="txtCorreo" runat="server" TextMode="Email" CssClass="form-control" placeholder="nombre@correo.com" required="true"></asp:TextBox>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-bold small">Asunto del Contacto:</label>
                            <asp:DropDownList ID="ddlAsunto" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Cotización de Cámaras de Vigilancia (SVC)" Value="SVC"></asp:ListItem>
                                <asp:ListItem Text="Instalación de Sistemas de Alarmas" Value="ALARMAS"></asp:ListItem>
                                <asp:ListItem Text="Mantenimiento o Reparación de Equipos (IMEI)" Value="IMEI"></asp:ListItem>
                                <asp:ListItem Text="Compra de Computadores e Impresoras" Value="PRODUCTOS"></asp:ListItem>
                                <asp:ListItem Text="Otro motivo / Consulta general" Value="OTRO"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-bold small">Mensaje o Detalle de su Solicitud:</label>
                            <asp:TextBox ID="txtMensaje" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" placeholder="Describa el servicio o producto de su interés..."></asp:TextBox>
                        </div>
                        <div class="col-12 text-end">
                            <asp:Button ID="btnEnviar" runat="server" Text="Enviar Mensaje" CssClass="btn btn-primary fw-bold px-4 py-2" OnClick="btnEnviar_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Información Corporativa & Sede Parque Central -->
            <div class="col-lg-5">
                <div class="card card-tecno p-4 mb-4 border-0">
                    <h5 class="fw-bold text-dark mb-3">
                        <i class="bi bi-geo-alt-fill text-danger me-2"></i>Sede Principal Parque Central
                    </h5>
                    <p class="text-muted small mb-3">
                        Nuestra sede física cuenta con sala de exhibición interactiva donde podrá visualizar demostraciones de cámaras en vivo y probar la calidad de nuestros sistemas de alarma.
                    </p>
                    <ul class="list-unstyled small text-muted">
                        <li class="mb-3 d-flex align-items-start">
                            <i class="bi bi-building fs-5 text-primary me-2"></i>
                            <div>
                                <strong class="text-dark">Dirección:</strong><br />
                                Calle 50 con Carrera 44, Sector Parque Central<br />
                                Barranquilla, Atlántico - Colombia
                            </div>
                        </li>
                        <li class="mb-3 d-flex align-items-start">
                            <i class="bi bi-telephone fs-5 text-primary me-2"></i>
                            <div>
                                <strong class="text-dark">Teléfono PBX:</strong><br />
                                (605) 385-2000
                            </div>
                        </li>
                        <li class="mb-3 d-flex align-items-start">
                            <i class="bi bi-whatsapp fs-5 text-success me-2"></i>
                            <div>
                                <strong class="text-dark">WhatsApp Ventas e Instalaciones:</strong><br />
                                +57 300 123 4567
                            </div>
                        </li>
                        <li class="mb-3 d-flex align-items-start">
                            <i class="bi bi-envelope fs-5 text-warning me-2"></i>
                            <div>
                                <strong class="text-dark">Correo Electrónico:</strong><br />
                                ventas@tecnovigi.com | soporte@tecnovigi.com
                            </div>
                        </li>
                        <li class="d-flex align-items-start">
                            <i class="bi bi-clock fs-5 text-info me-2"></i>
                            <div>
                                <strong class="text-dark">Horario de Atención:</strong><br />
                                Lunes a Viernes: 8:00 AM - 6:00 PM<br />
                                Sábados: 8:00 AM - 2:00 PM
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
