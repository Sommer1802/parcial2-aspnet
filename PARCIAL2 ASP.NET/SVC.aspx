<%@ Page Title="Instalación de Sistemas de Vigilancia y Control" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SVC.aspx.cs" Inherits="PARCIAL2_ASP.NET.SVC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="py-3">
        <!-- Encabezado de la página SVC -->
        <div class="p-4 p-md-5 mb-4 rounded-4 text-white shadow-sm hero-svc">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <span class="badge bg-light text-primary mb-2 px-3 py-1 fw-bold text-uppercase">
                        <i class="bi bi-camera-video-fill me-1"></i>Página Oficial de Servicio: SVC.ASPX
                    </span>
                    <h1 class="display-5 fw-bold">Instalación de Sistemas de Vigilancia y Control</h1>
                    <p class="lead mb-0">
                        TecnoVigi Barranquilla diseña e implementa circuitos cerrados de televisión (CCTV) y sistemas de videovigilancia inteligente de última generación desde nuestra sede en Parque Central.
                    </p>
                </div>
                <div class="col-lg-4 text-center d-none d-lg-block">
                    <i class="bi bi-camera-video display-1 text-white opacity-75"></i>
                </div>
            </div>
        </div>

        <!-- Capacidades Técnicas Clave Requeridas por el Examen -->
        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="card card-tecno h-100 p-4 border-0 text-center">
                    <div class="bg-primary bg-opacity-10 text-primary p-3 rounded-circle d-inline-block mx-auto mb-3">
                        <i class="bi bi-broadcast-pin fs-1"></i>
                    </div>
                    <h5 class="fw-bold text-dark">Video en Alta Resolución en Tiempo Real</h5>
                    <p class="text-muted small mb-0">
                        Con la ayuda de nuestros productos se pueden <strong>grabar imágenes de vídeo de alta resolución en tiempo real</strong>, asegurando nitidez total de rostros, matrículas y detalles críticos de día o de noche.
                    </p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card card-tecno h-100 p-4 border-0 text-center">
                    <div class="bg-info bg-opacity-10 text-info p-3 rounded-circle d-inline-block mx-auto mb-3">
                        <i class="bi bi-phone-vibrate fs-1"></i>
                    </div>
                    <h5 class="fw-bold text-dark">Monitoreo Remoto Celular &amp; PC</h5>
                    <p class="text-muted small mb-0">
                        Podrá <strong>vigilar cualquier sitio a distancia vía internet desde un ordenador o un teléfono móvil</strong> con aplicaciones dedicadas, recepción de alertas push y reproducción remota instantánea.
                    </p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card card-tecno h-100 p-4 border-0 text-center">
                    <div class="bg-success bg-opacity-10 text-success p-3 rounded-circle d-inline-block mx-auto mb-3">
                        <i class="bi bi-grid-3x3 fs-1"></i>
                    </div>
                    <h5 class="fw-bold text-dark">Hasta 64 Cámaras en Pantalla</h5>
                    <p class="text-muted small mb-0">
                        Nuestras centrales y software VMS permiten <strong>visualizar hasta 64 cámaras desde diferentes sitios en un sólo ordenador</strong> de manera centralizada y simultánea con control total de cada canal.
                    </p>
                </div>
            </div>
        </div>

        <!-- Tipos de Cámaras de Vigilancia que Ofrece TecnoVigi -->
        <div class="card card-tecno p-4 mb-5 border-0">
            <div class="d-flex align-items-center mb-4">
                <div class="bg-primary text-white p-2 rounded-3 me-3">
                    <i class="bi bi-camera-fill fs-3"></i>
                </div>
                <div>
                    <h3 class="fw-bold text-dark mb-0">Tecnologías de Cámaras Disponibles en Nuestro Catálogo</h3>
                    <p class="text-muted mb-0">Disponibles para venta e instalación inmediata en Parque Central, Barranquilla</p>
                </div>
            </div>

            <div class="row g-4">
                <!-- Cámara Fija -->
                <div class="col-md-6 col-lg-4">
                    <div class="p-3 border rounded-3 h-100 bg-light">
                        <div class="d-flex align-items-center mb-2">
                            <i class="bi bi-camera text-primary fs-3 me-2"></i>
                            <h5 class="fw-bold mb-0">Cámaras Fijas</h5>
                        </div>
                        <p class="small text-muted mb-0">
                            Diseñadas para vigilar puntos específicos e inamovibles como entradas, cajas registradoras, pasillos y áreas perimetrales con lente gran angular y carcasa antivandálica.
                        </p>
                    </div>
                </div>

                <!-- Cámara Giratoria -->
                <div class="col-md-6 col-lg-4">
                    <div class="p-3 border rounded-3 h-100 bg-light">
                        <div class="d-flex align-items-center mb-2">
                            <i class="bi bi-arrow-repeat text-info fs-3 me-2"></i>
                            <h5 class="fw-bold mb-0">Cámaras Giratorias (PTZ)</h5>
                        </div>
                        <p class="small text-muted mb-0">
                            Equipadas con motores de giro horizontal de 360° y vertical de 90°. Permiten patrullaje automático programado y control manual directo desde su smartphone o joystick.
                        </p>
                    </div>
                </div>

                <!-- Cámaras Digitales -->
                <div class="col-md-6 col-lg-4">
                    <div class="p-3 border rounded-3 h-100 bg-light">
                        <div class="d-flex align-items-center mb-2">
                            <i class="bi bi-router text-success fs-3 me-2"></i>
                            <h5 class="fw-bold mb-0">Cámaras Digitales (IP)</h5>
                        </div>
                        <p class="small text-muted mb-0">
                            Transmisión 100% digital a través de cable de red PoE o Wi-Fi con cifrado de seguridad, analítica de video por inteligencia artificial y almacenamiento directo.
                        </p>
                    </div>
                </div>

                <!-- Cámaras Analógicas -->
                <div class="col-md-6 col-lg-4">
                    <div class="p-3 border rounded-3 h-100 bg-light">
                        <div class="d-flex align-items-center mb-2">
                            <i class="bi bi-plug text-warning fs-3 me-2"></i>
                            <h5 class="fw-bold mb-0">Cámaras Analógicas HD</h5>
                        </div>
                        <p class="small text-muted mb-0">
                            Compatibles con sistemas de cable coaxial existentes bajo tecnología HD-TVI / AHD. Gran costo-beneficio para actualizar instalaciones antiguas a resolución 1080p y 4K.
                        </p>
                    </div>
                </div>

                <!-- Cámaras con Zoom -->
                <div class="col-md-6 col-lg-4">
                    <div class="p-3 border rounded-3 h-100 bg-light">
                        <div class="d-flex align-items-center mb-2">
                            <i class="bi bi-zoom-in text-danger fs-3 me-2"></i>
                            <h5 class="fw-bold mb-0">Cámaras con Zoom Óptico</h5>
                        </div>
                        <p class="small text-muted mb-0">
                            Lentes varifocales motorizados con zoom óptico real de 4X hasta 32X, permitiendo acercar áreas distantes sin perder ni un píxel de calidad en la imagen.
                        </p>
                    </div>
                </div>

                <!-- Cámaras con Intensificador de Luz -->
                <div class="col-md-6 col-lg-4">
                    <div class="p-3 border rounded-3 h-100 bg-light">
                        <div class="d-flex align-items-center mb-2">
                            <i class="bi bi-moon-stars text-secondary fs-3 me-2"></i>
                            <h5 class="fw-bold mb-0">Intensificador de Luz</h5>
                        </div>
                        <p class="small text-muted mb-0">
                            Tecnología ColorVu / Starlight con sensor ultrasensible que convierte la mínima luz ambiental en imágenes a todo color en plena oscuridad, sin deslumbramientos.
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Banner de Acción -->
        <div class="bg-light p-4 rounded-4 border text-center">
            <h4 class="fw-bold text-dark mb-2">¿Desea adquirir cámaras de vigilancia o agendar su instalación?</h4>
            <p class="text-muted mb-3">Todos nuestros modelos se encuentran ingresados en el aplicativo para compra en línea y cotización de instalación en Barranquilla.</p>
            <div class="d-flex justify-content-center gap-3">
                <a href="Productos.aspx" class="btn btn-primary fw-bold px-4 py-2">
                    <i class="bi bi-bag-check me-2"></i>Ir a Comprar en Línea
                </a>
                <a href="Contacto.aspx" class="btn btn-outline-secondary px-4 py-2">
                    <i class="bi bi-chat-dots me-2"></i>Contactar un Asesor
                </a>
            </div>
        </div>
    </div>
</asp:Content>
