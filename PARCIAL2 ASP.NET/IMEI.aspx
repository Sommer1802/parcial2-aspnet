<%@ Page Title="Instalación y Mantenimiento de Equipos Informáticos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="IMEI.aspx.cs" Inherits="PARCIAL2_ASP.NET.IMEI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="py-3">
        <!-- Encabezado de la página IMEI -->
        <div class="p-4 p-md-5 mb-4 rounded-4 text-white shadow-sm hero-imei">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <span class="badge bg-light text-success mb-2 px-3 py-1 fw-bold text-uppercase">
                        <i class="bi bi-cpu-fill me-1"></i>Página Oficial de Servicio: IMEI.ASPX
                    </span>
                    <h1 class="display-5 fw-bold">Instalación y Mantenimiento de Equipos Informáticos</h1>
                    <p class="lead mb-0">
                        En TecnoVigi Barranquilla garantizamos la máxima disponibilidad y rendimiento de su infraestructura tecnológica. Atendemos ordenadores de escritorio, portátiles, impresoras y unidades de almacenamiento en Parque Central y toda la ciudad.
                    </p>
                </div>
                <div class="col-lg-4 text-center d-none d-lg-block">
                    <i class="bi bi-pc-display-horizontal display-1 text-white opacity-75"></i>
                </div>
            </div>
        </div>

        <!-- Servicios informáticos -->
        <div class="row g-4 mb-5">
            <!-- Ordenadores y Laptops -->
            <div class="col-lg-4 col-md-6">
                <div class="card card-tecno h-100 p-4 border-0">
                    <div class="bg-success bg-opacity-10 text-success p-3 rounded-3 d-inline-block mb-3" style="width: fit-content;">
                        <i class="bi bi-laptop fs-2"></i>
                    </div>
                    <h5 class="fw-bold text-dark">Ordenadores y Portátiles</h5>
                    <p class="text-muted small">
                        Venta, ensamblaje personalizado y mantenimiento integral de computadores de escritorio y portátiles. Actualización de procesadores, aumento de memoria RAM e instalación de unidades de estado sólido (SSD).
                    </p>
                    <ul class="small text-muted ps-3 mb-0">
                        <li>Limpieza física interna y cambio de pasta térmica.</li>
                        <li>Optimización de sistemas operativos y eliminación de virus.</li>
                        <li>Instalación de software legal y paquetes ofimáticos.</li>
                    </ul>
                </div>
            </div>

            <!-- Impresoras y Escáneres -->
            <div class="col-lg-4 col-md-6">
                <div class="card card-tecno h-100 p-4 border-0">
                    <div class="bg-primary bg-opacity-10 text-primary p-3 rounded-3 d-inline-block mb-3" style="width: fit-content;">
                        <i class="bi bi-printer fs-2"></i>
                    </div>
                    <h5 class="fw-bold text-dark">Impresoras y Multifuncionales</h5>
                    <p class="text-muted small">
                        Instalación y mantenimiento de impresoras de inyección continua, láser y multifuncionales. Configuración de servidores de impresión por red inalámbrica y cableada.
                    </p>
                    <ul class="small text-muted ps-3 mb-0">
                        <li>Mantenimiento a rodillos, cabezales y almohadillas.</li>
                        <li>Configuración Wi-Fi e impresión móvil corporativa.</li>
                        <li>Diagnóstico de errores mecánicos y atascos de papel.</li>
                    </ul>
                </div>
            </div>

            <!-- Discos Duros y Almacenamiento -->
            <div class="col-lg-4 col-md-6">
                <div class="card card-tecno h-100 p-4 border-0">
                    <div class="bg-warning bg-opacity-10 text-warning p-3 rounded-3 d-inline-block mb-3" style="width: fit-content;">
                        <i class="bi bi-hdd-network fs-2"></i>
                    </div>
                    <h5 class="fw-bold text-dark">Discos Duros y Almacenamiento</h5>
                    <p class="text-muted small">
                        Soluciones de almacenamiento masivo y resguardo de información. Discos duros externos USB 3.0, discos internos mecánicos de alta capacidad y sistemas NAS para copias de seguridad.
                    </p>
                    <ul class="small text-muted ps-3 mb-0">
                        <li>Recuperación lógica de datos y diagnóstico SMART.</li>
                        <li>Migración y clonación de discos sin pérdida de datos.</li>
                        <li>Configuración de respaldos automáticos programados.</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Planes de Mantenimiento Preventivo y Correctivo -->
        <div class="card card-tecno p-4 mb-4 border-0">
            <h3 class="fw-bold text-dark mb-3"><i class="bi bi-tools text-success me-2"></i>Modalidades de Mantenimiento Tecnológico</h3>
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="p-3 border rounded-3 bg-light h-100">
                        <h5 class="fw-bold text-success"><i class="bi bi-shield-check me-2"></i>Mantenimiento Preventivo</h5>
                        <p class="small text-muted mb-2">
                            Previene fallas catastróficas y alarga la vida útil de sus equipos de cómputo e impresión. Incluye desensamble, eliminación de polvo y residuos, lubricación de ventiladores, verificación de voltajes y auditoría de seguridad de software.
                        </p>
                        <span class="badge bg-success">Recomendado cada 6 meses</span>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="p-3 border rounded-3 bg-light h-100">
                        <h5 class="fw-bold text-danger"><i class="bi bi-wrench-adjustable me-2"></i>Mantenimiento Correctivo</h5>
                        <p class="small text-muted mb-2">
                            Diagnóstico y reparación urgente ante fallos de encendido, pantallas azules, lentitud extrema, rotura de bisagras o daños por sobretensión eléctrica en la red de Barranquilla. Repuestos originales con garantía certificada.
                        </p>
                        <span class="badge bg-danger">Atención inmediata en Parque Central</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Contacto para soporte -->
        <div class="bg-light p-4 rounded-4 border text-center">
            <h4 class="fw-bold text-dark mb-2">¿Necesita soporte informático o repuestos para sus equipos?</h4>
            <p class="text-muted mb-3">Visítenos en Parque Central - Barranquilla o solicite la visita de un técnico especializado a su empresa o residencia.</p>
            <div class="d-flex justify-content-center gap-3">
                <a href="Productos.aspx" class="btn btn-success fw-bold px-4 py-2">
                    <i class="bi bi-cart me-2"></i>Comprar Equipos y Discos
                </a>
                <a href="Contacto.aspx" class="btn btn-outline-secondary px-4 py-2">
                    <i class="bi bi-calendar-check me-2"></i>Agendar Mantenimiento
                </a>
            </div>
        </div>
    </div>
</asp:Content>
