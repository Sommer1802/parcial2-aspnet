<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PARCIAL2_ASP.NET._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hero Banner Principal -->
    <div class="hero-banner p-5 mb-5 rounded-4 shadow">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <span class="badge bg-info text-dark mb-3 px-3 py-2 fw-bold text-uppercase">
                    <i class="bi bi-geo-alt-fill me-1"></i>Parque Central • Barranquilla
                </span>
                <h1 class="display-4 fw-bold mb-3">TecnoVigi Barranquilla</h1>
                <p class="lead mb-4">
                    Soluciones integrales en <strong>venta e instalación de tecnología y seguridad electrónica</strong>. Desde ordenadores, impresoras y almacenamiento hasta los más modernos sistemas de vigilancia CCTV y alarmas para hogares, comercios y empresas en Barranquilla.
                </p>
                <div class="d-flex flex-wrap gap-3">
                    <a href="Productos.aspx" class="btn btn-warning btn-lg fw-bold shadow-sm">
                        <i class="bi bi-bag-check-fill me-2"></i>Ver Productos y Comprar
                    </a>
                    <a href="SVC.aspx" class="btn btn-outline-light btn-lg fw-bold">
                        <i class="bi bi-camera-video me-2"></i>Sistemas de Vigilancia
                    </a>
                </div>
            </div>
            <div class="col-lg-4 text-center d-none d-lg-block">
                <div class="p-4 bg-white bg-opacity-10 rounded-4 border border-light border-opacity-25 backdrop-blur">
                    <i class="bi bi-shield-fill-check display-1 text-info mb-3"></i>
                    <h4 class="fw-bold">Seguridad Garantizada</h4>
                    <p class="small text-light mb-0">Cámaras en tiempo real, alarmas inteligentes y respaldo técnico en Parque Central.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Servicios Principales -->
    <div class="mb-5">
        <div class="text-center mb-4">
            <span class="text-primary fw-bold text-uppercase small">Nuestras Especialidades</span>
            <h2 class="fw-bold text-dark">Servicios Profesionales de Instalación</h2>
            <p class="text-muted">Cubrimos todas las necesidades tecnológicas y de seguridad para su tranquilidad</p>
        </div>

        <div class="row g-4">
            <!-- Servicio 1: ALARMAS -->
            <div class="col-md-4">
                <div class="card card-tecno h-100 p-4 border-0">
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-warning bg-opacity-10 p-3 rounded-3 text-warning me-3">
                            <i class="bi bi-bell-fill fs-2"></i>
                        </div>
                        <div>
                            <h5 class="fw-bold mb-0">Sistemas de Alarmas</h5>
                            <span class="badge bg-warning text-dark">ALARMAS.ASPX</span>
                        </div>
                    </div>
                    <p class="text-muted flex-grow-1">
                        Instalación de centrales de alarma, sensores de movimiento, sensores de apertura de puertas/ventanas, sirenas de alta potencia y teclados de control inteligentes.
                    </p>
                    <a href="ALARMAS.aspx" class="btn btn-outline-primary fw-bold mt-2">
                        Ver Detalles del Servicio <i class="bi bi-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>

            <!-- Servicio 2: SVC -->
            <div class="col-md-4">
                <div class="card card-tecno h-100 p-4 border-0">
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-primary bg-opacity-10 p-3 rounded-3 text-primary me-3">
                            <i class="bi bi-camera-video-fill fs-2"></i>
                        </div>
                        <div>
                            <h5 class="fw-bold mb-0">Vigilancia y Control</h5>
                            <span class="badge bg-primary">SVC.ASPX</span>
                        </div>
                    </div>
                    <p class="text-muted flex-grow-1">
                        Cámaras fijas, giratorias motorizadas, digitales, analógicas, con zoom óptico e intensificador de luz nocturna. Monitoreo en vivo vía internet desde celular o PC hasta 64 cámaras.
                    </p>
                    <a href="SVC.aspx" class="btn btn-outline-primary fw-bold mt-2">
                        Ver Detalles del Servicio <i class="bi bi-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>

            <!-- Servicio 3: IMEI -->
            <div class="col-md-4">
                <div class="card card-tecno h-100 p-4 border-0">
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-success bg-opacity-10 p-3 rounded-3 text-success me-3">
                            <i class="bi bi-cpu-fill fs-2"></i>
                        </div>
                        <div>
                            <h5 class="fw-bold mb-0">Equipos Informáticos</h5>
                            <span class="badge bg-success">IMEI.ASPX</span>
                        </div>
                    </div>
                    <p class="text-muted flex-grow-1">
                        Instalación, mantenimiento preventivo y correctivo de ordenadores, servidores, impresoras multifuncionales y unidades de almacenamiento masivo.
                    </p>
                    <a href="IMEI.aspx" class="btn btn-outline-primary fw-bold mt-2">
                        Ver Detalles del Servicio <i class="bi bi-arrow-right ms-1"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Sección de Productos Destacados -->
    <div class="card card-tecno p-4 mb-5 border-0">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
            <div>
                <h3 class="fw-bold mb-1"><i class="bi bi-lightning-charge-fill text-warning me-2"></i>Productos Destacados en Tienda</h3>
                <p class="text-muted mb-0">Disponibles con entrega e instalación inmediata en Barranquilla</p>
            </div>
            <a href="Productos.aspx" class="btn btn-tecno">
                Ver Catálogo Completo <i class="bi bi-arrow-right-circle ms-1"></i>
            </a>
        </div>

        <div class="row g-4">
            <asp:Repeater ID="repDestacados" runat="server">
                <ItemTemplate>
                    <div class="col-lg-4 col-md-6">
                        <div class="card h-100 border rounded-3 p-3 shadow-sm hover-shadow">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <span class="badge bg-info text-dark fw-bold"><%# Eval("Categoria") %></span>
                                <span class="badge bg-success">Stock: <%# Eval("Stock") %> unid.</span>
                            </div>
                            <h5 class="fw-bold text-dark mt-2 mb-2"><%# Eval("Nombre") %></h5>
                            <p class="small text-muted flex-grow-1"><%# Eval("Descripcion") %></p>
                            <div class="d-flex justify-content-between align-items-center mt-3 pt-2 border-top">
                                <span class="fs-5 fw-bold text-primary">$ <%# string.Format("{0:N0}", Eval("Precio")) %> COP</span>
                                <a href="Productos.aspx" class="btn btn-sm btn-outline-primary fw-bold">
                                    <i class="bi bi-cart-plus me-1"></i>Comprar
                                </a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <!-- Información de la Empresa y Localización Parque Central -->
    <div class="row g-4 mb-4 align-items-center">
        <div class="col-lg-6">
            <div class="p-4 bg-white rounded-4 shadow-sm border h-100">
                <h4 class="fw-bold text-dark mb-3">
                    <i class="bi bi-building text-primary me-2"></i>Nuestra Sede en Parque Central - Barranquilla
                </h4>
                <p class="text-muted">
                    Nuestra empresa se encuentra ubicada en el prestigioso sector de <strong>Parque Central en la ciudad de Barranquilla</strong>, brindando a todos los clientes la posibilidad de consultar información, cotizar y solicitar pedidos desde cualquier lugar a través de nuestra moderna plataforma web.
                </p>
                <ul class="list-unstyled text-secondary">
                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i>Atención a usuarios visitantes, clientes registrados y corporativos.</li>
                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i>Gestión de pedidos en línea con confirmación inmediata y factura web.</li>
                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i>Personal técnico capacitado para instalaciones en toda la ciudad.</li>
                </ul>
                <div class="mt-4">
                    <a href="Contacto.aspx" class="btn btn-outline-primary me-2">
                        <i class="bi bi-geo-alt me-1"></i>Ver Ubicación y Contacto
                    </a>
                    <a href="Registro.aspx" class="btn btn-primary fw-bold">
                        <i class="bi bi-person-plus me-1"></i>Crear Cuenta de Cliente
                    </a>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="p-4 bg-light rounded-4 border h-100">
                <h4 class="fw-bold text-dark mb-3">
                    <i class="bi bi-cart-check text-success me-2"></i>¿Cómo Funciona el Proceso de Compra?
                </h4>
                <div class="d-flex mb-3">
                    <div class="me-3"><span class="badge bg-primary fs-5 rounded-circle p-2 px-3">1</span></div>
                    <div>
                        <h6 class="fw-bold mb-1">Explora nuestros productos y servicios</h6>
                        <p class="small text-muted mb-0">Revisa las especificaciones técnicas de cámaras, alarmas y equipos de cómputo.</p>
                    </div>
                </div>
                <div class="d-flex mb-3">
                    <div class="me-3"><span class="badge bg-primary fs-5 rounded-circle p-2 px-3">2</span></div>
                    <div>
                        <h6 class="fw-bold mb-1">Regístrate como Cliente</h6>
                        <p class="small text-muted mb-0">Crea tu usuario y contraseña en segundos para acceder al módulo de pedidos.</p>
                    </div>
                </div>
                <div class="d-flex mb-3">
                    <div class="me-3"><span class="badge bg-primary fs-5 rounded-circle p-2 px-3">3</span></div>
                    <div>
                        <h6 class="fw-bold mb-1">Genera tu Pedido y Realiza el Pago</h6>
                        <p class="small text-muted mb-0">Selecciona cantidades, confirma tu compra, elige tu método de pago y obtén tu factura web al instante.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
