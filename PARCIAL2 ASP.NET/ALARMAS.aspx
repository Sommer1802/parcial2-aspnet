<%@ Page Title="Instalación de Sistemas de Alarmas" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ALARMAS.aspx.cs" Inherits="PARCIAL2_ASP.NET.ALARMAS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="py-3">
        <!-- Encabezado de la página -->
        <div class="p-4 p-md-5 mb-4 rounded-4 text-white shadow-sm hero-alarmas">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <span class="badge bg-light text-dark mb-2 px-3 py-1 fw-bold text-uppercase">
                        <i class="bi bi-shield-lock-fill text-warning me-1"></i>Página Oficial de Servicio: ALARMAS.ASPX
                    </span>
                    <h1 class="display-5 fw-bold">Instalación de Sistemas de Alarmas</h1>
                    <p class="lead mb-0">
                        TecnoVigi Barranquilla pone a su disposición la más avanzada ingeniería en protección perimetral y detección de intrusos para residencias, bodegas, comercios y empresas en Parque Central y toda el área metropolitana de Barranquilla.
                    </p>
                </div>
                <div class="col-lg-4 text-center d-none d-lg-block">
                    <i class="bi bi-bell-fill display-1 text-white opacity-75"></i>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-5">
            <!-- Componentes del Sistema -->
            <div class="col-lg-8">
                <div class="card card-tecno p-4 mb-4 border-0">
                    <h3 class="fw-bold text-dark mb-3">
                        <i class="bi bi-cpu text-warning me-2"></i>Componentes de los Sistemas de Alarma
                    </h3>
                    <p class="text-muted">
                        Nuestras soluciones de alarma son totalmente integradas, modulares y adaptables a cualquier inmueble:
                    </p>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="p-3 border rounded-3 bg-light">
                                <h6 class="fw-bold text-dark"><i class="bi bi-motherboard text-primary me-2"></i>Central de Alarma Microprocesada</h6>
                                <p class="small text-muted mb-0">El cerebro del sistema, con respaldo de batería contra cortes de energía y comunicación IP / celular dual.</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="p-3 border rounded-3 bg-light">
                                <h6 class="fw-bold text-dark"><i class="bi bi-broadcast text-warning me-2"></i>Sensores de Movimiento PIR</h6>
                                <p class="small text-muted mb-0">Detectores infrarrojos pasivos con tecnología antimascotas para evitar falsas alarmas.</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="p-3 border rounded-3 bg-light">
                                <h6 class="fw-bold text-dark"><i class="bi bi-door-closed text-success me-2"></i>Contactos Magnéticos</h6>
                                <p class="small text-muted mb-0">Protección inmediata ante la apertura no autorizada de puertas principales, ventanas y portones.</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="p-3 border rounded-3 bg-light">
                                <h6 class="fw-bold text-dark"><i class="bi bi-megaphone-fill text-danger me-2"></i>Sirenas de Alta Potencia &amp; Teclado</h6>
                                <p class="small text-muted mb-0">Sirenas disuasivas de 120 dB con luz estroboscópica y teclados táctiles de fácil armado/desarmado.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Ventajas de Elegir TecnoVigi -->
                <div class="card card-tecno p-4 border-0">
                    <h3 class="fw-bold text-dark mb-3">
                        <i class="bi bi-star-fill text-warning me-2"></i>Ventajas de Nuestro Servicio en Barranquilla
                    </h3>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item d-flex align-items-center px-0">
                            <i class="bi bi-check-circle-fill text-success fs-5 me-3"></i>
                            <div>
                                <strong>Aviso Inmediato:</strong> Notificaciones instantáneas a su teléfono móvil y enlace directo ante cualquier intento de intrusión.
                            </div>
                        </li>
                        <li class="list-group-item d-flex align-items-center px-0">
                            <i class="bi bi-check-circle-fill text-success fs-5 me-3"></i>
                            <div>
                                <strong>Instalación Limpia y Rápida:</strong> Realizada por técnicos certificados sin afectar la estética ni la infraestructura de su propiedad.
                            </div>
                        </li>
                        <li class="list-group-item d-flex align-items-center px-0">
                            <i class="bi bi-check-circle-fill text-success fs-5 me-3"></i>
                            <div>
                                <strong>Asesoría Personalizada en Parque Central:</strong> Realizamos inspección y cotización sin costo para evaluar los puntos críticos de su predio.
                            </div>
                        </li>
                        <li class="list-group-item d-flex align-items-center px-0">
                            <i class="bi bi-check-circle-fill text-success fs-5 me-3"></i>
                            <div>
                                <strong>Garantía Real y Soporte Continuo:</strong> Garantía de 1 año en equipos e instalación con servicio de mantenimiento preventivo.
                            </div>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Columna lateral: Cotización / Comprar Productos de Alarma -->
            <div class="col-lg-4">
                <div class="card card-tecno p-4 mb-4 border-0 text-center">
                    <div class="bg-warning bg-opacity-10 text-warning p-3 rounded-circle d-inline-block mx-auto mb-3">
                        <i class="bi bi-cart-check-fill fs-1"></i>
                    </div>
                    <h4 class="fw-bold text-dark mb-2">Equipos de Alarma Disponibles</h4>
                    <p class="text-muted small">
                        Adquiere nuestros kits de alarma preconfigurados y solicita la instalación profesional en tu domicilio.
                    </p>
                    <a href="Productos.aspx" class="btn btn-warning w-100 fw-bold py-2 mb-2">
                        <i class="bi bi-bag-plus me-1"></i>Ver Kits en Catálogo
                    </a>
                    <a href="Contacto.aspx" class="btn btn-outline-secondary w-100 py-2">
                        <i class="bi bi-headset me-1"></i>Solicitar Asesoría Técnica
                    </a>
                </div>

                <div class="card card-tecno p-4 border-0 bg-primary text-white">
                    <h5 class="fw-bold mb-3"><i class="bi bi-telephone-inbound-fill me-2"></i>Línea de Atención Técnica</h5>
                    <p class="small mb-2">Sede Parque Central - Barranquilla:</p>
                    <h4 class="fw-bold mb-3 text-warning">PBX: (605) 385-2000</h4>
                    <p class="small mb-0 opacity-75">Horario de soporte técnico: Lunes a Sábado de 8:00 AM a 6:00 PM.</p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
